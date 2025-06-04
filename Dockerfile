FROM ubuntu:22.04 as builder
RUN apt update
RUN apt install -yy gcc g++ cmake lcov
COPY . /app
WORKDIR /app

RUN mkdir build && cd build && \
    cmake -DCOVERAGE=ON -DCMAKE_BUILD_TYPE=Release .. && \
    cmake --build . --config Release --parallel $(nproc)

RUN cd build && \
    ./RunTest && \
    lcov --capture \
         --directory . \
         --output-file coverage.info \
         --rc geninfo_unexecuted_blocks=1 \
         --ignore-errors mismatch,unused && \
    lcov --remove coverage.info \
         '/usr/*' \
         '*/googletest/*' \
         '*/test/*' \
         --output-file coverage.info \
         --ignore-errors unused && \
    genhtml coverage.info \
            --output-directory coverage_report \
            --ignore-errors unmapped,unused

CMD ["bash"]
