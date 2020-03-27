##### BEGIN image.base/Dockerfile/image-header #####
FROM $CONTECO_REGISTRY$CONTECO_REALM_RUNTIME/$CONTECO_ECOSYSTEM_RUNTIME.image.wrapper AS wrapper
FROM $CONTECO_REGISTRY$CONTECO_REALM_RUNTIME/$CONTECO_ECOSYSTEM_RUNTIME.$CONTECO_BASE AS base
##### END image.base/Dockerfile/image-header #####

##### BEGIN image.base/Dockerfile/conteco #####
COPY --from=wrapper /conteco/ /conteco/
ENTRYPOINT ["/conteco/bin/image/wrapper/entrypoint"]
##### END image.base/Dockerfile/conteco #####

##### BEGIN image/Dockerfile/conteco #####
COPY ./conteco/ /conteco/
RUN chmod -R +x /conteco/bin && rm -rf /conteco/repo
COPY ./ /conteco/repo/
##### END image/Dockerfile/conteco #####

##### BEGIN image/Dockerfile/build-instructions #####
ENV CONTECO_ENTRYPOINT "/entrypoint-artifactory.sh"
##### END image/Dockerfile/build-instructions #####

##### BEGIN image.base/Dockerfile/env-labels-footer #####
ENV CONTECO_REALM="$CONTECO_REALM_RUNTIME" \
    CONTECO_ECOSYSTEM="$CONTECO_ECOSYSTEM_RUNTIME" \
    CONTECO_TYPE="$CONTECO_TYPE" \
    CONTECO_NAME="$CONTECO_NAME" \
    CONTECO_TAG="$CONTECO_TAG" \
    CONTECO_BASE="$CONTECO_BASE" \
    CONTECO_BUILD="$CONTECO_BUILD"
LABEL $CONTECO_LABELSPACE.schema-version="1.0" \
      $CONTECO_LABELSPACE.realm="$CONTECO_REALM_RUNTIME" \
      $CONTECO_LABELSPACE.ecosystem="$CONTECO_ECOSYSTEM_RUNTIME" \
      $CONTECO_LABELSPACE.type="$CONTECO_TYPE" \
      $CONTECO_LABELSPACE.name="$CONTECO_NAME" \
      $CONTECO_LABELSPACE.tag="$CONTECO_TAG" \
      $CONTECO_LABELSPACE.base="$CONTECO_BASE" \
      $CONTECO_LABELSPACE.build="$CONTECO_BUILD" \
      $CONTECO_LABELSPACE.label="$CONTECO_LABEL" \
      $CONTECO_LABELSPACE.description="$CONTECO_DESCRIPTION" \
      $CONTECO_LABELSPACE.docker.cmd.help="docker run ${CONTECO_REALM_RUNTIME}/${CONTECO_ECOSYSTEM_RUNTIME}.${CONTECO_TYPE}.${CONTECO_NAME} --help" 
##### END image.base/Dockerfile/env-labels-footer #####
