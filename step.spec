Name:		step
Version:	0.1.0
Release:	1%{?dist}
Summary:	Breaks up bash scripts into steps

License:	ASL 2.0
URL:		https://github.com/blackchip-org/step
Source0:	%{name}.tar.gz

BuildArch:      noarch

%description
Breaks up bash scripts into steps

See https://githug.com/blackchip-org/step for more information.

%prep
%setup -q -n %{name}


%build


%install
rm -rf %{buildroot}
install -m 755 -D step %{buildroot}/%{_datadir}/step


%clean
rm -rf %{buildroot}


%files
%defattr(-,root,root,-)
%doc README.md LICENSE
%{_datadir}/step


%changelog
* Mon May 13 2013 Mike McGann <mike.mcgann@blackchip.org> - 0.1.0-1
- Initial package
