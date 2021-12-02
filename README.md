# MuPDF for Dlang

This repository contains Dlang bindings for [MuPDF](https://mupdf.com/) and tools to auto-generate them for arbitrary versions.

## Usage

1. Build and install from [MuPDF sources](https://mupdf.com/releases/index.html), or alternatively:
    ```bash
    sudo apt install -y libmupdf-dev
    ```

2. Add the package via DUB:
    ```bash
    dub add mupdf
    ```

3. Import the package, and follow the [MuPDF API documentation](https://mupdf.com/docs/api/index.html) as needed, e.g.:
    ```d
    import mupdf;

    void main() {
        auto ctx = fz_new_context(null, null, FZ_STORE_UNLIMITED);
        auto doc = pdf_open_document(ctx, "path/to/file.pdf");

        // ...
    }
    ```

Note the following remarks:

- All `PDF_NAME(x)` macro invocations must be replaced with `PDF_NAME_x` shorthands.

Current known limitations of these bindings:

- Only POSIX support for now.
- Many helper functions defined via preprocessor macros are not available.
- Exceptions via `fz_try`, `fz_always`, `fz_catch` are not supported.


## Build

To generate Dlang bindings for an arbitrary version of MuPDF:

1. [Install DPP](https://github.com/atilaneves/dpp#build-instructions).

2. Run the script `generate.sh` and follow usage instructions, e.g. to generate bindings for *mupdf-1.19.0* run the following command:
    ```bash
    ./generate.sh 1.19.0
    ```
