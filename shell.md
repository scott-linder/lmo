1. Shell
--------

The shell is the traditional interface to the OS. If you consider the OS to be
a sphere, containing a "kernel" at it's core (we will return to this concept
later, but for now please accept that "Linux" is what is formally known as the
OS "kernel"), containing all of the various components required to make the
computer run, then the shell can be considered a literal "shell", wrapped
around the core OS. If you think of it this way, then all of your interactions
with the OS must pass through the shell first, and this is generally the case.

### Filesystem ###

As I mentioned, many concepts intertwine, and it can be difficult to
disentangle them, so I will mention a concept integral to the shell here: the
filesystem. The filesystem is a hierarchy of "directories" (folders, in the
desktop metaphor), which can contain more directories and "files", which
contain arbitrary data. Both of these components, directories and files, have
names by which they can be identified. A "path" is the term used to describe
such a name, and is an ordered list of directories, optionally terminated by a
file.

It is perhaps easiest to see some examples. The simplest path is `/`, which
identifies the "root" directory, which is omnipresent. All other paths can
be expressed relative to this (that is, "below" this), such as `/home` for
the home directory, and `/etc/motd` for the message-of-the-day file.

One point that may cause confusion is that the `/` symbol is used both to
identify the root directory (when it is the first component in the path) and to
separate components in the path. One might equally well represent the previous
examples as `/,home` and `/,etc,motd` if a comma were used to separate path
components. This may be confusing at first, but will become second nature.

Finally, the shell has a "working directory", which represents its "position"
in the filesystem. If you know what this is, you can simplify paths through
expressing them in relative terms by omitting the working directory from
the path. As an example, if your current directory is `/etc` and you would like
to refer to the `motd` file, then the paths `/etc/motd` and just `motd` are
equivalent.

If you think of a path as directions to a location, then the difference between
absolute and relative paths becomes one of convenience: if you are giving
someone directions, they will most likely want them relative to their current
location (e.g. "go down this road and take your first right"), rather than
absolute (e.g. "it is at latitude 35.4 and longitude 45.3 at an elevation of
600 feet). In terms of a filesystem it is often, but not always, a matter of
convenience to make a decision between relative and absolute paths.

If you do not understand these concepts now, don't worry: we will come back to
them in more detail later. I present this in the hopes that it will help you
understand some of the shell concepts in this section, but you can also take
this for granted and still understand the usage of the shell.

### `fish` ###

The shell I have chosen for your introduction to Linux is called `fish`. It
follows a long-standing tradition which requires all shells end with the
suffix "sh", which was the original abbreviation of *sh*ell in it's first
incarnation, the Bourne shell.

Fish may be considered "non-standard" in that it is only related to the
original Bourne shell in it's overall structure; the two are largely
incompatible with one another. As the Bourne shell and it's descendants
such as `bash` (the "Bourne-again" shell) are almost ubiquitous in the Linux
ecosystem, I make the choice to use an incompatible shell with much
trepidation. However, I am confident that `fish` will be a much friendlier
and easier introduction than any Bourne compatible shell can provide (after all,
"fish" is an initialism for "Friendly Interactive SHell"), and that it will
be easier to learn more standard shells once one is already familiar with
a more intuitive alternative.

### Running the OS ###

In order to explain the shell concepts, it will be beneficial for you to obtain
a copy of the OS image which accompanies this book and run it on a physical
or "virtual" machine. Instructions will be provided in an Appendix for doing
so, and I will assume from this point on that you have a working system
in which to complete examples.

### "Welcome to fish..." ###

When you first start your machine, you will be greeted with a few messages:

    Arch Linux 4.0.5-1-ARCH (tty1)

    archiso login: root (automatic login)
    Welcome to fish, the friendly interactive shell
    Type help for instructions on how to use fish
    [root@archiso][~]#

For now, I will ask that you ignore the first couple of lines of text; we will
return to them later, but suffice to say they indicate what OS is running
and that you are being logged in as a user called "root".

From there, `fish` starts running and presents you with a welcome message and
finally a prompt. The prompt contains some useful information (again we see
that you are logged in as a user called "root"), but we will again ignore this
for now. All you need to concern yourself with presently is that the shell is
waiting for you to begin entering input, hence the term "prompt". It will wait
here until you begin to type.

### Syntax ###

The immediate question is "for what is the shell prompting"? The simple answer
is: commands. The longer answer is that the shell understands a certain
"language" composed of characters you can type. In this language, much like in
natural language, there are words, different "parts of speech", and
punctuation. These can be composed in various ways to instruct the shell to
do various things.

Unlike natural language, however, these rules are often very simple and very
strict: there is no room for ambiguity here. In English one might say
"We saw her duck." but this is ambiguous: is "duck" in the sense of a noun
or a verb? These cases are often decided by subtle contextual queues, but
misunderstandings are all too common as well. In order to avoid these issues
the rules of the language understood by the shell are well defined; these
rules are formally termed the "syntax" of the language.

To begin, we will reconstruct the command `echo hello fish`. To start, try
transcribing this command letter-for-letter at the command prompt, then hit the
carriage return (Enter) key. You should be greeted by "hello fish", followed
by another prompt.

    [root@archiso][~]# echo hello fish
    hello fish
    [root@archiso][~]#

You will also notice that as you type characters, the color of the words change
dynamically, and suggestions are populated for you automatically in an "onion
skin" manner. Do not worry about this now, but it will quickly come in handy
as we begin to learn many new commands.

In general the form of a shell command is always:

    "verb noun noun noun ..."

Thus, the first word in each line is special, as it indicates the action to
perform. The remaining words are collectively termed the "arguments" to
the command, and are interpreted by the command, in this case being "echoed"
back.

One notices that a "complete sentence" in this language does not necessarily
include punctuation: in this case all we used were words. In English it is
typically required to end every sentence with a period, but as long as there is
only one sentence in a paragraph one can be understood without such formalism.
In the shell language punctuation of this kind is not required where it is
unambiguous; if one thinks of a line at the command prompt as analogous to a
paragraph in English, one can easily omit the trailing period if there is only
one such command.

However, it is often useful to compose many commands together at one prompt. In
order to do this, the semicolon (;) is used, although it is analogous to the
period in English as it is used to separate commands which do not depend on one
another.

As an example, let us extend our previous example by running `echo hello fish;
echo goodbye fish`. In this case there will be two lines of output before
the next prompt.

    [root@archiso][~]# echo hello fish; echo goodbye fish
    hello fish
    goodbye fish
    [root@archiso][~]#

The shell, in reading our commands, separated the line into its two constituent
commands and executed each separately.

#### Paths ####

Often the `noun` components are paths to files and directories. For example,
the program `cat` takes a list of zero or more paths to files, and outputs
their contents one at a time. The name is derived from the term "concatenate"
which means to put together. An example of the use of `cat` might be
to view the contents of the message-of-the-day file:

    [root@archiso][~]# cat /etc/motd
    TODO: Output

#### Flags ####

Perhaps just as common as path arguments are "flag" arguments. The purpose of
flags is to switch on and off functionality, or to indicate the presence of
optional arguments.

By convention, most programs will expect flags to be prefixed with a hyphen
(also referred to as minus, or sometimes "tac") character: "-". Traditionally,
"short" flags consist of just the hyphen and one letter: `-a` is an example of
a short flag. Often, each short flag has an equivalent "long" flag, which is
usually prefixed with an extra hyphen and which can contain many characters:
`--all` is an example of a long flag (which may be the long form of the `-a`
flag).
