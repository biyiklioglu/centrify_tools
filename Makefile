NAME=centrify_tools
VERSION=$(shell cat VERSION)
RELEASE=$(shell cat RELEASE)
TMPDIR=$(shell pwd)/.build

all: rpm

clean:
	rm -rf ${NAME}*.rpm
	rm -rf ${NAME}*.pkg
	rm -rf ${NAME}*.dmg
	rm -rf ${TMPDIR}

rpm:
	mkdir -p ${TMPDIR}/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
	sed -e "s/%VERSION%/${VERSION}/g" -e "s/%RELEASE%/${RELEASE}/g" ${NAME}.spec > ${TMPDIR}/${NAME}.spec
	rsync -a --exclude \.svn etc/* ${TMPDIR}/SOURCES/
	rsync -a --exclude \.svn src/* ${TMPDIR}/SOURCES/
	rpmbuild -vv -bb --target="noarch" --clean --define "_topdir ${TMPDIR}" ${TMPDIR}/${NAME}.spec
	find ${TMPDIR}/RPMS/ -type f -name '*.rpm' -print0 | xargs -0 -I {} mv {} ./rpms

pkg:
	mkdir -p ${TMPDIR}/usr/{bin,lib}
	mkdir -p ${TMPDIR}/private/etc/centrify_tools
	cp etc/centrify_tools/default.conf ${TMPDIR}/private/etc/centrify_tools
	cp src/ad_functions ${TMPDIR}/usr/lib
	cp src/ad_group ${TMPDIR}/usr/bin
	cp src/ad_host_roles ${TMPDIR}/usr/bin
	cp src/ad_host_zone ${TMPDIR}/usr/bin
	cp src/ad_zone_hosts ${TMPDIR}/usr/bin
	cp src/ad_zone_roles ${TMPDIR}/usr/bin
	cp src/ad_zones ${TMPDIR}/usr/bin
	/Applications/PackageMaker.app/Contents/MacOS/PackageMaker \
	--title ${NAME} \
	--version "${VERSION}-${RELEASE}" \
	--filter "\.DS_Store" \
	--root-volume-only \
	--verbose \
	--no-relocate \
	--target "10.5" \
	--id "com.${NAME}.pkg" \
	--root ${TMPDIR} \
	--out "${NAME}-${VERSION}-${RELEASE}.pkg"

dmg: pkg
	mkdir ${TMPDIR}/dmg
	cp -pR "${NAME}-${VERSION}-${RELEASE}.pkg" ${TMPDIR}/dmg
	hdiutil create "${NAME}-${VERSION}-${RELEASE}.dmg" -volname "${NAME}" -fs HFS+ -srcfolder ${TMPDIR}/dmg
