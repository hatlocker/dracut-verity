Name:           dracut-verity
Version:        3
Release:        1
Summary:        Dracut module to mount DM-Verity disks

License:        MIT
URL:            https://github.com/hatlocker/dracut-verity
Source0:        dracut-verity-%{version}.tar.gz

BuildRequires:  dracut
BuildRequires:	e2fsprogs-devel
Requires:       dracut
Requires:       veritysetup

%description
Dracut module to mount DM-Verity disks

%prep
%autosetup

%build
gcc e2size.c -l ext2fs -o e2size

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_prefix}/lib/dracut/modules.d/
cp -a e2size %{buildroot}%{_bindir}
cp -ar 10verity %{buildroot}%{_prefix}/lib/dracut/modules.d/

%files
%license LICENSE
%doc README.md
%{_bindir}/e2size
%{_prefix}/lib/dracut/modules.d/10verity

%changelog
* Wed Jul 26 2017 Patrick Uiterwijk <patrick@puiterwijk.org> 3-1
- Remove my custom work to stand on the shoulder of coreos
  (patrick@puiterwijk.org)

* Tue Jul 25 2017 Patrick Uiterwijk <patrick@puiterwijk.org> 2-1
- Allow providing the hash offset (patrick@puiterwijk.org)

* Mon Jul 24 2017 Patrick Uiterwijk <patrick@puiterwijk.org> 1-2
- Add veritysetup Requires (patrick@puiterwijk.org)

* Mon Jul 24 2017 Patrick Uiterwijk <patrick@puiterwijk.org> 1-1
- new package built with tito
