#!/usr/bin/env bash
# @autor majinjie
# @created 2025-5-9
# @description manager mpv scripts

set -eo pipefail

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MPV_HOME="${MPV_HOME:-$HOME/.config/mpv}"
SCRIPTS_DIR="$MPV_HOME/scripts"
SCRIPTS_OPTS_DIR="$MPV_HOME/script-opts"

install() {
  local name url script script_opt
  local backup_dir

  # 参数解析
  while [[ $# -gt 0 ]]; do
    case "$1" in
    --name)
      name="$2"
      shift 2
      ;;
    --script)
      script="$2"
      shift 2
      ;;
    --script-opt)
      script_opt="$2"
      shift 2
      ;;
    *)
      if [[ -n "${url:-}" ]]; then
        echo "Error: Only one positional argument allowed." >&2
        return 1
      fi
      url="$1"
      shift
      ;;
    esac
  done

  [[ -z "$url" ]] && {
    echo "Error: URL/repository required." >&2
    return 1
  }
  # 生成GitHub URL
  if [[ ! "$url" =~ ^https?:// ]]; then
    [[ -z "$name" ]] && name=${url#*/}
    url="https://github.com/${url}/archive/HEAD.zip"
  fi

  [[ -z "$name" ]] && {
    echo "Error: --name required." >&2
    return 1
  }

  # 检查备份目录
  backup_dir="$CURRENT_DIR/.${name}-backup"
  [[ -d "$backup_dir" ]] && {
    echo "Error: Backup dir exists." >&2
    return 1
  }

  # 临时文件处理
  local tmp_zip tmp_extract
  tmp_zip="$(mktemp -u)"
  tmp_extract="$(mktemp -d)"
  trap "rm -rf $tmp_zip $tmp_extract" EXIT

  # 下载解压
  curl -sfL "$url" -o "$tmp_zip" || {
    echo "Download failed." >&2
    return 1
  }
  unzip -qj "$tmp_zip" -d "$tmp_extract" || {
    echo "Extraction failed." >&2
    return 1
  }

  # 查找主脚本
  local found_script
  local script_candidates=(
    "${name}.lua"
    "${name}"
    "scripts/${name}.lua"
  )
  if [[ -n "$script" && "$script" =~ ^https?:// ]]; then
    local _script=${script##*/}

    if curl -sfL "$script" -o "$tmp_extract/$_script"; then
      script="$_script"
    else
      echo "Script $script download failed." >&2
      return 1
    fi
  fi
  for candidate in "$script" "${script_candidates[@]}"; do
    if [[ -n "$candidate" && -e "$tmp_extract/$candidate" ]]; then
      script=$candidate
      found_script="$tmp_extract/$candidate"
      break
    fi
  done
  if [[ -z "${found_script:-}" ]]; then
    echo "Script not found." >&2
    return 1
  else
    echo "Found script $script."
  fi

  # 安装主脚本（备份旧版本）
  mkdir -p "$SCRIPTS_DIR"
  local script_target="$SCRIPTS_DIR/$(basename "$found_script")"
  if [[ -e "$script_target" ]]; then
    mkdir -p "$backup_dir"
    cp "$script_target" "$backup_dir/" && echo "Backup old: $script_target."
  fi
  mv "$found_script" "$script_target"

  # 处理配置文件（备份新版本）
  local found_script_opt
  local script_opt_candidates=(
    "${name}.conf"
    "script-opts/${name}.conf"
  )
  if [[ -n "$script_opt" && "$script_opt" =~ ^https?:// ]]; then
    local _script_opt=${script_opt##*/}
    if curl -sfL "$script_opt" -o "$tmp_extract/$_script_opt"; then
      script_opt="$_script_opt"
    else
      echo "Config $script_opt download failed." >&2
      return 1
    fi
  fi
  for candidate in "$script_opt" "${script_opt_candidates[@]}"; do
    if [[ -n "$candidate" && -e "$tmp_extract/$candidate" ]]; then
      script_opt=$candidate
      found_script_opt="$tmp_extract/$candidate"
      break
    fi
  done
  if [[ -z "${found_script_opt:-}" ]]; then
    echo "Warning: Config not found."
    return 1
  else
    echo "Found Config $script_opt."
  fi

  mkdir -p "$SCRIPTS_OPTS_DIR"
  local script_opt_target="$SCRIPTS_OPTS_DIR/$(basename "$found_script_opt")"
  if [[ -e "$script_opt_target" ]]; then
    mkdir -p "$backup_dir"
    cp "$found_script_opt" "$backup_dir/" && echo "Backup new config: $found_script_opt"
    echo "Warning: Manual merge needed for $script_opt_target"
  else
    mv "$found_script_opt" "$script_opt_target"
  fi
  echo "$name has been installed."
}

install-uosc() {
  bash <(curl -fsSL https://raw.githubusercontent.com/tomasklaen/uosc/HEAD/installers/unix.sh)
}

install-all() {
  install-uosc && {
    install po5/thumbfast
  }
}

delete() {
  local name="$1"
  local script_candidates=(
    "${name}.lua"
    "${name}"
  )
  local deleted=()

  for candidate in "${script_candidates[@]}"; do
    local target="$SCRIPTS_DIR/$candidate"
    if [[ -e "$target" ]]; then
      deleted+=("$target")
    fi
  done

  if [[ -z "${deleted-}" ]]; then
    echo "Warning: No files deleted for $name" >&2
  else
    echo "Deleted:"
    rm -vrf "${deleted[@]}"
  fi
}

help() {
  cat <<EOF
MPV Script Manager - A tool to install, update, and delete MPV scripts

Usage: $(basename "$0") [OPTIONS] [ARGUMENTS]

Options:
  -i, --install      Install or update a script
  -u, --update       Alias for --install
  -d, --delete      Delete an installed script
  -h, --help         Show this help message

Install/Update Usage:
  $(basename "$0") -i [OPTIONS] <repository/url> [--name NAME] [--script PATH] [--script-opt PATH]

  <repository/url>   GitHub repository (user/repo) or direct ZIP URL
  --name NAME        Specify script name (required)
  --script PATH      Custom script path in archive or direct URL
  --script-opt PATH  Custom config path in archive or direct URL

Delete Usage:
  $(basename "$0") -d NAME

Examples:
  # Install from GitHub
  $(basename "$0") -i --name coolscript user/repo

  # Install with custom paths
  $(basename "$0") -i https://example.com/script.zip --name myscript \\
    --script src/main.lua --script-opt configs/settings.conf

  # Delete a script
  $(basename "$0") -d oldscript

Notes:
  - Scripts are installed to \$MPV_HOME/scripts (default: ~/.config/mpv/scripts)
  - Backups are stored in ./.NAME-backup
  - Special handling for uosc (installs via official installer)
EOF
  exit 0
}

main() {
  # 主选项解析
  operation=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
    -i | --install | -u | --update)
      operation=install
      shift
      ;;
    -d | --delete)
      operation=delete
      shift
      ;;
    -h | --help) help ;;
    *)
      break
      ;;
    esac
  done

  case "$operation" in
  install)
    if [[ $# -eq 0 ]]; then
      install-all
    else
      install "$@"
    fi
    ;;
  delete)
    [[ $# -eq 0 ]] && {
      echo "Missing name" >&2
      exit 1
    }
    delete "$1"
    ;;
  *)
    exit 0
    ;;
  esac

}

main "$@"
