#! /bin/bash -e

TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

if ! zstd -h >/dev/null 2>&1; then
    apt install zstd
fi

TARGET_PATH="${TOP_DIR}/sandbox-rootfs"

for DIR in "${TOP_DIR}"/install/*; do
    if [[ ! -d "${DIR}" ]]; then
        continue
    fi

    DIR_NAME=$(basename "${DIR}")

    tar --use-compress-program=zstd -cvf "${TARGET_PATH}/sandbox-rootfs_${DIR_NAME}".tar.zst "${DIR}"
done