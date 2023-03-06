FROM minizinc/minizinc:latest-alpine

ARG OR_TOOLS_VERSION="9.4.1874"
RUN apk update \
  && apk add build-base linux-headers cmake \
  && wget https://github.com/google/or-tools/releases/download/v9.4/or-tools_amd64_alpine-edge_cpp_v${OR_TOOLS_VERSION}.tar.gz \
  && tar xvzf or-tools_amd64_alpine-edge_cpp_v${OR_TOOLS_VERSION}.tar.gz \
  && mv or-tools_cpp_alpine-edge-64bit_v${OR_TOOLS_VERSION} or-tools \
  && ln -s /or-tools/share/minizinc/ortools /usr/local/share/minizinc/ortools \
  && echo "{\
  \"id\": \"com.google.or-tools\",\
  \"name\": \"OR-Tools\",\
  \"description\": \"OR Tools Constraint Programming Solver (from Google)\",\
  \"version\": \"${OR_TOOLS_VERSION}\",\
  \"mznlib\": \"-Gortools\",\
  \"executable\": \"/or-tools/bin/fzn-ortools\",\
  \"tags\": [\"cp\",\"int\"],\
  \"stdFlags\": [\"-a\",\"-n\",\"-s\",\"-v\",\"-p\",\"-f\",\"-t\"],\
  \"supportsMzn\": false,\
  \"supportsFzn\": true,\
  \"needsSolns2Out\": true,\
  \"needsMznExecutable\": false,\
  \"needsStdlibDir\": false,\
  \"isGUIApplication\": false\
}" >> /usr/local/share/minizinc/solvers/or-tools.msc \
  && rm or-tools_amd64_alpine-edge_cpp_v${OR_TOOLS_VERSION}.tar.gz

CMD ["minizinc"]
