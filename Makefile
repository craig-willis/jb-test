
BUILDDIR      = _build
JB_IMAGE      = craigwillis/jupyter-book
TROV_VERSION  = 0.1

.PHONY: clean jb-image docs trov

clean:
	rm -rf $(BUILDDIR)

jb-image:
	docker build -t $(JB_IMAGE) .

docs:
	docker run -it --rm  -v `pwd`:/src $(JB_IMAGE) jupyter-book build --all .

trov:
	mkdir -p _build/html/specifications/trov/$(TROV_VERSION)/
	docker run -ti --rm \
  	  -v `pwd`/specifications:/usr/local/widoco/in \
  	  -v `pwd`/_build/html/specifications/$(TROV_VERSION)/:/usr/local/widoco/out \
  	  dgarijo/widoco -ontFile in/trov/$(TROV_VERSION)/trov.ttl -outFolder out -rewriteAll
