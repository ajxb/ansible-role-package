# [package](#package)

Manage system repositories and packages

## [Requirements](#requirements)

None

## [Role Variables](#role-variables)

| Name | Description | Default |
| --- | --- | --- |
| package_repositories | A list of repositories to be installed | `[]` |
| package_packages | A list of packages to be installed | `[]` |
| package_python_packages | A list of Python packages to be installed | `[]` |

## [Dependencies](#dependencies)

None

## [Example Playbook](#example-playbook)

Add the google chrome repository and install the google chrome package

```yaml
---
- name: Add the google chrome repository and install the google chrome package
  hosts: all
  roles:
    - role: ajxb.package
      vars:
        package_repositories:
          - {
              name: google-chrome,
              baseurl: "https://dl.google.com/linux/chrome/rpm/stable/x86_64",
              enabled: true,
              gpgcheck: true,
              gpgkey: "https://dl.google.com/linux/linux_signing_key.pub",
            }
        package_packages:
          - google-chrome-stable
```

## [License](#license)

[Apache-2.0](LICENSE)
