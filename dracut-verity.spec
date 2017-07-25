Name:           dracut-verity
Version:        2
Release:        1
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
* Tue Jul 25 2017 Patrick Uiterwijk <patrick@puiterwijk.org> 2-1
- Allow providing the hash offset (patrick@puiterwijk.org)

* Mon Jul 24 2017 Patrick Uiterwijk <patrick@puiterwijk.org> 1-2
- Add veritysetup Requires (patrick@puiterwijk.org)

* Mon Jul 24 2017 Patrick Uiterwijk <patrick@puiterwijk.org> 1-1
- new package built with tito
