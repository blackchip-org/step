# Copyright 2013 blackchip.org
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DESTDIR=/usr/local

all: man

man:
	mkdir -p build/man
	rst2man doc/step-overview.7.rst build/man/step-overview.7 
	cat build/man/step-overview.7 | gzip > build/man/step-overview.7.gz
	rst2man doc/run.1.rst build/man/run.1
	cat build/man/run.1 | gzip > build/man/run.1.gz
	rst2man doc/step.7.rst build/man/step.7
	cat build/man/step.7 | gzip > build/man/step.7.gz

install: man
	install -m 755 -d $(DESTDIR)/bin
	install -m 755 bin/run $(DESTDIR)/bin/run
	install -m 755 -d $(DESTDIR)/share
	install -m 644 share/step $(DESTDIR)/share

	install -m 755 -d $(DESTDIR)/share/man/man1
	cp build/man/*.1.gz $(DESTDIR)/share/man/man1

	install -m 755 -d $(DESTDIR)/share/man/man7
	cp build/man/*.7.gz $(DESTDIR)/share/man/man7

	install -m 755 -d $(DESTDIR)/share/doc/step/examples
	cp examples/* $(DESTDIR)/share/doc/step/examples

.PHONY: test
test:
	etc/run_tests.sh

rpm: man
	etc/make_artifact.sh
	mkdir -p build/rpm/BUILD
	mkdir -p build/rpm/BUILDROOT
	rpmbuild -ba \
		--define _topdir\ "${PWD}/build/rpm" \
		etc/step.spec

clean:
	rm -rf build
