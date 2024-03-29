hostsupdate Cookbook CHANGELOG
=======================
This file
 is used to list changes made in each version of the hostsupdate cookbook.

v2.4.4 (2014-02-25)
-------------------
- Bump Berkshelf version
- Remove scope pieces from IPv6 addresses


v2.4.3 (2014-02-01)
-------------------

- Package custom ChefSpec matchers
- Update testing harness
- Avoid using `Chef::Application.fatal!`
- Use Chef::Resource::File for atomic updates


v2.4.2
------
- Fix Travis CI integration
- Remove newline characters
- Allow specifying a custom hostsupdate path


v2.4.1
------
- Force a new upload to the community site


v2.4.0
------
- Convert everything to Ruby 1.9 syntax because I'm tired of people removing trailing commas despite the **massive** warning in the README: ([#29](https://github.com/customink-webops/hostsupdate/issues/29), [#30](https://github.com/customink-webops/hostsupdate/issues/30), [#32](https://github.com/customink-webops/hostsupdate/issues/32), [#33](https://github.com/customink-webops/hostsupdate/issues/33), [#34](https://github.com/customink-webops/hostsupdate/issues/34), [#35](https://github.com/customink-webops/hostsupdate/issues/35), [#36](https://github.com/customink-webops/hostsupdate/issues/36), [#38](https://github.com/customink-webops/hostsupdate/issues/38), [#39](https://github.com/customink-webops/hostsupdate/issues/39))
- Update to the latest and greatest testing gems and practices
- Remove strainer in favor of a purer solution
- Update `.gitignore` to ignore additional files
- Add more platforms to the `.kitchen.yml`
- Use `converge_by` and support whyruny mode

v2.0.0
------
- Completely manage the hostsupdate, ensuring no duplicate entries

v1.0.2
------
- Support Windows (thanks @igantt-daptiv)
- Specs + Travis support
- Throw fatal error if hostsupdate does not exist (@jkerzner)
- Write priorities in hostsupdate so they are read on subsequent Chef runs

v0.2.0
------
- Updated README to require Ruby 1.9
- Allow hypens in hostnames
- Ensure newline at end of file
- Allow priority ordering in hostsupdate

v0.1.1
------
- Fixed issue #1
- Better unique object filtering
- Better handing of aliases

v0.1.0
------
- Initial release
