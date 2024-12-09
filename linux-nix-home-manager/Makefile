.PHONY: help
help:
	@echo "Commands:"
	@echo "update       : Updates home."
	@echo "update-trace : Updates home and shows the full trace."
	@echo "conf         : Enables nix-command and flakes, only use if ~/.config/nix/nix.conf is empty"

.PHONY: update
update:
	home-manager switch --flake .#eric -b backup

.PHONY: update-trace
update-trace:
	home-manager switch --flake .#eric -b backup --show-trace

.PHONY: conf
conf:
	echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
