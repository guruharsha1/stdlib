#/
# @license Apache-2.0
#
# Copyright (c) 2017 The Stdlib Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#/

# VARIABLES #

# Define a suffix for pretty printing results as a list:
find_print_tests_dirs_list := -exec printf '%s\n' {} \;

# Define the command flags:
FIND_TESTS_DIRS_FLAGS ?= \
	-type d \
	-name "$(TESTS_FOLDER)" \
	-regex "$(TESTS_FILTER)" \
	-not -path "$(ROOT_DIR)/.*" \
	-not -path "$(NODE_MODULES)/*" \
	-not -path "$(DOCS_DIR)/**/$(NODE_MODULES_FOLDER)/*" \
	-not -path "$(TOOLS_DIR)/*" \
	-not -path "$(TOOLS_PKGS_DIR)/*" \
	-not -path "$(BUILD_DIR)/*" \
	-not -path "$(DIST_DIR)/*" \
	-not -path "$(DEPS_DIR)/*" \
	-not -path "$(REPORTS_DIR)/*" \
	-not -path "$(ROOT_DIR)/**/$(BUILD_FOLDER)/*"

ifneq ($(OS), Darwin)
	FIND_TESTS_DIRS_FLAGS := -regextype posix-extended $(FIND_TESTS_DIRS_FLAGS)
endif

# Define a command to list test directories:
FIND_TESTS_DIRS_CMD ?= find $(find_kernel_prefix) $(ROOT_DIR) $(FIND_TESTS_DIRS_FLAGS)

# Define the list of test directories:
TESTS_DIRS ?= $(shell $(FIND_TESTS_DIRS_CMD))


# TARGETS #

# List test directories.
#
# This target prints a newline-delimited list of test directories.

list-tests-dirs:
	$(QUIET) find $(find_kernel_prefix) $(ROOT_DIR) $(FIND_TESTS_DIRS_FLAGS) $(find_print_tests_dirs_list)

.PHONY: list-tests-dirs
