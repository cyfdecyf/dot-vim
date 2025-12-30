#!/usr/bin/python

# Copyright 2006 Lawrence Kesteloot

#
# Generates a vim help file which is a permuted index of all
# options and ex commands.
#
# Usage:
#
#     vim_permuted_index.py [vimdir]
#
# Where vimdir is where your vim installation files are.  It
# defaults to "/usr/share/vim/vim70".
#
# The output is to stdout.  Put the output into your "doc" directory
# and run ":helptags" on that directory.  Then type ":help permuted-index"
# to get the index.
#

import sys, re, os

def get_ex_lines(doc):
    # Load lines for ex commands.
    lines = file(doc + "/index.txt").readlines()

    # Remove \n.
    lines = [line[:-1] for line in lines]

    # Find first line of ex reference.
    for i in range(len(lines)):
        if lines[i].find("*ex-cmd-index*") >= 0:
            del lines[:i]
            break
    else:
        sys.stderr.write("Did not find *ex-cmd-index*\n")
        sys.exit(-1)

    # Find first line with a command.
    for i in range(len(lines)):
        if len(lines[i]) > 0 and lines[i][0] == '|':
            del lines[:i]
            break
    else:
        sys.stderr.write("Did not find first ex command\n")
        sys.exit(-1)

    # Skip to next blank line.
    for i in range(len(lines)):
        if len(lines[i]) == 0:
            del lines[i:]
            break
    else:
        sys.stderr.write("Did not find end of ex commands\n")
        sys.exit(-1)

    # Unwrap lines.
    i = 0
    while i < len(lines) - 1:
        next_line = lines[i + 1]

        if len(next_line) > 0 and \
                (next_line[0] == ' ' or next_line[0] == '\t'):

            lines[i] = lines[i] + ' ' + next_line.strip()
            del lines[i + 1]
        else:
            i = i + 1

    # Split at tabs.
    lines = [line.split(None, 2) for line in lines]

    # Remove second column.
    lines = [(line[0], line[2]) for line in lines]

    return lines

def get_opt_lines(doc):
    # Load lines for options.
    lines = file(doc + "/quickref.txt").readlines()

    # Remove \n.
    lines = [line[:-1] for line in lines]

    # Find first line of options.
    for i in range(len(lines)):
        if lines[i].find("*option-list*") >= 0:
            del lines[:i + 1]
            break
    else:
        sys.stderr.write("Did not find *option-list*\n")
        sys.exit(-1)

    # Skip to end of section.
    for i in range(len(lines)):
        if lines[i].find("--------") >= 0:
            del lines[i:]
            break
    else:
        sys.stderr.write("Did not find end of options\n")
        sys.exit(-1)

    # Unwrap lines. Doesn't seem to happen with options.
    i = 0
    while i < len(lines) - 1:
        next_line = lines[i + 1]

        if len(next_line) > 0 and \
                (next_line[0] == ' ' or next_line[0] == '\t'):

            lines[i] = lines[i] + ' ' + next_line.strip()
            del lines[i + 1]
        else:
            i = i + 1

    # Expand tabs, since tab usage is inconsistent.
    lines = [line.expandtabs() for line in lines]

    # Keep full opt and summary.  This depends on specific layout.
    lines = [(line[:18].strip(), line[28:].strip()) for line in lines]

    return lines

# Represents each line in the output.
class Entry:
    def __init__(self, tag, summary, index):
        # The vim feature (ex command, option).
        self.tag = tag

        # The summary of its description.
        self.summary = summary

        # The location within the summary where we're sorting.
        self.index = index

    # Returns the part at and after the sorting word.
    def get_key(self):
        return self.summary[self.index:]

    # Compares by key, breaking ties with summary.  Both
    # are case-insensitive.
    def __cmp__(self, rhs):
        c = cmp(self.get_key().lower(), rhs.get_key().lower())
        if c != 0:
            return c

        return cmp(self.summary.lower(), rhs.summary.lower())

    # Returns the sum of the tag word plus the index, basically
    # everything to the left of the sorted word.
    def get_prefix_length(self):
        return len(self.tag) + self.index

# It's not useful to index these.
def is_common_word(word):
    return word.lower() in ["a", "an", "the", "for", "to", "in", "of",
            "and", "go", "or", "but", "use", "like", "with", "that",
            "from", "be", "one", "as", "is", "when", "do", "how", "on",
            "not", "are"]

def generate_permuted_index(lines):
    entries = []
    words = {}

    for line in lines:
        # Find all words.
        matches = re.finditer(r'\b[a-zA-Z0-9]+', line[1])

        for match in matches:
            word = match.group()

            if not is_common_word(word):
                entries.append(Entry(line[0], line[1], match.start()))

                # Count the number of times we see this.
                if word not in words:
                    words[word] = 1
                else:
                    words[word] = words[word] + 1

    # Sort entries by string at index.
    entries.sort()

    return entries, words

# Display the most-used words.
def display_words(words):
    # Turn the words into an array.
    words = words.items()

    # Sort by reverse count.
    words.sort(None, lambda word: word[1], True)

    # Only keep the top 40.
    del words[40:]

    # Print the rest
    for word in words:
        print word[0], word[1]

# Find vim doc files.
if len(sys.argv) > 1:
    vim = sys.argv[1]
else:
    vim = "/usr/share/vim/vim73"

# Quicky check.
if not os.access(vim, os.F_OK):
    sys.stderr.write("No vim installation at \"" + vim + "\".\n")
    sys.exit(-1)

doc = vim + "/doc"

# Get the summary lines from the help files.
try:
    ex = get_ex_lines(doc)
    opts = get_opt_lines(doc)
except IOError:
    sys.stderr.write("Cannot open files in \"" + doc + "\".\n")
    sys.exit(-1)

# Figure out all the permuted entries (and used words).
entries, words = generate_permuted_index(ex + opts)

# Get prefix length of each.
prefix_length = [entry.get_prefix_length() for entry in entries]

# Get max of that.
max_prefix_length = max(prefix_length)

# Print header.
print "*permuted-index*  (see http://www.teamten.com/lawrence/projects/vim_permuted_index/)"

print

# Print each entry.
for entry in entries:
    spacing = max_prefix_length - entry.get_prefix_length() + 1
    print entry.tag + (" " * spacing) + entry.summary

# Print footer.  We split the string so that vim doesn't interpret this
# line when loading this source file.
print
print " vi" + "m:tw=78:fo=tcq2:isk=!-~,^*,^\|,^\":ts=8:ft=help:norl:nowrap"

# For debugging is_common_word():
# display_words(words)

