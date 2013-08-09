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

all: build

build:
	@echo "Nothing to build: Install with 'make install'"

install:
	install -m 755 -d $(DESTDIR)/bin
	install -m 755 step.sh $(DESTDIR)/bin/step
	install -m 755 -d $(DESTDIR)/share
	install -m 644 step.lib.sh $(DESTDIR)/share/step
