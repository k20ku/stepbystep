CONFIG_PATH := ${HOME}/.stepbystep/cert/

.DEFAULT_GOAL := help

.PHONY: init
init: ## initialize the certificates's config path (at ~/.stepbystep/cert)

	mkdir -p ${CONFIG_PATH}
	mkdir -p cert

.PHONY: gencert
gencert: init ## generate local self-signed certificate

	step certificate create stepbystep-root-ca ca.pem ca-key.pem \
		--kty=EC --crv=P-256 \
		--profile root-ca \
		--no-password --insecure --force --subtle

	step certificate create stepbystep-service server.pem server-key.pem \
		--profile leaf \
		--not-after=8760h \
		--san localhost \
		--san 127.0.0.1 \
		--san stepbystep \
		--ca ca.pem --ca-key ca-key.pem \
		--no-password --insecure --force --subtle

	# local client
	step certificate create stepbystep-client client.pem client-key.pem \
		--profile leaf \
		--not-after=8760h \
		--san localhost \
		--san 127.0.0.1 \
		--ca ca.pem --ca-key ca-key.pem \
		--no-password --insecure --force --subtle

	cp -f *.pem cert
	mv -f *.pem ${CONFIG_PATH}

.PHONY: clean
clean: ## clean old certificates config (~/.stepbystep/cert)

	rm -f ${CONFIG_PATH}/*.pem

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help ## show options
help:

	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	 sort | \
	 awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'