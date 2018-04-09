# git-commit-annotate

Annotate the HEAD commit object in a git repository.

The annotation is not visible in `git log` or other porcelain commands. It can
be viewed by checking `git cat-file commit HASH`.

## Use

    $ git-commit-annotate [OPTION]

Options:

    -h, --help                  Print help and exit
    -a, --annotate ANNOTATION   Annotate HEAD with message
    -r, --remove                Remove annotation from HEAD

The `annotate` and `remove` options are mutually exclusive. Annotating a commit
with an empty message is equivalent to `remove`. A commit object may only carry
one annotation.

Only HEAD can be annotated, as doing so changes the SHA1 of the commit, and we
don't want to deal with the consequences of that for commits that have
children.

## But why?

To hide the nonce we use when mining git commit hashes, obviously.

## Thanks

To Tom van der Woerdt, who came up with this in the first place. This project
is just a reverse-engineering of his idea.
