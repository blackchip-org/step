Name:		step
Version:	2.0.0
Release:	1%{?dist}
Summary:	Breaks up bash scripts into steps

License:	ASL 2.0
URL:		https://github.com/blackchip-org/step
Source0:	%{name}.tar.bz2

BuildArch:      noarch

BuildRequires:	docutils

%description
Breaks up bash scripts into steps

See https://github.com/blackchip-org/step for more information.

%prep
%setup -q -n %{name}


%build
make


%install
rm -rf %{buildroot}
make install DESTDIR=%{buildroot}/usr


%clean
rm -rf %{buildroot}


%files
%defattr(-,root,root,-)
%doc README.md LICENSE
%{_bindir}/*
%{_datadir}/step
%{_mandir}/*/*
%{_docdir}/step


%changelog
* Mon Sep 2 2013 Mike McGann <mike.mcgann@blackchip.org> - 1.0.1-1
- Fixes 12 and 13

* Sat Aug 10 2013 Mike McGann <mike.mcgann@blackchip.org> - 1.0.0-1
- The --list option can now be used as a dry-run
- Created man page
- Error message shown when no command is run
- Created Makefile

* Tue May 21 2013 Mike McGann <mike.mcgann@blackchip.org> - 0.3.0-1
- Now invoked by step wrapper script
- Feature to skip steps added

* Tue May 14 2013 Mike McGann <mike.mcgann@blackchip.org> - 0.2.0-1
- Steps can now be listed with --list or -l
- Failure reported when selecting only one step or a starting step
  that does not exist.

* Mon May 13 2013 Mike McGann <mike.mcgann@blackchip.org> - 0.1.0-1
- Initial package
