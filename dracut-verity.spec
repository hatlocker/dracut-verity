Name:           dracut-verity
Version:        1
Release:        1%{?dist}
Summary:        Dracut module to mount DM-Verity disks

License:        MIT
URL:            https://github.com/hatlocker/dracut-verity
Source0:        dracut-verity-%{version}.tar.gz

BuildRequires:  dracut
Requires:       dracut
Requires:       veritysetup

%description
Dracut module to mount DM-Verity disks

%prep
%autosetup

%install
mkdir -p %{buildroot}%{_prefix}/lib/dracut/modules.d/
cp -ar 90verity %{buildroot}%{_prefix}/lib/dracut/modules.d/

%files
%license LICENSE
%doc README.md
%{_prefix}/lib/dracut/modules.d/90verity

%changelog
* Mon Jul 24 2017 Patrick Uiterwijk <patrick@puiterwijk.org> 1-1
- new package built with tito
