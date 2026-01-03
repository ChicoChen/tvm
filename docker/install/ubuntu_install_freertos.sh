#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

set -e
set -u
set -o pipefail
set -x

FREERTOS_VERSION=202112.00
FREERTOS_HASH=8f883a1278d070cd63d881433536d9a5ea7813bb262c9a61e328c8b72a1fee8ae3757bf39857659383c00ecb73e702559f747d7f8877a7cc959a25f309f8f640
FREERTOS_PATH=/opt/freertos

tmpdir=$(mktemp -d)

cleanup()
{
  rm -rf "$tmpdir"
}

trap cleanup 0

archive_dir=FreeRTOSv${FREERTOS_VERSION}
archive_file=${archive_dir}.zip
archive_url=https://github.com/FreeRTOS/FreeRTOS/releases/download/${FREERTOS_VERSION}/${archive_file}

cd ${tmpdir}
curl -sL "${archive_url}" -o "${archive_file}"
echo ${FREERTOS_HASH} ${archive_file} | sha512sum -c
unzip -q "${archive_file}" -d "${FREERTOS_PATH}"
