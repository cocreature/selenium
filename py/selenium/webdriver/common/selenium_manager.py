# Licensed to the Software Freedom Conservancy (SFC) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The SFC licenses this file
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
import logging
import os
import subprocess
import sys

logger = logging.getLogger(__name__)


class SeleniumManager:
    """
    Wrapper for getting information from the Selenium Manager binaries.
    """

    @classmethod
    def driver_location(cls, browser: str) -> str:
        """
        Determines the path of the correct driver.
        :Args:
         - browser: which browser to get the driver path for.
        :Returns: The driver path to use
        """
        directory = sys.platform
        if directory == "linux":
            directory = "linux"
        elif directory == "darwin":
            directory = "macos"
        elif directory == "win32" or directory == "cygwin":
            directory = "windows"

        file = "selenium-manager.exe" if directory == "windows" else "selenium-manager"

        path = os.path.join(os.path.dirname(__file__), directory, file)
        args = [path, "--browser", browser]
        logger.info("executing selenium manager with: " + " ".join(args))
        result = subprocess.run(args, stdout=subprocess.PIPE)
        command = result.stdout.decode("utf-8").split("\t")[-1].strip()
        logger.info("using driver at: " + command)
        return command
