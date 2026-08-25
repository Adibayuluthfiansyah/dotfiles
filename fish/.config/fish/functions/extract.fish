function extract --description 'Extract berbagai format archive'
    if test (count $argv) -eq 0
        echo "Usage: extract <file>"
        return 1
    end

    if not test -f $argv[1]
        echo "extract: file '$argv[1]' tidak ditemukan"
        return 1
    end

    switch $argv[1]
        case '*.tar.gz' '*.tgz'
            tar xzf $argv[1]
        case '*.tar.bz2' '*.tbz2'
            tar xjf $argv[1]
        case '*.tar'
            tar xf $argv[1]
        case '*.zip'
            unzip $argv[1]
        case '*.rar'
            unrar x $argv[1]
        case '*.7z'
            7z x $argv[1]
        case '*.gz'
            gunzip $argv[1]
        case '*'
            echo "extract: format tidak dikenali untuk '$argv[1]'"
            return 1
    end
end
