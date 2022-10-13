# frozen_string_literal: true

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

module Selenium
  module WebDriver
    #
    # Wrapper for getting information from the Selenium Manager binaries.
    # @api private
    #
    class SeleniumManager
      BIN_PATH = "../../../../../bin"

      # @param [String] driver_name which driver to use.
      # @return [String] the path to the correct driver.
      def self.driver_location(driver_name)
        return unless %w[chromedriver geckodriver msedgedriver].include?(driver_name)

        path = File.expand_path(BIN_PATH, __FILE__)
        path << if Platform.windows?
                  '/windows/selenium-manager.exe'
                elsif Platform.mac?
                  '/macos/selenium-manager'
                elsif Platform.linux?
                  '/linux/selenium-manager'
                end
        path = File.expand_path(path, __FILE__)
        command = "#{path} --driver #{driver_name}"
        WebDriver.logger.debug("Executing Process #{command}")
        location = `#{command}`.split("\t").last.strip
        WebDriver.logger.debug("Driver found at #{location}")
        location
      end
    end # SeleniumManager
  end # WebDriver
end # Selenium
