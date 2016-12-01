PAGER?=		less

all:
	@cat ${.CURDIR}/README.md | ${PAGER}

CATEGORIES=	devel net sysutils security www

.for CATEGORY in ${CATEGORIES}
_${CATEGORY}!=	ls -1d ${CATEGORY}/*
PLUGIN_DIRS+=	${_${CATEGORY}}
.endfor

list:
.for PLUGIN_DIR in ${PLUGIN_DIRS}
	@echo ${PLUGIN_DIR}
.endfor

list-full:
.for PLUGIN_DIR in ${PLUGIN_DIRS}
	@echo ${PLUGIN_DIR} -- $$(${MAKE} -C ${PLUGIN_DIR} -V PLUGIN_COMMENT)
.endfor

TARGETS=	lint sweep style style-fix clean

.for TARGET in ${TARGETS}
${TARGET}:
.  for PLUGIN_DIR in ${PLUGIN_DIRS}
	@${MAKE} -C ${PLUGIN_DIR} ${TARGET}
.  endfor
.endfor
