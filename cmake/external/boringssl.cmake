# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include(ExternalProject)

if(TARGET boringssl OR NOT DOWNLOAD_BORINGSSL)
  return()
endif()

set(patch_file 
  ${CMAKE_CURRENT_LIST_DIR}/../../scripts/git/patches/boringssl/0001-disable-warnings.patch)

set(boringssl_commit_tag 83da28a68f32023fd3b95a8ae94991a07b1f6c62)

ExternalProject_Add(
  boringssl
  
  DOWNLOAD_COMMAND 
    COMMAND git init boringssl
    COMMAND cd boringssl && git fetch --depth=1 https://github.com/google/boringssl.git ${boringssl_commit_tag} && git reset --hard FETCH_HEAD

  PATCH_COMMAND git apply ${patch_file} && git gc --aggressive
  PREFIX ${PROJECT_BINARY_DIR}
  CONFIGURE_COMMAND ""
  BUILD_COMMAND     ""
  INSTALL_COMMAND   ""
  TEST_COMMAND      ""
  HTTP_HEADER	    "${EXTERNAL_PROJECT_HTTP_HEADER}"
)

