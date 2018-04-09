bin=git-commit-annotate
test=test.sh

check: $(bin) $(test)
	./$(test)

install: check
	install $(bin) ${HOME}/.local/bin
