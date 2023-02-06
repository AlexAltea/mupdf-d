version(Windows):


        import core.stdc.config;
        import core.stdc.stdarg: va_list;
        static import core.simd;
        static import std.conv;

        struct Int128 { long lower; long upper; }
        struct UInt128 { ulong lower; ulong upper; }

        struct __locale_data { int dummy; } // FIXME



alias _Bool = bool;
struct dpp {
    static struct Opaque(int N) {
        void[N] bytes;
    }
    // Replacement for the gcc/clang intrinsic
    static bool isEmpty(T)() {
        return T.tupleof.length == 0;
    }
    static struct Move(T) {
        T* ptr;
    }
    // dmd bug causes a crash if T is passed by value.
    // Works fine with ldc.
    static auto move(T)(ref T value) {
        return Move!T(&value);
    }
    mixin template EnumD(string name, T, string prefix) if(is(T == enum)) {
        private static string _memberMixinStr(string member) {
            import std.conv: text;
            import std.array: replace;
            return text(` `, member.replace(prefix, ""), ` = `, T.stringof, `.`, member, `,`);
        }
        private static string _enumMixinStr() {
            import std.array: join;
            string[] ret;
            ret ~= "enum " ~ name ~ "{";
            static foreach(member; __traits(allMembers, T)) {
                ret ~= _memberMixinStr(member);
            }
            ret ~= "}";
            return ret.join("\n");
        }
        mixin(_enumMixinStr());
    }
}

extern(C)
{

    alias size_t = ulong;

    void pdf_debug_doc_changes(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_drop_local_xref_and_resources(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_drop_local_xref(fz_context*, pdf_xref*) @nogc nothrow;

    pdf_xref* pdf_new_local_xref(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_was_pure_xfa(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_validate_signature(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_find_version_for_obj(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    int pdf_validate_change_history(fz_context*, pdf_document*) @nogc nothrow;

    pdf_locked_fields* pdf_find_locked_fields_for_sig(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    pdf_locked_fields* pdf_find_locked_fields(fz_context*, pdf_document*, int) @nogc nothrow;

    void pdf_drop_locked_fields(fz_context*, pdf_locked_fields*) @nogc nothrow;

    int pdf_is_field_locked(fz_context*, pdf_locked_fields*, const(char)*) @nogc nothrow;
    struct pdf_locked_fields;

    int pdf_doc_was_linearized(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_validate_changes(fz_context*, pdf_document*, int) @nogc nothrow;

    int pdf_count_unsaved_versions(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_count_versions(fz_context*, pdf_document*) @nogc nothrow;

    pdf_obj* pdf_progressive_advance(fz_context*, pdf_document*, int) @nogc nothrow;

    int pdf_repair_obj(fz_context*, pdf_document*, pdf_lexbuf*, long*, int*, pdf_obj**, pdf_obj**, pdf_obj**, long*, pdf_obj**) @nogc nothrow;

    void pdf_clear_xref_to_mark(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_clear_xref(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_mark_xref(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_ensure_solid_xref(fz_context*, pdf_document*, int) @nogc nothrow;

    void pdf_repair_trailer(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_repair_obj_stms(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_repair_xref(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_obj_is_incremental(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_xref_ensure_local_object(fz_context*, pdf_document*, int) @nogc nothrow;

    int pdf_xref_obj_is_unsaved_signature(pdf_document*, pdf_obj*) @nogc nothrow;

    void pdf_xref_remove_unsaved_signature(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    void pdf_xref_store_unsaved_signature(fz_context*, pdf_document*, pdf_obj*, pdf_pkcs7_signer*) @nogc nothrow;

    int pdf_xref_is_incremental(fz_context*, pdf_document*, int) @nogc nothrow;

    int pdf_xref_ensure_incremental_object(fz_context*, pdf_document*, int) @nogc nothrow;

    pdf_xref_entry* pdf_get_incremental_xref_entry(fz_context*, pdf_document*, int) @nogc nothrow;

    void pdf_forget_xref(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_replace_xref(fz_context*, pdf_document*, pdf_xref_entry*, int) @nogc nothrow;

    pdf_xref_entry* pdf_get_xref_entry_no_null(fz_context*, pdf_document*, int) @nogc nothrow;

    pdf_xref_entry* pdf_get_xref_entry(fz_context*, pdf_document*, int) @nogc nothrow;

    pdf_xref_entry* pdf_get_populating_xref_entry(fz_context*, pdf_document*, int) @nogc nothrow;

    pdf_obj* pdf_metadata(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_xref_len(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_set_populating_xref_trailer(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_trailer(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_version(fz_context*, pdf_document*) @nogc nothrow;

    fz_stream* pdf_open_contents_stream(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    fz_stream* pdf_open_stream_with_offset(fz_context*, pdf_document*, int, pdf_obj*, long) @nogc nothrow;

    void pdf_load_compressed_inline_image(fz_context*, pdf_document*, pdf_obj*, int, fz_stream*, int, fz_compressed_image*) @nogc nothrow;

    fz_compressed_buffer* pdf_load_compressed_stream(fz_context*, pdf_document*, int, ulong) @nogc nothrow;

    fz_stream* pdf_open_inline_stream(fz_context*, pdf_document*, pdf_obj*, int, fz_stream*, fz_compression_params*) @nogc nothrow;

    fz_stream* pdf_open_stream(fz_context*, pdf_obj*) @nogc nothrow;

    fz_stream* pdf_open_stream_number(fz_context*, pdf_document*, int) @nogc nothrow;

    fz_stream* pdf_open_raw_stream(fz_context*, pdf_obj*) @nogc nothrow;

    fz_stream* pdf_open_raw_stream_number(fz_context*, pdf_document*, int) @nogc nothrow;

    fz_buffer* pdf_load_stream(fz_context*, pdf_obj*) @nogc nothrow;

    fz_buffer* pdf_load_stream_number(fz_context*, pdf_document*, int) @nogc nothrow;

    fz_buffer* pdf_load_raw_stream(fz_context*, pdf_obj*) @nogc nothrow;

    fz_buffer* pdf_load_raw_stream_number(fz_context*, pdf_document*, int) @nogc nothrow;

    pdf_obj* pdf_load_unencrypted_object(fz_context*, pdf_document*, int) @nogc nothrow;

    pdf_obj* pdf_load_object(fz_context*, pdf_document*, int) @nogc nothrow;

    pdf_obj* pdf_resolve_indirect_chain(fz_context*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_resolve_indirect(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_count_objects(fz_context*, pdf_document*) @nogc nothrow;

    pdf_xref_entry* pdf_cache_object(fz_context*, pdf_document*, int) @nogc nothrow;

    struct pdf_xref_subsec
    {

        pdf_xref_subsec* next;

        int len;

        int start;

        pdf_xref_entry* table;
    }

    struct pdf_xref_entry
    {

        char type;

        ubyte marked;

        ushort gen;

        int num;

        long ofs;

        long stm_ofs;

        fz_buffer* stm_buf;

        pdf_obj* obj;
    }

    pdf_obj* pdf_add_new_array(fz_context*, pdf_document*, int) @nogc nothrow;

    pdf_obj* pdf_add_new_dict(fz_context*, pdf_document*, int) @nogc nothrow;

    pdf_obj* pdf_add_stream(fz_context*, pdf_document*, fz_buffer*, pdf_obj*, int) @nogc nothrow;

    pdf_obj* pdf_add_object_drop(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_add_object(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    int pdf_is_local_object(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    void pdf_update_stream(fz_context*, pdf_document*, pdf_obj*, fz_buffer*, int) @nogc nothrow;

    void pdf_update_object(fz_context*, pdf_document*, int, pdf_obj*) @nogc nothrow;

    void pdf_delete_object(fz_context*, pdf_document*, int) @nogc nothrow;

    int pdf_create_object(fz_context*, pdf_document*) @nogc nothrow;

    fz_colorspace* pdf_xobject_colorspace(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_xobject_transparency(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_xobject_knockout(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_xobject_isolated(fz_context*, pdf_obj*) @nogc nothrow;

    fz_matrix pdf_xobject_matrix(fz_context*, pdf_obj*) @nogc nothrow;

    fz_rect pdf_xobject_bbox(fz_context*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_xobject_resources(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_update_xobject(fz_context*, pdf_document*, pdf_obj*, fz_rect, fz_matrix, pdf_obj*, fz_buffer*) @nogc nothrow;

    pdf_obj* pdf_new_xobject(fz_context*, pdf_document*, fz_rect, fz_matrix, pdf_obj*, fz_buffer*) @nogc nothrow;

    void pdf_drop_pattern(fz_context*, pdf_pattern*) @nogc nothrow;

    pdf_pattern* pdf_keep_pattern(fz_context*, pdf_pattern*) @nogc nothrow;

    pdf_pattern* pdf_load_pattern(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    struct pdf_pattern
    {

        fz_storable storable;

        int ismask;

        float xstep;

        float ystep;

        fz_matrix matrix;

        fz_rect bbox;

        pdf_document* document;

        pdf_obj* resources;

        pdf_obj* contents;

        int id;
    }

    pdf_obj* pdf_add_image(fz_context*, pdf_document*, fz_image*) @nogc nothrow;

    fz_image* pdf_load_image(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    int pdf_is_jpx_image(fz_context*, pdf_obj*) @nogc nothrow;

    fz_image* pdf_load_inline_image(fz_context*, pdf_document*, pdf_obj*, pdf_obj*, fz_stream*) @nogc nothrow;

    fz_shade* pdf_load_shading(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    int pdf_is_tint_colorspace(fz_context*, fz_colorspace*) @nogc nothrow;

    fz_colorspace* pdf_load_colorspace(fz_context*, pdf_obj*) @nogc nothrow;

    fz_colorspace* pdf_document_output_intent(fz_context*, pdf_document*) @nogc nothrow;

    pdf_function* pdf_load_function(fz_context*, pdf_obj*, int, int) @nogc nothrow;

    ulong pdf_function_size(fz_context*, pdf_function*) @nogc nothrow;

    void pdf_drop_function(fz_context*, pdf_function*) @nogc nothrow;

    pdf_function* pdf_keep_function(fz_context*, pdf_function*) @nogc nothrow;

    void pdf_eval_function(fz_context*, pdf_function*, const(float)*, int, float*, int) @nogc nothrow;
    struct pdf_function;

    void pdf_purge_local_font_resources(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_drop_resource_tables(fz_context*, pdf_document*) @nogc nothrow;

    pdf_obj* pdf_insert_font_resource(fz_context*, pdf_document*, pdf_font_resource_key*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_find_font_resource(fz_context*, pdf_document*, int, int, fz_font*, pdf_font_resource_key*) @nogc nothrow;

    struct pdf_font_resource_key
    {

        ubyte[16] digest;

        int type;

        int encoding;

        int local_xref;
    }

    enum _Anonymous_0
    {

        PDF_SIMPLE_ENCODING_LATIN = 0,

        PDF_SIMPLE_ENCODING_GREEK = 1,

        PDF_SIMPLE_ENCODING_CYRILLIC = 2,
    }
    enum PDF_SIMPLE_ENCODING_LATIN = _Anonymous_0.PDF_SIMPLE_ENCODING_LATIN;
    enum PDF_SIMPLE_ENCODING_GREEK = _Anonymous_0.PDF_SIMPLE_ENCODING_GREEK;
    enum PDF_SIMPLE_ENCODING_CYRILLIC = _Anonymous_0.PDF_SIMPLE_ENCODING_CYRILLIC;

    enum _Anonymous_1
    {

        PDF_SIMPLE_FONT_RESOURCE = 1,

        PDF_CID_FONT_RESOURCE = 2,

        PDF_CJK_FONT_RESOURCE = 3,
    }
    enum PDF_SIMPLE_FONT_RESOURCE = _Anonymous_1.PDF_SIMPLE_FONT_RESOURCE;
    enum PDF_CID_FONT_RESOURCE = _Anonymous_1.PDF_CID_FONT_RESOURCE;
    enum PDF_CJK_FONT_RESOURCE = _Anonymous_1.PDF_CJK_FONT_RESOURCE;

    void pdf_purge_locals_from_store(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_empty_store(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_remove_item(fz_context*, void function(fz_context*, fz_storable*), pdf_obj*) @nogc nothrow;

    void* pdf_find_item(fz_context*, void function(fz_context*, fz_storable*), pdf_obj*) @nogc nothrow;

    void pdf_store_item(fz_context*, pdf_obj*, void*, ulong) @nogc nothrow;

    void pdf_append_token(fz_context*, fz_buffer*, int, pdf_lexbuf*) @nogc nothrow;

    pdf_obj* pdf_parse_journal_obj(fz_context*, pdf_document*, fz_stream*, int*, fz_buffer**, int*) @nogc nothrow;

    pdf_obj* pdf_parse_ind_obj(fz_context*, pdf_document*, fz_stream*, int*, int*, long*, int*) @nogc nothrow;

    pdf_obj* pdf_parse_stm_obj(fz_context*, pdf_document*, fz_stream*, pdf_lexbuf*) @nogc nothrow;

    pdf_obj* pdf_parse_dict(fz_context*, pdf_document*, fz_stream*, pdf_lexbuf*) @nogc nothrow;

    pdf_obj* pdf_parse_array(fz_context*, pdf_document*, fz_stream*, pdf_lexbuf*) @nogc nothrow;

    pdf_token pdf_lex_no_string(fz_context*, fz_stream*, pdf_lexbuf*) @nogc nothrow;

    pdf_token pdf_lex(fz_context*, fz_stream*, pdf_lexbuf*) @nogc nothrow;

    long pdf_lexbuf_grow(fz_context*, pdf_lexbuf*) @nogc nothrow;

    void pdf_lexbuf_fin(fz_context*, pdf_lexbuf*) @nogc nothrow;

    void pdf_lexbuf_init(fz_context*, pdf_lexbuf*, int) @nogc nothrow;

    enum _Anonymous_2
    {

        PDF_TOK_ERROR = 0,

        PDF_TOK_EOF = 1,

        PDF_TOK_OPEN_ARRAY = 2,

        PDF_TOK_CLOSE_ARRAY = 3,

        PDF_TOK_OPEN_DICT = 4,

        PDF_TOK_CLOSE_DICT = 5,

        PDF_TOK_OPEN_BRACE = 6,

        PDF_TOK_CLOSE_BRACE = 7,

        PDF_TOK_NAME = 8,

        PDF_TOK_INT = 9,

        PDF_TOK_REAL = 10,

        PDF_TOK_STRING = 11,

        PDF_TOK_KEYWORD = 12,

        PDF_TOK_R = 13,

        PDF_TOK_TRUE = 14,

        PDF_TOK_FALSE = 15,

        PDF_TOK_NULL = 16,

        PDF_TOK_OBJ = 17,

        PDF_TOK_ENDOBJ = 18,

        PDF_TOK_STREAM = 19,

        PDF_TOK_ENDSTREAM = 20,

        PDF_TOK_XREF = 21,

        PDF_TOK_TRAILER = 22,

        PDF_TOK_STARTXREF = 23,

        PDF_TOK_NEWOBJ = 24,

        PDF_NUM_TOKENS = 25,
    }
    enum PDF_TOK_ERROR = _Anonymous_2.PDF_TOK_ERROR;
    enum PDF_TOK_EOF = _Anonymous_2.PDF_TOK_EOF;
    enum PDF_TOK_OPEN_ARRAY = _Anonymous_2.PDF_TOK_OPEN_ARRAY;
    enum PDF_TOK_CLOSE_ARRAY = _Anonymous_2.PDF_TOK_CLOSE_ARRAY;
    enum PDF_TOK_OPEN_DICT = _Anonymous_2.PDF_TOK_OPEN_DICT;
    enum PDF_TOK_CLOSE_DICT = _Anonymous_2.PDF_TOK_CLOSE_DICT;
    enum PDF_TOK_OPEN_BRACE = _Anonymous_2.PDF_TOK_OPEN_BRACE;
    enum PDF_TOK_CLOSE_BRACE = _Anonymous_2.PDF_TOK_CLOSE_BRACE;
    enum PDF_TOK_NAME = _Anonymous_2.PDF_TOK_NAME;
    enum PDF_TOK_INT = _Anonymous_2.PDF_TOK_INT;
    enum PDF_TOK_REAL = _Anonymous_2.PDF_TOK_REAL;
    enum PDF_TOK_STRING = _Anonymous_2.PDF_TOK_STRING;
    enum PDF_TOK_KEYWORD = _Anonymous_2.PDF_TOK_KEYWORD;
    enum PDF_TOK_R = _Anonymous_2.PDF_TOK_R;
    enum PDF_TOK_TRUE = _Anonymous_2.PDF_TOK_TRUE;
    enum PDF_TOK_FALSE = _Anonymous_2.PDF_TOK_FALSE;
    enum PDF_TOK_NULL = _Anonymous_2.PDF_TOK_NULL;
    enum PDF_TOK_OBJ = _Anonymous_2.PDF_TOK_OBJ;
    enum PDF_TOK_ENDOBJ = _Anonymous_2.PDF_TOK_ENDOBJ;
    enum PDF_TOK_STREAM = _Anonymous_2.PDF_TOK_STREAM;
    enum PDF_TOK_ENDSTREAM = _Anonymous_2.PDF_TOK_ENDSTREAM;
    enum PDF_TOK_XREF = _Anonymous_2.PDF_TOK_XREF;
    enum PDF_TOK_TRAILER = _Anonymous_2.PDF_TOK_TRAILER;
    enum PDF_TOK_STARTXREF = _Anonymous_2.PDF_TOK_STARTXREF;
    enum PDF_TOK_NEWOBJ = _Anonymous_2.PDF_TOK_NEWOBJ;
    enum PDF_NUM_TOKENS = _Anonymous_2.PDF_NUM_TOKENS;

    alias pdf_token = _Anonymous_2;

    fz_default_colorspaces* pdf_update_default_colorspaces(fz_context*, fz_default_colorspaces*, pdf_obj*) @nogc nothrow;

    fz_default_colorspaces* pdf_load_default_colorspaces(fz_context*, pdf_document*, pdf_page*) @nogc nothrow;

    fz_transition* pdf_page_presentation(fz_context*, pdf_page*, fz_transition*, float*) @nogc nothrow;

    int pdf_redact_page(fz_context*, pdf_document*, pdf_page*, pdf_redact_options*) @nogc nothrow;

    struct pdf_redact_options
    {

        int black_boxes;

        int image_method;
    }

    enum _Anonymous_3
    {

        PDF_REDACT_IMAGE_NONE = 0,

        PDF_REDACT_IMAGE_REMOVE = 1,

        PDF_REDACT_IMAGE_PIXELS = 2,
    }
    enum PDF_REDACT_IMAGE_NONE = _Anonymous_3.PDF_REDACT_IMAGE_NONE;
    enum PDF_REDACT_IMAGE_REMOVE = _Anonymous_3.PDF_REDACT_IMAGE_REMOVE;
    enum PDF_REDACT_IMAGE_PIXELS = _Anonymous_3.PDF_REDACT_IMAGE_PIXELS;

    fz_pixmap* pdf_new_pixmap_from_page_with_separations_and_usage(fz_context*, pdf_page*, fz_matrix, fz_colorspace*, fz_separations*, int, const(char)*) @nogc nothrow;

    fz_pixmap* pdf_new_pixmap_from_page_contents_with_separations_and_usage(fz_context*, pdf_page*, fz_matrix, fz_colorspace*, fz_separations*, int, const(char)*) @nogc nothrow;

    fz_pixmap* pdf_new_pixmap_from_page_with_usage(fz_context*, pdf_page*, fz_matrix, fz_colorspace*, int, const(char)*) @nogc nothrow;

    fz_pixmap* pdf_new_pixmap_from_page_contents_with_usage(fz_context*, pdf_page*, fz_matrix, fz_colorspace*, int, const(char)*) @nogc nothrow;

    void pdf_filter_annot_contents(fz_context*, pdf_document*, pdf_annot*, pdf_filter_options*) @nogc nothrow;

    void pdf_filter_page_contents(fz_context*, pdf_document*, pdf_page*, pdf_filter_options*) @nogc nothrow;

    void pdf_run_page_widgets_with_usage(fz_context*, pdf_page*, fz_device*, fz_matrix, const(char)*, fz_cookie*) @nogc nothrow;

    void pdf_run_page_annots_with_usage(fz_context*, pdf_page*, fz_device*, fz_matrix, const(char)*, fz_cookie*) @nogc nothrow;

    void pdf_run_page_contents_with_usage(fz_context*, pdf_page*, fz_device*, fz_matrix, const(char)*, fz_cookie*) @nogc nothrow;

    void pdf_run_page_widgets(fz_context*, pdf_page*, fz_device*, fz_matrix, fz_cookie*) @nogc nothrow;

    void pdf_run_page_annots(fz_context*, pdf_page*, fz_device*, fz_matrix, fz_cookie*) @nogc nothrow;

    void pdf_run_page_contents(fz_context*, pdf_page*, fz_device*, fz_matrix, fz_cookie*) @nogc nothrow;

    void pdf_run_page_with_usage(fz_context*, pdf_page*, fz_device*, fz_matrix, const(char)*, fz_cookie*) @nogc nothrow;

    void pdf_run_page(fz_context*, pdf_page*, fz_device*, fz_matrix, fz_cookie*) @nogc nothrow;

    fz_rect pdf_bound_page(fz_context*, pdf_page*) @nogc nothrow;

    fz_link* pdf_load_links(fz_context*, pdf_page*) @nogc nothrow;

    int pdf_is_ocg_hidden(fz_context*, pdf_document*, pdf_obj*, const(char)*, pdf_obj*) @nogc nothrow;

    void pdf_drop_ocg(fz_context*, pdf_document*) @nogc nothrow;

    pdf_ocg_descriptor* pdf_read_ocg(fz_context*, pdf_document*) @nogc nothrow;

    fz_separations* pdf_page_separations(fz_context*, pdf_page*) @nogc nothrow;

    pdf_obj* pdf_page_group(fz_context*, pdf_page*) @nogc nothrow;

    pdf_obj* pdf_page_contents(fz_context*, pdf_page*) @nogc nothrow;

    pdf_obj* pdf_page_resources(fz_context*, pdf_page*) @nogc nothrow;

    void pdf_page_transform(fz_context*, pdf_page*, fz_rect*, fz_matrix*) @nogc nothrow;

    void pdf_page_obj_transform(fz_context*, pdf_obj*, fz_rect*, fz_matrix*) @nogc nothrow;

    fz_page* pdf_load_page_imp(fz_context*, fz_document*, int, int) @nogc nothrow;

    pdf_page* pdf_load_page(fz_context*, pdf_document*, int) @nogc nothrow;

    void pdf_flatten_inheritable_page_items(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_lookup_anchor(fz_context*, pdf_document*, const(char)*, float*, float*) @nogc nothrow;

    void pdf_drop_page_tree(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_load_page_tree(fz_context*, pdf_document*) @nogc nothrow;

    pdf_obj* pdf_lookup_page_obj(fz_context*, pdf_document*, int) @nogc nothrow;

    int pdf_count_pages_imp(fz_context*, fz_document*, int) @nogc nothrow;

    int pdf_count_pages(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_lookup_page_number(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    long pdf_parse_date(fz_context*, const(char)*) @nogc nothrow;

    char* pdf_format_date(fz_context*, long, char*, ulong) @nogc nothrow;

    void pdf_add_journal_fragment(fz_context*, pdf_document*, int, pdf_obj*, fz_buffer*, int) @nogc nothrow;

    void pdf_deserialise_journal(fz_context*, pdf_document*, fz_stream*) @nogc nothrow;

    void pdf_serialise_journal(fz_context*, pdf_document*, fz_output*) @nogc nothrow;

    void pdf_drop_journal(fz_context*, pdf_journal*) @nogc nothrow;

    void pdf_discard_journal(fz_context*, pdf_journal*) @nogc nothrow;

    void pdf_redo(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_undo(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_can_redo(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_can_undo(fz_context*, pdf_document*) @nogc nothrow;

    const(char)* pdf_undoredo_step(fz_context*, pdf_document*, int) @nogc nothrow;

    int pdf_undoredo_state(fz_context*, pdf_document*, int*) @nogc nothrow;

    void pdf_end_operation(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_begin_implicit_operation(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_begin_operation(fz_context*, pdf_document*, const(char)*) @nogc nothrow;

    void pdf_enable_journal(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_set_str_len(fz_context*, pdf_obj*, ulong) @nogc nothrow;

    enum _Anonymous_4
    {

        PDF_ENUM_NULL = 0,

        PDF_ENUM_TRUE = 1,

        PDF_ENUM_FALSE = 2,

        PDF_ENUM_NAME_1_2 = 3,

        PDF_ENUM_NAME_3D = 4,

        PDF_ENUM_NAME_A = 5,

        PDF_ENUM_NAME_A85 = 6,

        PDF_ENUM_NAME_AA = 7,

        PDF_ENUM_NAME_AC = 8,

        PDF_ENUM_NAME_AESV2 = 9,

        PDF_ENUM_NAME_AESV3 = 10,

        PDF_ENUM_NAME_AHx = 11,

        PDF_ENUM_NAME_AP = 12,

        PDF_ENUM_NAME_AS = 13,

        PDF_ENUM_NAME_ASCII85Decode = 14,

        PDF_ENUM_NAME_ASCIIHexDecode = 15,

        PDF_ENUM_NAME_AcroForm = 16,

        PDF_ENUM_NAME_Action = 17,

        PDF_ENUM_NAME_ActualText = 18,

        PDF_ENUM_NAME_Adobe_PPKLite = 19,

        PDF_ENUM_NAME_All = 20,

        PDF_ENUM_NAME_AllOff = 21,

        PDF_ENUM_NAME_AllOn = 22,

        PDF_ENUM_NAME_Alpha = 23,

        PDF_ENUM_NAME_Alt = 24,

        PDF_ENUM_NAME_Alternate = 25,

        PDF_ENUM_NAME_Annot = 26,

        PDF_ENUM_NAME_Annots = 27,

        PDF_ENUM_NAME_AnyOff = 28,

        PDF_ENUM_NAME_App = 29,

        PDF_ENUM_NAME_Approved = 30,

        PDF_ENUM_NAME_ArtBox = 31,

        PDF_ENUM_NAME_AsIs = 32,

        PDF_ENUM_NAME_Ascent = 33,

        PDF_ENUM_NAME_AuthEvent = 34,

        PDF_ENUM_NAME_Author = 35,

        PDF_ENUM_NAME_B = 36,

        PDF_ENUM_NAME_BBox = 37,

        PDF_ENUM_NAME_BC = 38,

        PDF_ENUM_NAME_BE = 39,

        PDF_ENUM_NAME_BG = 40,

        PDF_ENUM_NAME_BM = 41,

        PDF_ENUM_NAME_BPC = 42,

        PDF_ENUM_NAME_BS = 43,

        PDF_ENUM_NAME_Background = 44,

        PDF_ENUM_NAME_BaseEncoding = 45,

        PDF_ENUM_NAME_BaseFont = 46,

        PDF_ENUM_NAME_BaseState = 47,

        PDF_ENUM_NAME_BitsPerComponent = 48,

        PDF_ENUM_NAME_BitsPerCoordinate = 49,

        PDF_ENUM_NAME_BitsPerFlag = 50,

        PDF_ENUM_NAME_BitsPerSample = 51,

        PDF_ENUM_NAME_BlackIs1 = 52,

        PDF_ENUM_NAME_BlackPoint = 53,

        PDF_ENUM_NAME_BleedBox = 54,

        PDF_ENUM_NAME_Blinds = 55,

        PDF_ENUM_NAME_Border = 56,

        PDF_ENUM_NAME_Bounds = 57,

        PDF_ENUM_NAME_Box = 58,

        PDF_ENUM_NAME_Bt = 59,

        PDF_ENUM_NAME_Btn = 60,

        PDF_ENUM_NAME_Butt = 61,

        PDF_ENUM_NAME_ByteRange = 62,

        PDF_ENUM_NAME_C = 63,

        PDF_ENUM_NAME_C0 = 64,

        PDF_ENUM_NAME_C1 = 65,

        PDF_ENUM_NAME_CA = 66,

        PDF_ENUM_NAME_CCF = 67,

        PDF_ENUM_NAME_CCITTFaxDecode = 68,

        PDF_ENUM_NAME_CF = 69,

        PDF_ENUM_NAME_CFM = 70,

        PDF_ENUM_NAME_CI = 71,

        PDF_ENUM_NAME_CIDFontType0 = 72,

        PDF_ENUM_NAME_CIDFontType0C = 73,

        PDF_ENUM_NAME_CIDFontType2 = 74,

        PDF_ENUM_NAME_CIDSystemInfo = 75,

        PDF_ENUM_NAME_CIDToGIDMap = 76,

        PDF_ENUM_NAME_CMYK = 77,

        PDF_ENUM_NAME_CS = 78,

        PDF_ENUM_NAME_CalCMYK = 79,

        PDF_ENUM_NAME_CalGray = 80,

        PDF_ENUM_NAME_CalRGB = 81,

        PDF_ENUM_NAME_CapHeight = 82,

        PDF_ENUM_NAME_Caret = 83,

        PDF_ENUM_NAME_Catalog = 84,

        PDF_ENUM_NAME_Cert = 85,

        PDF_ENUM_NAME_Ch = 86,

        PDF_ENUM_NAME_Changes = 87,

        PDF_ENUM_NAME_CharProcs = 88,

        PDF_ENUM_NAME_CheckSum = 89,

        PDF_ENUM_NAME_Circle = 90,

        PDF_ENUM_NAME_ClosedArrow = 91,

        PDF_ENUM_NAME_Collection = 92,

        PDF_ENUM_NAME_ColorSpace = 93,

        PDF_ENUM_NAME_ColorTransform = 94,

        PDF_ENUM_NAME_Colorants = 95,

        PDF_ENUM_NAME_Colors = 96,

        PDF_ENUM_NAME_Columns = 97,

        PDF_ENUM_NAME_Confidential = 98,

        PDF_ENUM_NAME_Configs = 99,

        PDF_ENUM_NAME_ContactInfo = 100,

        PDF_ENUM_NAME_Contents = 101,

        PDF_ENUM_NAME_Coords = 102,

        PDF_ENUM_NAME_Count = 103,

        PDF_ENUM_NAME_Cover = 104,

        PDF_ENUM_NAME_CreationDate = 105,

        PDF_ENUM_NAME_Creator = 106,

        PDF_ENUM_NAME_CropBox = 107,

        PDF_ENUM_NAME_Crypt = 108,

        PDF_ENUM_NAME_D = 109,

        PDF_ENUM_NAME_DA = 110,

        PDF_ENUM_NAME_DC = 111,

        PDF_ENUM_NAME_DCT = 112,

        PDF_ENUM_NAME_DCTDecode = 113,

        PDF_ENUM_NAME_DL = 114,

        PDF_ENUM_NAME_DOS = 115,

        PDF_ENUM_NAME_DP = 116,

        PDF_ENUM_NAME_DR = 117,

        PDF_ENUM_NAME_DS = 118,

        PDF_ENUM_NAME_DV = 119,

        PDF_ENUM_NAME_DW = 120,

        PDF_ENUM_NAME_DW2 = 121,

        PDF_ENUM_NAME_DamagedRowsBeforeError = 122,

        PDF_ENUM_NAME_Data = 123,

        PDF_ENUM_NAME_Date = 124,

        PDF_ENUM_NAME_Decode = 125,

        PDF_ENUM_NAME_DecodeParms = 126,

        PDF_ENUM_NAME_Default = 127,

        PDF_ENUM_NAME_DefaultCMYK = 128,

        PDF_ENUM_NAME_DefaultGray = 129,

        PDF_ENUM_NAME_DefaultRGB = 130,

        PDF_ENUM_NAME_Departmental = 131,

        PDF_ENUM_NAME_Desc = 132,

        PDF_ENUM_NAME_DescendantFonts = 133,

        PDF_ENUM_NAME_Descent = 134,

        PDF_ENUM_NAME_Design = 135,

        PDF_ENUM_NAME_Dest = 136,

        PDF_ENUM_NAME_DestOutputProfile = 137,

        PDF_ENUM_NAME_Dests = 138,

        PDF_ENUM_NAME_DeviceCMYK = 139,

        PDF_ENUM_NAME_DeviceGray = 140,

        PDF_ENUM_NAME_DeviceN = 141,

        PDF_ENUM_NAME_DeviceRGB = 142,

        PDF_ENUM_NAME_Di = 143,

        PDF_ENUM_NAME_Diamond = 144,

        PDF_ENUM_NAME_Differences = 145,

        PDF_ENUM_NAME_DigestLocation = 146,

        PDF_ENUM_NAME_DigestMethod = 147,

        PDF_ENUM_NAME_DigestValue = 148,

        PDF_ENUM_NAME_Dissolve = 149,

        PDF_ENUM_NAME_Dm = 150,

        PDF_ENUM_NAME_DocMDP = 151,

        PDF_ENUM_NAME_Document = 152,

        PDF_ENUM_NAME_Domain = 153,

        PDF_ENUM_NAME_Draft = 154,

        PDF_ENUM_NAME_Dur = 155,

        PDF_ENUM_NAME_E = 156,

        PDF_ENUM_NAME_EF = 157,

        PDF_ENUM_NAME_EarlyChange = 158,

        PDF_ENUM_NAME_EmbeddedFile = 159,

        PDF_ENUM_NAME_EmbeddedFiles = 160,

        PDF_ENUM_NAME_Encode = 161,

        PDF_ENUM_NAME_EncodedByteAlign = 162,

        PDF_ENUM_NAME_Encoding = 163,

        PDF_ENUM_NAME_Encrypt = 164,

        PDF_ENUM_NAME_EncryptMetadata = 165,

        PDF_ENUM_NAME_EndOfBlock = 166,

        PDF_ENUM_NAME_EndOfLine = 167,

        PDF_ENUM_NAME_Exclude = 168,

        PDF_ENUM_NAME_Experimental = 169,

        PDF_ENUM_NAME_Expired = 170,

        PDF_ENUM_NAME_ExtGState = 171,

        PDF_ENUM_NAME_Extend = 172,

        PDF_ENUM_NAME_F = 173,

        PDF_ENUM_NAME_FL = 174,

        PDF_ENUM_NAME_FRM = 175,

        PDF_ENUM_NAME_FS = 176,

        PDF_ENUM_NAME_FT = 177,

        PDF_ENUM_NAME_Fade = 178,

        PDF_ENUM_NAME_Ff = 179,

        PDF_ENUM_NAME_FieldMDP = 180,

        PDF_ENUM_NAME_Fields = 181,

        PDF_ENUM_NAME_FileAttachment = 182,

        PDF_ENUM_NAME_FileSize = 183,

        PDF_ENUM_NAME_Filespec = 184,

        PDF_ENUM_NAME_Filter = 185,

        PDF_ENUM_NAME_Final = 186,

        PDF_ENUM_NAME_Fingerprint = 187,

        PDF_ENUM_NAME_First = 188,

        PDF_ENUM_NAME_FirstChar = 189,

        PDF_ENUM_NAME_FirstPage = 190,

        PDF_ENUM_NAME_Fit = 191,

        PDF_ENUM_NAME_FitB = 192,

        PDF_ENUM_NAME_FitBH = 193,

        PDF_ENUM_NAME_FitBV = 194,

        PDF_ENUM_NAME_FitH = 195,

        PDF_ENUM_NAME_FitR = 196,

        PDF_ENUM_NAME_FitV = 197,

        PDF_ENUM_NAME_Fl = 198,

        PDF_ENUM_NAME_Flags = 199,

        PDF_ENUM_NAME_FlateDecode = 200,

        PDF_ENUM_NAME_Fly = 201,

        PDF_ENUM_NAME_Font = 202,

        PDF_ENUM_NAME_FontBBox = 203,

        PDF_ENUM_NAME_FontDescriptor = 204,

        PDF_ENUM_NAME_FontFile = 205,

        PDF_ENUM_NAME_FontFile2 = 206,

        PDF_ENUM_NAME_FontFile3 = 207,

        PDF_ENUM_NAME_FontMatrix = 208,

        PDF_ENUM_NAME_FontName = 209,

        PDF_ENUM_NAME_ForComment = 210,

        PDF_ENUM_NAME_ForPublicRelease = 211,

        PDF_ENUM_NAME_Form = 212,

        PDF_ENUM_NAME_FormEx = 213,

        PDF_ENUM_NAME_FormType = 214,

        PDF_ENUM_NAME_FreeText = 215,

        PDF_ENUM_NAME_Function = 216,

        PDF_ENUM_NAME_FunctionType = 217,

        PDF_ENUM_NAME_Functions = 218,

        PDF_ENUM_NAME_G = 219,

        PDF_ENUM_NAME_GTS_PDFX = 220,

        PDF_ENUM_NAME_Gamma = 221,

        PDF_ENUM_NAME_Glitter = 222,

        PDF_ENUM_NAME_GoTo = 223,

        PDF_ENUM_NAME_GoToR = 224,

        PDF_ENUM_NAME_Group = 225,

        PDF_ENUM_NAME_H = 226,

        PDF_ENUM_NAME_Height = 227,

        PDF_ENUM_NAME_Helv = 228,

        PDF_ENUM_NAME_Highlight = 229,

        PDF_ENUM_NAME_HistoryPos = 230,

        PDF_ENUM_NAME_I = 231,

        PDF_ENUM_NAME_IC = 232,

        PDF_ENUM_NAME_ICCBased = 233,

        PDF_ENUM_NAME_ID = 234,

        PDF_ENUM_NAME_IM = 235,

        PDF_ENUM_NAME_IRT = 236,

        PDF_ENUM_NAME_Identity = 237,

        PDF_ENUM_NAME_Identity_H = 238,

        PDF_ENUM_NAME_Identity_V = 239,

        PDF_ENUM_NAME_Image = 240,

        PDF_ENUM_NAME_ImageMask = 241,

        PDF_ENUM_NAME_Include = 242,

        PDF_ENUM_NAME_Index = 243,

        PDF_ENUM_NAME_Indexed = 244,

        PDF_ENUM_NAME_Info = 245,

        PDF_ENUM_NAME_Ink = 246,

        PDF_ENUM_NAME_InkList = 247,

        PDF_ENUM_NAME_Intent = 248,

        PDF_ENUM_NAME_Interpolate = 249,

        PDF_ENUM_NAME_IsMap = 250,

        PDF_ENUM_NAME_ItalicAngle = 251,

        PDF_ENUM_NAME_JBIG2Decode = 252,

        PDF_ENUM_NAME_JBIG2Globals = 253,

        PDF_ENUM_NAME_JPXDecode = 254,

        PDF_ENUM_NAME_JS = 255,

        PDF_ENUM_NAME_JavaScript = 256,

        PDF_ENUM_NAME_K = 257,

        PDF_ENUM_NAME_Keywords = 258,

        PDF_ENUM_NAME_Kids = 259,

        PDF_ENUM_NAME_L = 260,

        PDF_ENUM_NAME_LC = 261,

        PDF_ENUM_NAME_LE = 262,

        PDF_ENUM_NAME_LJ = 263,

        PDF_ENUM_NAME_LW = 264,

        PDF_ENUM_NAME_LZ = 265,

        PDF_ENUM_NAME_LZW = 266,

        PDF_ENUM_NAME_LZWDecode = 267,

        PDF_ENUM_NAME_Lab = 268,

        PDF_ENUM_NAME_Lang = 269,

        PDF_ENUM_NAME_Last = 270,

        PDF_ENUM_NAME_LastChar = 271,

        PDF_ENUM_NAME_LastPage = 272,

        PDF_ENUM_NAME_Launch = 273,

        PDF_ENUM_NAME_Length = 274,

        PDF_ENUM_NAME_Length1 = 275,

        PDF_ENUM_NAME_Length2 = 276,

        PDF_ENUM_NAME_Length3 = 277,

        PDF_ENUM_NAME_Limits = 278,

        PDF_ENUM_NAME_Line = 279,

        PDF_ENUM_NAME_Linearized = 280,

        PDF_ENUM_NAME_Link = 281,

        PDF_ENUM_NAME_Location = 282,

        PDF_ENUM_NAME_Lock = 283,

        PDF_ENUM_NAME_Locked = 284,

        PDF_ENUM_NAME_Luminosity = 285,

        PDF_ENUM_NAME_M = 286,

        PDF_ENUM_NAME_MCID = 287,

        PDF_ENUM_NAME_MK = 288,

        PDF_ENUM_NAME_ML = 289,

        PDF_ENUM_NAME_MMType1 = 290,

        PDF_ENUM_NAME_Mac = 291,

        PDF_ENUM_NAME_Mask = 292,

        PDF_ENUM_NAME_Matrix = 293,

        PDF_ENUM_NAME_Matte = 294,

        PDF_ENUM_NAME_MaxLen = 295,

        PDF_ENUM_NAME_MediaBox = 296,

        PDF_ENUM_NAME_Metadata = 297,

        PDF_ENUM_NAME_MissingWidth = 298,

        PDF_ENUM_NAME_ModDate = 299,

        PDF_ENUM_NAME_Movie = 300,

        PDF_ENUM_NAME_Msg = 301,

        PDF_ENUM_NAME_Multiply = 302,

        PDF_ENUM_NAME_N = 303,

        PDF_ENUM_NAME_Name = 304,

        PDF_ENUM_NAME_Named = 305,

        PDF_ENUM_NAME_Names = 306,

        PDF_ENUM_NAME_NewWindow = 307,

        PDF_ENUM_NAME_Next = 308,

        PDF_ENUM_NAME_NextPage = 309,

        PDF_ENUM_NAME_NonEFontNoWarn = 310,

        PDF_ENUM_NAME_None = 311,

        PDF_ENUM_NAME_Normal = 312,

        PDF_ENUM_NAME_NotApproved = 313,

        PDF_ENUM_NAME_NotForPublicRelease = 314,

        PDF_ENUM_NAME_NumSections = 315,

        PDF_ENUM_NAME_Nums = 316,

        PDF_ENUM_NAME_O = 317,

        PDF_ENUM_NAME_OC = 318,

        PDF_ENUM_NAME_OCG = 319,

        PDF_ENUM_NAME_OCGs = 320,

        PDF_ENUM_NAME_OCMD = 321,

        PDF_ENUM_NAME_OCProperties = 322,

        PDF_ENUM_NAME_OE = 323,

        PDF_ENUM_NAME_OFF = 324,

        PDF_ENUM_NAME_ON = 325,

        PDF_ENUM_NAME_OP = 326,

        PDF_ENUM_NAME_OPM = 327,

        PDF_ENUM_NAME_OS = 328,

        PDF_ENUM_NAME_ObjStm = 329,

        PDF_ENUM_NAME_Of = 330,

        PDF_ENUM_NAME_Off = 331,

        PDF_ENUM_NAME_Open = 332,

        PDF_ENUM_NAME_OpenArrow = 333,

        PDF_ENUM_NAME_OpenType = 334,

        PDF_ENUM_NAME_Opt = 335,

        PDF_ENUM_NAME_Order = 336,

        PDF_ENUM_NAME_Ordering = 337,

        PDF_ENUM_NAME_Outlines = 338,

        PDF_ENUM_NAME_OutputCondition = 339,

        PDF_ENUM_NAME_OutputConditionIdentifier = 340,

        PDF_ENUM_NAME_OutputIntent = 341,

        PDF_ENUM_NAME_OutputIntents = 342,

        PDF_ENUM_NAME_P = 343,

        PDF_ENUM_NAME_PDF = 344,

        PDF_ENUM_NAME_PS = 345,

        PDF_ENUM_NAME_Page = 346,

        PDF_ENUM_NAME_PageMode = 347,

        PDF_ENUM_NAME_Pages = 348,

        PDF_ENUM_NAME_PaintType = 349,

        PDF_ENUM_NAME_Params = 350,

        PDF_ENUM_NAME_Parent = 351,

        PDF_ENUM_NAME_Pattern = 352,

        PDF_ENUM_NAME_PatternType = 353,

        PDF_ENUM_NAME_Perms = 354,

        PDF_ENUM_NAME_PolyLine = 355,

        PDF_ENUM_NAME_Polygon = 356,

        PDF_ENUM_NAME_Popup = 357,

        PDF_ENUM_NAME_PreRelease = 358,

        PDF_ENUM_NAME_Predictor = 359,

        PDF_ENUM_NAME_Prev = 360,

        PDF_ENUM_NAME_PrevPage = 361,

        PDF_ENUM_NAME_Preview = 362,

        PDF_ENUM_NAME_Print = 363,

        PDF_ENUM_NAME_PrinterMark = 364,

        PDF_ENUM_NAME_ProcSet = 365,

        PDF_ENUM_NAME_Producer = 366,

        PDF_ENUM_NAME_Properties = 367,

        PDF_ENUM_NAME_Prop_AuthTime = 368,

        PDF_ENUM_NAME_Prop_AuthType = 369,

        PDF_ENUM_NAME_Prop_Build = 370,

        PDF_ENUM_NAME_PubSec = 371,

        PDF_ENUM_NAME_Push = 372,

        PDF_ENUM_NAME_Q = 373,

        PDF_ENUM_NAME_QuadPoints = 374,

        PDF_ENUM_NAME_R = 375,

        PDF_ENUM_NAME_RBGroups = 376,

        PDF_ENUM_NAME_RC = 377,

        PDF_ENUM_NAME_RClosedArrow = 378,

        PDF_ENUM_NAME_REx = 379,

        PDF_ENUM_NAME_RGB = 380,

        PDF_ENUM_NAME_RI = 381,

        PDF_ENUM_NAME_RL = 382,

        PDF_ENUM_NAME_ROpenArrow = 383,

        PDF_ENUM_NAME_Range = 384,

        PDF_ENUM_NAME_Reason = 385,

        PDF_ENUM_NAME_Rect = 386,

        PDF_ENUM_NAME_Redact = 387,

        PDF_ENUM_NAME_Ref = 388,

        PDF_ENUM_NAME_Reference = 389,

        PDF_ENUM_NAME_Registry = 390,

        PDF_ENUM_NAME_ResetForm = 391,

        PDF_ENUM_NAME_Resources = 392,

        PDF_ENUM_NAME_Root = 393,

        PDF_ENUM_NAME_Rotate = 394,

        PDF_ENUM_NAME_Rows = 395,

        PDF_ENUM_NAME_RunLengthDecode = 396,

        PDF_ENUM_NAME_S = 397,

        PDF_ENUM_NAME_SMask = 398,

        PDF_ENUM_NAME_SMaskInData = 399,

        PDF_ENUM_NAME_Schema = 400,

        PDF_ENUM_NAME_Screen = 401,

        PDF_ENUM_NAME_Separation = 402,

        PDF_ENUM_NAME_Shading = 403,

        PDF_ENUM_NAME_ShadingType = 404,

        PDF_ENUM_NAME_Si = 405,

        PDF_ENUM_NAME_Sig = 406,

        PDF_ENUM_NAME_SigFlags = 407,

        PDF_ENUM_NAME_SigQ = 408,

        PDF_ENUM_NAME_SigRef = 409,

        PDF_ENUM_NAME_Size = 410,

        PDF_ENUM_NAME_Slash = 411,

        PDF_ENUM_NAME_Sold = 412,

        PDF_ENUM_NAME_Sound = 413,

        PDF_ENUM_NAME_Split = 414,

        PDF_ENUM_NAME_Square = 415,

        PDF_ENUM_NAME_Squiggly = 416,

        PDF_ENUM_NAME_Stamp = 417,

        PDF_ENUM_NAME_Standard = 418,

        PDF_ENUM_NAME_StdCF = 419,

        PDF_ENUM_NAME_StemV = 420,

        PDF_ENUM_NAME_StmF = 421,

        PDF_ENUM_NAME_StrF = 422,

        PDF_ENUM_NAME_StrikeOut = 423,

        PDF_ENUM_NAME_StructParent = 424,

        PDF_ENUM_NAME_StructParents = 425,

        PDF_ENUM_NAME_SubFilter = 426,

        PDF_ENUM_NAME_Subject = 427,

        PDF_ENUM_NAME_Subtype = 428,

        PDF_ENUM_NAME_Subtype2 = 429,

        PDF_ENUM_NAME_Supplement = 430,

        PDF_ENUM_NAME_Symb = 431,

        PDF_ENUM_NAME_T = 432,

        PDF_ENUM_NAME_TI = 433,

        PDF_ENUM_NAME_TR = 434,

        PDF_ENUM_NAME_TR2 = 435,

        PDF_ENUM_NAME_TU = 436,

        PDF_ENUM_NAME_Text = 437,

        PDF_ENUM_NAME_TilingType = 438,

        PDF_ENUM_NAME_Times = 439,

        PDF_ENUM_NAME_Title = 440,

        PDF_ENUM_NAME_ToUnicode = 441,

        PDF_ENUM_NAME_TopSecret = 442,

        PDF_ENUM_NAME_Trans = 443,

        PDF_ENUM_NAME_TransformMethod = 444,

        PDF_ENUM_NAME_TransformParams = 445,

        PDF_ENUM_NAME_Transparency = 446,

        PDF_ENUM_NAME_TrapNet = 447,

        PDF_ENUM_NAME_TrimBox = 448,

        PDF_ENUM_NAME_TrueType = 449,

        PDF_ENUM_NAME_TrustedMode = 450,

        PDF_ENUM_NAME_Tx = 451,

        PDF_ENUM_NAME_Type = 452,

        PDF_ENUM_NAME_Type0 = 453,

        PDF_ENUM_NAME_Type1 = 454,

        PDF_ENUM_NAME_Type1C = 455,

        PDF_ENUM_NAME_Type3 = 456,

        PDF_ENUM_NAME_U = 457,

        PDF_ENUM_NAME_UE = 458,

        PDF_ENUM_NAME_UF = 459,

        PDF_ENUM_NAME_URI = 460,

        PDF_ENUM_NAME_URL = 461,

        PDF_ENUM_NAME_Unchanged = 462,

        PDF_ENUM_NAME_Uncover = 463,

        PDF_ENUM_NAME_Underline = 464,

        PDF_ENUM_NAME_Unix = 465,

        PDF_ENUM_NAME_Usage = 466,

        PDF_ENUM_NAME_UseBlackPtComp = 467,

        PDF_ENUM_NAME_UseCMap = 468,

        PDF_ENUM_NAME_UseOutlines = 469,

        PDF_ENUM_NAME_UserUnit = 470,

        PDF_ENUM_NAME_V = 471,

        PDF_ENUM_NAME_V2 = 472,

        PDF_ENUM_NAME_VE = 473,

        PDF_ENUM_NAME_Version = 474,

        PDF_ENUM_NAME_Vertices = 475,

        PDF_ENUM_NAME_VerticesPerRow = 476,

        PDF_ENUM_NAME_View = 477,

        PDF_ENUM_NAME_W = 478,

        PDF_ENUM_NAME_W2 = 479,

        PDF_ENUM_NAME_WMode = 480,

        PDF_ENUM_NAME_Watermark = 481,

        PDF_ENUM_NAME_WhitePoint = 482,

        PDF_ENUM_NAME_Widget = 483,

        PDF_ENUM_NAME_Width = 484,

        PDF_ENUM_NAME_Widths = 485,

        PDF_ENUM_NAME_WinAnsiEncoding = 486,

        PDF_ENUM_NAME_Wipe = 487,

        PDF_ENUM_NAME_XFA = 488,

        PDF_ENUM_NAME_XHeight = 489,

        PDF_ENUM_NAME_XML = 490,

        PDF_ENUM_NAME_XObject = 491,

        PDF_ENUM_NAME_XRef = 492,

        PDF_ENUM_NAME_XRefStm = 493,

        PDF_ENUM_NAME_XStep = 494,

        PDF_ENUM_NAME_XYZ = 495,

        PDF_ENUM_NAME_YStep = 496,

        PDF_ENUM_NAME_Yes = 497,

        PDF_ENUM_NAME_ZaDb = 498,

        PDF_ENUM_NAME_adbe_pkcs7_detached = 499,

        PDF_ENUM_NAME_ca = 500,

        PDF_ENUM_NAME_n0 = 501,

        PDF_ENUM_NAME_n1 = 502,

        PDF_ENUM_NAME_n2 = 503,

        PDF_ENUM_NAME_op = 504,

        PDF_ENUM_LIMIT = 505,
    }
    enum PDF_ENUM_NULL = _Anonymous_4.PDF_ENUM_NULL;
    enum PDF_ENUM_TRUE = _Anonymous_4.PDF_ENUM_TRUE;
    enum PDF_ENUM_FALSE = _Anonymous_4.PDF_ENUM_FALSE;
    enum PDF_ENUM_NAME_1_2 = _Anonymous_4.PDF_ENUM_NAME_1_2;
    enum PDF_ENUM_NAME_3D = _Anonymous_4.PDF_ENUM_NAME_3D;
    enum PDF_ENUM_NAME_A = _Anonymous_4.PDF_ENUM_NAME_A;
    enum PDF_ENUM_NAME_A85 = _Anonymous_4.PDF_ENUM_NAME_A85;
    enum PDF_ENUM_NAME_AA = _Anonymous_4.PDF_ENUM_NAME_AA;
    enum PDF_ENUM_NAME_AC = _Anonymous_4.PDF_ENUM_NAME_AC;
    enum PDF_ENUM_NAME_AESV2 = _Anonymous_4.PDF_ENUM_NAME_AESV2;
    enum PDF_ENUM_NAME_AESV3 = _Anonymous_4.PDF_ENUM_NAME_AESV3;
    enum PDF_ENUM_NAME_AHx = _Anonymous_4.PDF_ENUM_NAME_AHx;
    enum PDF_ENUM_NAME_AP = _Anonymous_4.PDF_ENUM_NAME_AP;
    enum PDF_ENUM_NAME_AS = _Anonymous_4.PDF_ENUM_NAME_AS;
    enum PDF_ENUM_NAME_ASCII85Decode = _Anonymous_4.PDF_ENUM_NAME_ASCII85Decode;
    enum PDF_ENUM_NAME_ASCIIHexDecode = _Anonymous_4.PDF_ENUM_NAME_ASCIIHexDecode;
    enum PDF_ENUM_NAME_AcroForm = _Anonymous_4.PDF_ENUM_NAME_AcroForm;
    enum PDF_ENUM_NAME_Action = _Anonymous_4.PDF_ENUM_NAME_Action;
    enum PDF_ENUM_NAME_ActualText = _Anonymous_4.PDF_ENUM_NAME_ActualText;
    enum PDF_ENUM_NAME_Adobe_PPKLite = _Anonymous_4.PDF_ENUM_NAME_Adobe_PPKLite;
    enum PDF_ENUM_NAME_All = _Anonymous_4.PDF_ENUM_NAME_All;
    enum PDF_ENUM_NAME_AllOff = _Anonymous_4.PDF_ENUM_NAME_AllOff;
    enum PDF_ENUM_NAME_AllOn = _Anonymous_4.PDF_ENUM_NAME_AllOn;
    enum PDF_ENUM_NAME_Alpha = _Anonymous_4.PDF_ENUM_NAME_Alpha;
    enum PDF_ENUM_NAME_Alt = _Anonymous_4.PDF_ENUM_NAME_Alt;
    enum PDF_ENUM_NAME_Alternate = _Anonymous_4.PDF_ENUM_NAME_Alternate;
    enum PDF_ENUM_NAME_Annot = _Anonymous_4.PDF_ENUM_NAME_Annot;
    enum PDF_ENUM_NAME_Annots = _Anonymous_4.PDF_ENUM_NAME_Annots;
    enum PDF_ENUM_NAME_AnyOff = _Anonymous_4.PDF_ENUM_NAME_AnyOff;
    enum PDF_ENUM_NAME_App = _Anonymous_4.PDF_ENUM_NAME_App;
    enum PDF_ENUM_NAME_Approved = _Anonymous_4.PDF_ENUM_NAME_Approved;
    enum PDF_ENUM_NAME_ArtBox = _Anonymous_4.PDF_ENUM_NAME_ArtBox;
    enum PDF_ENUM_NAME_AsIs = _Anonymous_4.PDF_ENUM_NAME_AsIs;
    enum PDF_ENUM_NAME_Ascent = _Anonymous_4.PDF_ENUM_NAME_Ascent;
    enum PDF_ENUM_NAME_AuthEvent = _Anonymous_4.PDF_ENUM_NAME_AuthEvent;
    enum PDF_ENUM_NAME_Author = _Anonymous_4.PDF_ENUM_NAME_Author;
    enum PDF_ENUM_NAME_B = _Anonymous_4.PDF_ENUM_NAME_B;
    enum PDF_ENUM_NAME_BBox = _Anonymous_4.PDF_ENUM_NAME_BBox;
    enum PDF_ENUM_NAME_BC = _Anonymous_4.PDF_ENUM_NAME_BC;
    enum PDF_ENUM_NAME_BE = _Anonymous_4.PDF_ENUM_NAME_BE;
    enum PDF_ENUM_NAME_BG = _Anonymous_4.PDF_ENUM_NAME_BG;
    enum PDF_ENUM_NAME_BM = _Anonymous_4.PDF_ENUM_NAME_BM;
    enum PDF_ENUM_NAME_BPC = _Anonymous_4.PDF_ENUM_NAME_BPC;
    enum PDF_ENUM_NAME_BS = _Anonymous_4.PDF_ENUM_NAME_BS;
    enum PDF_ENUM_NAME_Background = _Anonymous_4.PDF_ENUM_NAME_Background;
    enum PDF_ENUM_NAME_BaseEncoding = _Anonymous_4.PDF_ENUM_NAME_BaseEncoding;
    enum PDF_ENUM_NAME_BaseFont = _Anonymous_4.PDF_ENUM_NAME_BaseFont;
    enum PDF_ENUM_NAME_BaseState = _Anonymous_4.PDF_ENUM_NAME_BaseState;
    enum PDF_ENUM_NAME_BitsPerComponent = _Anonymous_4.PDF_ENUM_NAME_BitsPerComponent;
    enum PDF_ENUM_NAME_BitsPerCoordinate = _Anonymous_4.PDF_ENUM_NAME_BitsPerCoordinate;
    enum PDF_ENUM_NAME_BitsPerFlag = _Anonymous_4.PDF_ENUM_NAME_BitsPerFlag;
    enum PDF_ENUM_NAME_BitsPerSample = _Anonymous_4.PDF_ENUM_NAME_BitsPerSample;
    enum PDF_ENUM_NAME_BlackIs1 = _Anonymous_4.PDF_ENUM_NAME_BlackIs1;
    enum PDF_ENUM_NAME_BlackPoint = _Anonymous_4.PDF_ENUM_NAME_BlackPoint;
    enum PDF_ENUM_NAME_BleedBox = _Anonymous_4.PDF_ENUM_NAME_BleedBox;
    enum PDF_ENUM_NAME_Blinds = _Anonymous_4.PDF_ENUM_NAME_Blinds;
    enum PDF_ENUM_NAME_Border = _Anonymous_4.PDF_ENUM_NAME_Border;
    enum PDF_ENUM_NAME_Bounds = _Anonymous_4.PDF_ENUM_NAME_Bounds;
    enum PDF_ENUM_NAME_Box = _Anonymous_4.PDF_ENUM_NAME_Box;
    enum PDF_ENUM_NAME_Bt = _Anonymous_4.PDF_ENUM_NAME_Bt;
    enum PDF_ENUM_NAME_Btn = _Anonymous_4.PDF_ENUM_NAME_Btn;
    enum PDF_ENUM_NAME_Butt = _Anonymous_4.PDF_ENUM_NAME_Butt;
    enum PDF_ENUM_NAME_ByteRange = _Anonymous_4.PDF_ENUM_NAME_ByteRange;
    enum PDF_ENUM_NAME_C = _Anonymous_4.PDF_ENUM_NAME_C;
    enum PDF_ENUM_NAME_C0 = _Anonymous_4.PDF_ENUM_NAME_C0;
    enum PDF_ENUM_NAME_C1 = _Anonymous_4.PDF_ENUM_NAME_C1;
    enum PDF_ENUM_NAME_CA = _Anonymous_4.PDF_ENUM_NAME_CA;
    enum PDF_ENUM_NAME_CCF = _Anonymous_4.PDF_ENUM_NAME_CCF;
    enum PDF_ENUM_NAME_CCITTFaxDecode = _Anonymous_4.PDF_ENUM_NAME_CCITTFaxDecode;
    enum PDF_ENUM_NAME_CF = _Anonymous_4.PDF_ENUM_NAME_CF;
    enum PDF_ENUM_NAME_CFM = _Anonymous_4.PDF_ENUM_NAME_CFM;
    enum PDF_ENUM_NAME_CI = _Anonymous_4.PDF_ENUM_NAME_CI;
    enum PDF_ENUM_NAME_CIDFontType0 = _Anonymous_4.PDF_ENUM_NAME_CIDFontType0;
    enum PDF_ENUM_NAME_CIDFontType0C = _Anonymous_4.PDF_ENUM_NAME_CIDFontType0C;
    enum PDF_ENUM_NAME_CIDFontType2 = _Anonymous_4.PDF_ENUM_NAME_CIDFontType2;
    enum PDF_ENUM_NAME_CIDSystemInfo = _Anonymous_4.PDF_ENUM_NAME_CIDSystemInfo;
    enum PDF_ENUM_NAME_CIDToGIDMap = _Anonymous_4.PDF_ENUM_NAME_CIDToGIDMap;
    enum PDF_ENUM_NAME_CMYK = _Anonymous_4.PDF_ENUM_NAME_CMYK;
    enum PDF_ENUM_NAME_CS = _Anonymous_4.PDF_ENUM_NAME_CS;
    enum PDF_ENUM_NAME_CalCMYK = _Anonymous_4.PDF_ENUM_NAME_CalCMYK;
    enum PDF_ENUM_NAME_CalGray = _Anonymous_4.PDF_ENUM_NAME_CalGray;
    enum PDF_ENUM_NAME_CalRGB = _Anonymous_4.PDF_ENUM_NAME_CalRGB;
    enum PDF_ENUM_NAME_CapHeight = _Anonymous_4.PDF_ENUM_NAME_CapHeight;
    enum PDF_ENUM_NAME_Caret = _Anonymous_4.PDF_ENUM_NAME_Caret;
    enum PDF_ENUM_NAME_Catalog = _Anonymous_4.PDF_ENUM_NAME_Catalog;
    enum PDF_ENUM_NAME_Cert = _Anonymous_4.PDF_ENUM_NAME_Cert;
    enum PDF_ENUM_NAME_Ch = _Anonymous_4.PDF_ENUM_NAME_Ch;
    enum PDF_ENUM_NAME_Changes = _Anonymous_4.PDF_ENUM_NAME_Changes;
    enum PDF_ENUM_NAME_CharProcs = _Anonymous_4.PDF_ENUM_NAME_CharProcs;
    enum PDF_ENUM_NAME_CheckSum = _Anonymous_4.PDF_ENUM_NAME_CheckSum;
    enum PDF_ENUM_NAME_Circle = _Anonymous_4.PDF_ENUM_NAME_Circle;
    enum PDF_ENUM_NAME_ClosedArrow = _Anonymous_4.PDF_ENUM_NAME_ClosedArrow;
    enum PDF_ENUM_NAME_Collection = _Anonymous_4.PDF_ENUM_NAME_Collection;
    enum PDF_ENUM_NAME_ColorSpace = _Anonymous_4.PDF_ENUM_NAME_ColorSpace;
    enum PDF_ENUM_NAME_ColorTransform = _Anonymous_4.PDF_ENUM_NAME_ColorTransform;
    enum PDF_ENUM_NAME_Colorants = _Anonymous_4.PDF_ENUM_NAME_Colorants;
    enum PDF_ENUM_NAME_Colors = _Anonymous_4.PDF_ENUM_NAME_Colors;
    enum PDF_ENUM_NAME_Columns = _Anonymous_4.PDF_ENUM_NAME_Columns;
    enum PDF_ENUM_NAME_Confidential = _Anonymous_4.PDF_ENUM_NAME_Confidential;
    enum PDF_ENUM_NAME_Configs = _Anonymous_4.PDF_ENUM_NAME_Configs;
    enum PDF_ENUM_NAME_ContactInfo = _Anonymous_4.PDF_ENUM_NAME_ContactInfo;
    enum PDF_ENUM_NAME_Contents = _Anonymous_4.PDF_ENUM_NAME_Contents;
    enum PDF_ENUM_NAME_Coords = _Anonymous_4.PDF_ENUM_NAME_Coords;
    enum PDF_ENUM_NAME_Count = _Anonymous_4.PDF_ENUM_NAME_Count;
    enum PDF_ENUM_NAME_Cover = _Anonymous_4.PDF_ENUM_NAME_Cover;
    enum PDF_ENUM_NAME_CreationDate = _Anonymous_4.PDF_ENUM_NAME_CreationDate;
    enum PDF_ENUM_NAME_Creator = _Anonymous_4.PDF_ENUM_NAME_Creator;
    enum PDF_ENUM_NAME_CropBox = _Anonymous_4.PDF_ENUM_NAME_CropBox;
    enum PDF_ENUM_NAME_Crypt = _Anonymous_4.PDF_ENUM_NAME_Crypt;
    enum PDF_ENUM_NAME_D = _Anonymous_4.PDF_ENUM_NAME_D;
    enum PDF_ENUM_NAME_DA = _Anonymous_4.PDF_ENUM_NAME_DA;
    enum PDF_ENUM_NAME_DC = _Anonymous_4.PDF_ENUM_NAME_DC;
    enum PDF_ENUM_NAME_DCT = _Anonymous_4.PDF_ENUM_NAME_DCT;
    enum PDF_ENUM_NAME_DCTDecode = _Anonymous_4.PDF_ENUM_NAME_DCTDecode;
    enum PDF_ENUM_NAME_DL = _Anonymous_4.PDF_ENUM_NAME_DL;
    enum PDF_ENUM_NAME_DOS = _Anonymous_4.PDF_ENUM_NAME_DOS;
    enum PDF_ENUM_NAME_DP = _Anonymous_4.PDF_ENUM_NAME_DP;
    enum PDF_ENUM_NAME_DR = _Anonymous_4.PDF_ENUM_NAME_DR;
    enum PDF_ENUM_NAME_DS = _Anonymous_4.PDF_ENUM_NAME_DS;
    enum PDF_ENUM_NAME_DV = _Anonymous_4.PDF_ENUM_NAME_DV;
    enum PDF_ENUM_NAME_DW = _Anonymous_4.PDF_ENUM_NAME_DW;
    enum PDF_ENUM_NAME_DW2 = _Anonymous_4.PDF_ENUM_NAME_DW2;
    enum PDF_ENUM_NAME_DamagedRowsBeforeError = _Anonymous_4.PDF_ENUM_NAME_DamagedRowsBeforeError;
    enum PDF_ENUM_NAME_Data = _Anonymous_4.PDF_ENUM_NAME_Data;
    enum PDF_ENUM_NAME_Date = _Anonymous_4.PDF_ENUM_NAME_Date;
    enum PDF_ENUM_NAME_Decode = _Anonymous_4.PDF_ENUM_NAME_Decode;
    enum PDF_ENUM_NAME_DecodeParms = _Anonymous_4.PDF_ENUM_NAME_DecodeParms;
    enum PDF_ENUM_NAME_Default = _Anonymous_4.PDF_ENUM_NAME_Default;
    enum PDF_ENUM_NAME_DefaultCMYK = _Anonymous_4.PDF_ENUM_NAME_DefaultCMYK;
    enum PDF_ENUM_NAME_DefaultGray = _Anonymous_4.PDF_ENUM_NAME_DefaultGray;
    enum PDF_ENUM_NAME_DefaultRGB = _Anonymous_4.PDF_ENUM_NAME_DefaultRGB;
    enum PDF_ENUM_NAME_Departmental = _Anonymous_4.PDF_ENUM_NAME_Departmental;
    enum PDF_ENUM_NAME_Desc = _Anonymous_4.PDF_ENUM_NAME_Desc;
    enum PDF_ENUM_NAME_DescendantFonts = _Anonymous_4.PDF_ENUM_NAME_DescendantFonts;
    enum PDF_ENUM_NAME_Descent = _Anonymous_4.PDF_ENUM_NAME_Descent;
    enum PDF_ENUM_NAME_Design = _Anonymous_4.PDF_ENUM_NAME_Design;
    enum PDF_ENUM_NAME_Dest = _Anonymous_4.PDF_ENUM_NAME_Dest;
    enum PDF_ENUM_NAME_DestOutputProfile = _Anonymous_4.PDF_ENUM_NAME_DestOutputProfile;
    enum PDF_ENUM_NAME_Dests = _Anonymous_4.PDF_ENUM_NAME_Dests;
    enum PDF_ENUM_NAME_DeviceCMYK = _Anonymous_4.PDF_ENUM_NAME_DeviceCMYK;
    enum PDF_ENUM_NAME_DeviceGray = _Anonymous_4.PDF_ENUM_NAME_DeviceGray;
    enum PDF_ENUM_NAME_DeviceN = _Anonymous_4.PDF_ENUM_NAME_DeviceN;
    enum PDF_ENUM_NAME_DeviceRGB = _Anonymous_4.PDF_ENUM_NAME_DeviceRGB;
    enum PDF_ENUM_NAME_Di = _Anonymous_4.PDF_ENUM_NAME_Di;
    enum PDF_ENUM_NAME_Diamond = _Anonymous_4.PDF_ENUM_NAME_Diamond;
    enum PDF_ENUM_NAME_Differences = _Anonymous_4.PDF_ENUM_NAME_Differences;
    enum PDF_ENUM_NAME_DigestLocation = _Anonymous_4.PDF_ENUM_NAME_DigestLocation;
    enum PDF_ENUM_NAME_DigestMethod = _Anonymous_4.PDF_ENUM_NAME_DigestMethod;
    enum PDF_ENUM_NAME_DigestValue = _Anonymous_4.PDF_ENUM_NAME_DigestValue;
    enum PDF_ENUM_NAME_Dissolve = _Anonymous_4.PDF_ENUM_NAME_Dissolve;
    enum PDF_ENUM_NAME_Dm = _Anonymous_4.PDF_ENUM_NAME_Dm;
    enum PDF_ENUM_NAME_DocMDP = _Anonymous_4.PDF_ENUM_NAME_DocMDP;
    enum PDF_ENUM_NAME_Document = _Anonymous_4.PDF_ENUM_NAME_Document;
    enum PDF_ENUM_NAME_Domain = _Anonymous_4.PDF_ENUM_NAME_Domain;
    enum PDF_ENUM_NAME_Draft = _Anonymous_4.PDF_ENUM_NAME_Draft;
    enum PDF_ENUM_NAME_Dur = _Anonymous_4.PDF_ENUM_NAME_Dur;
    enum PDF_ENUM_NAME_E = _Anonymous_4.PDF_ENUM_NAME_E;
    enum PDF_ENUM_NAME_EF = _Anonymous_4.PDF_ENUM_NAME_EF;
    enum PDF_ENUM_NAME_EarlyChange = _Anonymous_4.PDF_ENUM_NAME_EarlyChange;
    enum PDF_ENUM_NAME_EmbeddedFile = _Anonymous_4.PDF_ENUM_NAME_EmbeddedFile;
    enum PDF_ENUM_NAME_EmbeddedFiles = _Anonymous_4.PDF_ENUM_NAME_EmbeddedFiles;
    enum PDF_ENUM_NAME_Encode = _Anonymous_4.PDF_ENUM_NAME_Encode;
    enum PDF_ENUM_NAME_EncodedByteAlign = _Anonymous_4.PDF_ENUM_NAME_EncodedByteAlign;
    enum PDF_ENUM_NAME_Encoding = _Anonymous_4.PDF_ENUM_NAME_Encoding;
    enum PDF_ENUM_NAME_Encrypt = _Anonymous_4.PDF_ENUM_NAME_Encrypt;
    enum PDF_ENUM_NAME_EncryptMetadata = _Anonymous_4.PDF_ENUM_NAME_EncryptMetadata;
    enum PDF_ENUM_NAME_EndOfBlock = _Anonymous_4.PDF_ENUM_NAME_EndOfBlock;
    enum PDF_ENUM_NAME_EndOfLine = _Anonymous_4.PDF_ENUM_NAME_EndOfLine;
    enum PDF_ENUM_NAME_Exclude = _Anonymous_4.PDF_ENUM_NAME_Exclude;
    enum PDF_ENUM_NAME_Experimental = _Anonymous_4.PDF_ENUM_NAME_Experimental;
    enum PDF_ENUM_NAME_Expired = _Anonymous_4.PDF_ENUM_NAME_Expired;
    enum PDF_ENUM_NAME_ExtGState = _Anonymous_4.PDF_ENUM_NAME_ExtGState;
    enum PDF_ENUM_NAME_Extend = _Anonymous_4.PDF_ENUM_NAME_Extend;
    enum PDF_ENUM_NAME_F = _Anonymous_4.PDF_ENUM_NAME_F;
    enum PDF_ENUM_NAME_FL = _Anonymous_4.PDF_ENUM_NAME_FL;
    enum PDF_ENUM_NAME_FRM = _Anonymous_4.PDF_ENUM_NAME_FRM;
    enum PDF_ENUM_NAME_FS = _Anonymous_4.PDF_ENUM_NAME_FS;
    enum PDF_ENUM_NAME_FT = _Anonymous_4.PDF_ENUM_NAME_FT;
    enum PDF_ENUM_NAME_Fade = _Anonymous_4.PDF_ENUM_NAME_Fade;
    enum PDF_ENUM_NAME_Ff = _Anonymous_4.PDF_ENUM_NAME_Ff;
    enum PDF_ENUM_NAME_FieldMDP = _Anonymous_4.PDF_ENUM_NAME_FieldMDP;
    enum PDF_ENUM_NAME_Fields = _Anonymous_4.PDF_ENUM_NAME_Fields;
    enum PDF_ENUM_NAME_FileAttachment = _Anonymous_4.PDF_ENUM_NAME_FileAttachment;
    enum PDF_ENUM_NAME_FileSize = _Anonymous_4.PDF_ENUM_NAME_FileSize;
    enum PDF_ENUM_NAME_Filespec = _Anonymous_4.PDF_ENUM_NAME_Filespec;
    enum PDF_ENUM_NAME_Filter = _Anonymous_4.PDF_ENUM_NAME_Filter;
    enum PDF_ENUM_NAME_Final = _Anonymous_4.PDF_ENUM_NAME_Final;
    enum PDF_ENUM_NAME_Fingerprint = _Anonymous_4.PDF_ENUM_NAME_Fingerprint;
    enum PDF_ENUM_NAME_First = _Anonymous_4.PDF_ENUM_NAME_First;
    enum PDF_ENUM_NAME_FirstChar = _Anonymous_4.PDF_ENUM_NAME_FirstChar;
    enum PDF_ENUM_NAME_FirstPage = _Anonymous_4.PDF_ENUM_NAME_FirstPage;
    enum PDF_ENUM_NAME_Fit = _Anonymous_4.PDF_ENUM_NAME_Fit;
    enum PDF_ENUM_NAME_FitB = _Anonymous_4.PDF_ENUM_NAME_FitB;
    enum PDF_ENUM_NAME_FitBH = _Anonymous_4.PDF_ENUM_NAME_FitBH;
    enum PDF_ENUM_NAME_FitBV = _Anonymous_4.PDF_ENUM_NAME_FitBV;
    enum PDF_ENUM_NAME_FitH = _Anonymous_4.PDF_ENUM_NAME_FitH;
    enum PDF_ENUM_NAME_FitR = _Anonymous_4.PDF_ENUM_NAME_FitR;
    enum PDF_ENUM_NAME_FitV = _Anonymous_4.PDF_ENUM_NAME_FitV;
    enum PDF_ENUM_NAME_Fl = _Anonymous_4.PDF_ENUM_NAME_Fl;
    enum PDF_ENUM_NAME_Flags = _Anonymous_4.PDF_ENUM_NAME_Flags;
    enum PDF_ENUM_NAME_FlateDecode = _Anonymous_4.PDF_ENUM_NAME_FlateDecode;
    enum PDF_ENUM_NAME_Fly = _Anonymous_4.PDF_ENUM_NAME_Fly;
    enum PDF_ENUM_NAME_Font = _Anonymous_4.PDF_ENUM_NAME_Font;
    enum PDF_ENUM_NAME_FontBBox = _Anonymous_4.PDF_ENUM_NAME_FontBBox;
    enum PDF_ENUM_NAME_FontDescriptor = _Anonymous_4.PDF_ENUM_NAME_FontDescriptor;
    enum PDF_ENUM_NAME_FontFile = _Anonymous_4.PDF_ENUM_NAME_FontFile;
    enum PDF_ENUM_NAME_FontFile2 = _Anonymous_4.PDF_ENUM_NAME_FontFile2;
    enum PDF_ENUM_NAME_FontFile3 = _Anonymous_4.PDF_ENUM_NAME_FontFile3;
    enum PDF_ENUM_NAME_FontMatrix = _Anonymous_4.PDF_ENUM_NAME_FontMatrix;
    enum PDF_ENUM_NAME_FontName = _Anonymous_4.PDF_ENUM_NAME_FontName;
    enum PDF_ENUM_NAME_ForComment = _Anonymous_4.PDF_ENUM_NAME_ForComment;
    enum PDF_ENUM_NAME_ForPublicRelease = _Anonymous_4.PDF_ENUM_NAME_ForPublicRelease;
    enum PDF_ENUM_NAME_Form = _Anonymous_4.PDF_ENUM_NAME_Form;
    enum PDF_ENUM_NAME_FormEx = _Anonymous_4.PDF_ENUM_NAME_FormEx;
    enum PDF_ENUM_NAME_FormType = _Anonymous_4.PDF_ENUM_NAME_FormType;
    enum PDF_ENUM_NAME_FreeText = _Anonymous_4.PDF_ENUM_NAME_FreeText;
    enum PDF_ENUM_NAME_Function = _Anonymous_4.PDF_ENUM_NAME_Function;
    enum PDF_ENUM_NAME_FunctionType = _Anonymous_4.PDF_ENUM_NAME_FunctionType;
    enum PDF_ENUM_NAME_Functions = _Anonymous_4.PDF_ENUM_NAME_Functions;
    enum PDF_ENUM_NAME_G = _Anonymous_4.PDF_ENUM_NAME_G;
    enum PDF_ENUM_NAME_GTS_PDFX = _Anonymous_4.PDF_ENUM_NAME_GTS_PDFX;
    enum PDF_ENUM_NAME_Gamma = _Anonymous_4.PDF_ENUM_NAME_Gamma;
    enum PDF_ENUM_NAME_Glitter = _Anonymous_4.PDF_ENUM_NAME_Glitter;
    enum PDF_ENUM_NAME_GoTo = _Anonymous_4.PDF_ENUM_NAME_GoTo;
    enum PDF_ENUM_NAME_GoToR = _Anonymous_4.PDF_ENUM_NAME_GoToR;
    enum PDF_ENUM_NAME_Group = _Anonymous_4.PDF_ENUM_NAME_Group;
    enum PDF_ENUM_NAME_H = _Anonymous_4.PDF_ENUM_NAME_H;
    enum PDF_ENUM_NAME_Height = _Anonymous_4.PDF_ENUM_NAME_Height;
    enum PDF_ENUM_NAME_Helv = _Anonymous_4.PDF_ENUM_NAME_Helv;
    enum PDF_ENUM_NAME_Highlight = _Anonymous_4.PDF_ENUM_NAME_Highlight;
    enum PDF_ENUM_NAME_HistoryPos = _Anonymous_4.PDF_ENUM_NAME_HistoryPos;
    enum PDF_ENUM_NAME_I = _Anonymous_4.PDF_ENUM_NAME_I;
    enum PDF_ENUM_NAME_IC = _Anonymous_4.PDF_ENUM_NAME_IC;
    enum PDF_ENUM_NAME_ICCBased = _Anonymous_4.PDF_ENUM_NAME_ICCBased;
    enum PDF_ENUM_NAME_ID = _Anonymous_4.PDF_ENUM_NAME_ID;
    enum PDF_ENUM_NAME_IM = _Anonymous_4.PDF_ENUM_NAME_IM;
    enum PDF_ENUM_NAME_IRT = _Anonymous_4.PDF_ENUM_NAME_IRT;
    enum PDF_ENUM_NAME_Identity = _Anonymous_4.PDF_ENUM_NAME_Identity;
    enum PDF_ENUM_NAME_Identity_H = _Anonymous_4.PDF_ENUM_NAME_Identity_H;
    enum PDF_ENUM_NAME_Identity_V = _Anonymous_4.PDF_ENUM_NAME_Identity_V;
    enum PDF_ENUM_NAME_Image = _Anonymous_4.PDF_ENUM_NAME_Image;
    enum PDF_ENUM_NAME_ImageMask = _Anonymous_4.PDF_ENUM_NAME_ImageMask;
    enum PDF_ENUM_NAME_Include = _Anonymous_4.PDF_ENUM_NAME_Include;
    enum PDF_ENUM_NAME_Index = _Anonymous_4.PDF_ENUM_NAME_Index;
    enum PDF_ENUM_NAME_Indexed = _Anonymous_4.PDF_ENUM_NAME_Indexed;
    enum PDF_ENUM_NAME_Info = _Anonymous_4.PDF_ENUM_NAME_Info;
    enum PDF_ENUM_NAME_Ink = _Anonymous_4.PDF_ENUM_NAME_Ink;
    enum PDF_ENUM_NAME_InkList = _Anonymous_4.PDF_ENUM_NAME_InkList;
    enum PDF_ENUM_NAME_Intent = _Anonymous_4.PDF_ENUM_NAME_Intent;
    enum PDF_ENUM_NAME_Interpolate = _Anonymous_4.PDF_ENUM_NAME_Interpolate;
    enum PDF_ENUM_NAME_IsMap = _Anonymous_4.PDF_ENUM_NAME_IsMap;
    enum PDF_ENUM_NAME_ItalicAngle = _Anonymous_4.PDF_ENUM_NAME_ItalicAngle;
    enum PDF_ENUM_NAME_JBIG2Decode = _Anonymous_4.PDF_ENUM_NAME_JBIG2Decode;
    enum PDF_ENUM_NAME_JBIG2Globals = _Anonymous_4.PDF_ENUM_NAME_JBIG2Globals;
    enum PDF_ENUM_NAME_JPXDecode = _Anonymous_4.PDF_ENUM_NAME_JPXDecode;
    enum PDF_ENUM_NAME_JS = _Anonymous_4.PDF_ENUM_NAME_JS;
    enum PDF_ENUM_NAME_JavaScript = _Anonymous_4.PDF_ENUM_NAME_JavaScript;
    enum PDF_ENUM_NAME_K = _Anonymous_4.PDF_ENUM_NAME_K;
    enum PDF_ENUM_NAME_Keywords = _Anonymous_4.PDF_ENUM_NAME_Keywords;
    enum PDF_ENUM_NAME_Kids = _Anonymous_4.PDF_ENUM_NAME_Kids;
    enum PDF_ENUM_NAME_L = _Anonymous_4.PDF_ENUM_NAME_L;
    enum PDF_ENUM_NAME_LC = _Anonymous_4.PDF_ENUM_NAME_LC;
    enum PDF_ENUM_NAME_LE = _Anonymous_4.PDF_ENUM_NAME_LE;
    enum PDF_ENUM_NAME_LJ = _Anonymous_4.PDF_ENUM_NAME_LJ;
    enum PDF_ENUM_NAME_LW = _Anonymous_4.PDF_ENUM_NAME_LW;
    enum PDF_ENUM_NAME_LZ = _Anonymous_4.PDF_ENUM_NAME_LZ;
    enum PDF_ENUM_NAME_LZW = _Anonymous_4.PDF_ENUM_NAME_LZW;
    enum PDF_ENUM_NAME_LZWDecode = _Anonymous_4.PDF_ENUM_NAME_LZWDecode;
    enum PDF_ENUM_NAME_Lab = _Anonymous_4.PDF_ENUM_NAME_Lab;
    enum PDF_ENUM_NAME_Lang = _Anonymous_4.PDF_ENUM_NAME_Lang;
    enum PDF_ENUM_NAME_Last = _Anonymous_4.PDF_ENUM_NAME_Last;
    enum PDF_ENUM_NAME_LastChar = _Anonymous_4.PDF_ENUM_NAME_LastChar;
    enum PDF_ENUM_NAME_LastPage = _Anonymous_4.PDF_ENUM_NAME_LastPage;
    enum PDF_ENUM_NAME_Launch = _Anonymous_4.PDF_ENUM_NAME_Launch;
    enum PDF_ENUM_NAME_Length = _Anonymous_4.PDF_ENUM_NAME_Length;
    enum PDF_ENUM_NAME_Length1 = _Anonymous_4.PDF_ENUM_NAME_Length1;
    enum PDF_ENUM_NAME_Length2 = _Anonymous_4.PDF_ENUM_NAME_Length2;
    enum PDF_ENUM_NAME_Length3 = _Anonymous_4.PDF_ENUM_NAME_Length3;
    enum PDF_ENUM_NAME_Limits = _Anonymous_4.PDF_ENUM_NAME_Limits;
    enum PDF_ENUM_NAME_Line = _Anonymous_4.PDF_ENUM_NAME_Line;
    enum PDF_ENUM_NAME_Linearized = _Anonymous_4.PDF_ENUM_NAME_Linearized;
    enum PDF_ENUM_NAME_Link = _Anonymous_4.PDF_ENUM_NAME_Link;
    enum PDF_ENUM_NAME_Location = _Anonymous_4.PDF_ENUM_NAME_Location;
    enum PDF_ENUM_NAME_Lock = _Anonymous_4.PDF_ENUM_NAME_Lock;
    enum PDF_ENUM_NAME_Locked = _Anonymous_4.PDF_ENUM_NAME_Locked;
    enum PDF_ENUM_NAME_Luminosity = _Anonymous_4.PDF_ENUM_NAME_Luminosity;
    enum PDF_ENUM_NAME_M = _Anonymous_4.PDF_ENUM_NAME_M;
    enum PDF_ENUM_NAME_MCID = _Anonymous_4.PDF_ENUM_NAME_MCID;
    enum PDF_ENUM_NAME_MK = _Anonymous_4.PDF_ENUM_NAME_MK;
    enum PDF_ENUM_NAME_ML = _Anonymous_4.PDF_ENUM_NAME_ML;
    enum PDF_ENUM_NAME_MMType1 = _Anonymous_4.PDF_ENUM_NAME_MMType1;
    enum PDF_ENUM_NAME_Mac = _Anonymous_4.PDF_ENUM_NAME_Mac;
    enum PDF_ENUM_NAME_Mask = _Anonymous_4.PDF_ENUM_NAME_Mask;
    enum PDF_ENUM_NAME_Matrix = _Anonymous_4.PDF_ENUM_NAME_Matrix;
    enum PDF_ENUM_NAME_Matte = _Anonymous_4.PDF_ENUM_NAME_Matte;
    enum PDF_ENUM_NAME_MaxLen = _Anonymous_4.PDF_ENUM_NAME_MaxLen;
    enum PDF_ENUM_NAME_MediaBox = _Anonymous_4.PDF_ENUM_NAME_MediaBox;
    enum PDF_ENUM_NAME_Metadata = _Anonymous_4.PDF_ENUM_NAME_Metadata;
    enum PDF_ENUM_NAME_MissingWidth = _Anonymous_4.PDF_ENUM_NAME_MissingWidth;
    enum PDF_ENUM_NAME_ModDate = _Anonymous_4.PDF_ENUM_NAME_ModDate;
    enum PDF_ENUM_NAME_Movie = _Anonymous_4.PDF_ENUM_NAME_Movie;
    enum PDF_ENUM_NAME_Msg = _Anonymous_4.PDF_ENUM_NAME_Msg;
    enum PDF_ENUM_NAME_Multiply = _Anonymous_4.PDF_ENUM_NAME_Multiply;
    enum PDF_ENUM_NAME_N = _Anonymous_4.PDF_ENUM_NAME_N;
    enum PDF_ENUM_NAME_Name = _Anonymous_4.PDF_ENUM_NAME_Name;
    enum PDF_ENUM_NAME_Named = _Anonymous_4.PDF_ENUM_NAME_Named;
    enum PDF_ENUM_NAME_Names = _Anonymous_4.PDF_ENUM_NAME_Names;
    enum PDF_ENUM_NAME_NewWindow = _Anonymous_4.PDF_ENUM_NAME_NewWindow;
    enum PDF_ENUM_NAME_Next = _Anonymous_4.PDF_ENUM_NAME_Next;
    enum PDF_ENUM_NAME_NextPage = _Anonymous_4.PDF_ENUM_NAME_NextPage;
    enum PDF_ENUM_NAME_NonEFontNoWarn = _Anonymous_4.PDF_ENUM_NAME_NonEFontNoWarn;
    enum PDF_ENUM_NAME_None = _Anonymous_4.PDF_ENUM_NAME_None;
    enum PDF_ENUM_NAME_Normal = _Anonymous_4.PDF_ENUM_NAME_Normal;
    enum PDF_ENUM_NAME_NotApproved = _Anonymous_4.PDF_ENUM_NAME_NotApproved;
    enum PDF_ENUM_NAME_NotForPublicRelease = _Anonymous_4.PDF_ENUM_NAME_NotForPublicRelease;
    enum PDF_ENUM_NAME_NumSections = _Anonymous_4.PDF_ENUM_NAME_NumSections;
    enum PDF_ENUM_NAME_Nums = _Anonymous_4.PDF_ENUM_NAME_Nums;
    enum PDF_ENUM_NAME_O = _Anonymous_4.PDF_ENUM_NAME_O;
    enum PDF_ENUM_NAME_OC = _Anonymous_4.PDF_ENUM_NAME_OC;
    enum PDF_ENUM_NAME_OCG = _Anonymous_4.PDF_ENUM_NAME_OCG;
    enum PDF_ENUM_NAME_OCGs = _Anonymous_4.PDF_ENUM_NAME_OCGs;
    enum PDF_ENUM_NAME_OCMD = _Anonymous_4.PDF_ENUM_NAME_OCMD;
    enum PDF_ENUM_NAME_OCProperties = _Anonymous_4.PDF_ENUM_NAME_OCProperties;
    enum PDF_ENUM_NAME_OE = _Anonymous_4.PDF_ENUM_NAME_OE;
    enum PDF_ENUM_NAME_OFF = _Anonymous_4.PDF_ENUM_NAME_OFF;
    enum PDF_ENUM_NAME_ON = _Anonymous_4.PDF_ENUM_NAME_ON;
    enum PDF_ENUM_NAME_OP = _Anonymous_4.PDF_ENUM_NAME_OP;
    enum PDF_ENUM_NAME_OPM = _Anonymous_4.PDF_ENUM_NAME_OPM;
    enum PDF_ENUM_NAME_OS = _Anonymous_4.PDF_ENUM_NAME_OS;
    enum PDF_ENUM_NAME_ObjStm = _Anonymous_4.PDF_ENUM_NAME_ObjStm;
    enum PDF_ENUM_NAME_Of = _Anonymous_4.PDF_ENUM_NAME_Of;
    enum PDF_ENUM_NAME_Off = _Anonymous_4.PDF_ENUM_NAME_Off;
    enum PDF_ENUM_NAME_Open = _Anonymous_4.PDF_ENUM_NAME_Open;
    enum PDF_ENUM_NAME_OpenArrow = _Anonymous_4.PDF_ENUM_NAME_OpenArrow;
    enum PDF_ENUM_NAME_OpenType = _Anonymous_4.PDF_ENUM_NAME_OpenType;
    enum PDF_ENUM_NAME_Opt = _Anonymous_4.PDF_ENUM_NAME_Opt;
    enum PDF_ENUM_NAME_Order = _Anonymous_4.PDF_ENUM_NAME_Order;
    enum PDF_ENUM_NAME_Ordering = _Anonymous_4.PDF_ENUM_NAME_Ordering;
    enum PDF_ENUM_NAME_Outlines = _Anonymous_4.PDF_ENUM_NAME_Outlines;
    enum PDF_ENUM_NAME_OutputCondition = _Anonymous_4.PDF_ENUM_NAME_OutputCondition;
    enum PDF_ENUM_NAME_OutputConditionIdentifier = _Anonymous_4.PDF_ENUM_NAME_OutputConditionIdentifier;
    enum PDF_ENUM_NAME_OutputIntent = _Anonymous_4.PDF_ENUM_NAME_OutputIntent;
    enum PDF_ENUM_NAME_OutputIntents = _Anonymous_4.PDF_ENUM_NAME_OutputIntents;
    enum PDF_ENUM_NAME_P = _Anonymous_4.PDF_ENUM_NAME_P;
    enum PDF_ENUM_NAME_PDF = _Anonymous_4.PDF_ENUM_NAME_PDF;
    enum PDF_ENUM_NAME_PS = _Anonymous_4.PDF_ENUM_NAME_PS;
    enum PDF_ENUM_NAME_Page = _Anonymous_4.PDF_ENUM_NAME_Page;
    enum PDF_ENUM_NAME_PageMode = _Anonymous_4.PDF_ENUM_NAME_PageMode;
    enum PDF_ENUM_NAME_Pages = _Anonymous_4.PDF_ENUM_NAME_Pages;
    enum PDF_ENUM_NAME_PaintType = _Anonymous_4.PDF_ENUM_NAME_PaintType;
    enum PDF_ENUM_NAME_Params = _Anonymous_4.PDF_ENUM_NAME_Params;
    enum PDF_ENUM_NAME_Parent = _Anonymous_4.PDF_ENUM_NAME_Parent;
    enum PDF_ENUM_NAME_Pattern = _Anonymous_4.PDF_ENUM_NAME_Pattern;
    enum PDF_ENUM_NAME_PatternType = _Anonymous_4.PDF_ENUM_NAME_PatternType;
    enum PDF_ENUM_NAME_Perms = _Anonymous_4.PDF_ENUM_NAME_Perms;
    enum PDF_ENUM_NAME_PolyLine = _Anonymous_4.PDF_ENUM_NAME_PolyLine;
    enum PDF_ENUM_NAME_Polygon = _Anonymous_4.PDF_ENUM_NAME_Polygon;
    enum PDF_ENUM_NAME_Popup = _Anonymous_4.PDF_ENUM_NAME_Popup;
    enum PDF_ENUM_NAME_PreRelease = _Anonymous_4.PDF_ENUM_NAME_PreRelease;
    enum PDF_ENUM_NAME_Predictor = _Anonymous_4.PDF_ENUM_NAME_Predictor;
    enum PDF_ENUM_NAME_Prev = _Anonymous_4.PDF_ENUM_NAME_Prev;
    enum PDF_ENUM_NAME_PrevPage = _Anonymous_4.PDF_ENUM_NAME_PrevPage;
    enum PDF_ENUM_NAME_Preview = _Anonymous_4.PDF_ENUM_NAME_Preview;
    enum PDF_ENUM_NAME_Print = _Anonymous_4.PDF_ENUM_NAME_Print;
    enum PDF_ENUM_NAME_PrinterMark = _Anonymous_4.PDF_ENUM_NAME_PrinterMark;
    enum PDF_ENUM_NAME_ProcSet = _Anonymous_4.PDF_ENUM_NAME_ProcSet;
    enum PDF_ENUM_NAME_Producer = _Anonymous_4.PDF_ENUM_NAME_Producer;
    enum PDF_ENUM_NAME_Properties = _Anonymous_4.PDF_ENUM_NAME_Properties;
    enum PDF_ENUM_NAME_Prop_AuthTime = _Anonymous_4.PDF_ENUM_NAME_Prop_AuthTime;
    enum PDF_ENUM_NAME_Prop_AuthType = _Anonymous_4.PDF_ENUM_NAME_Prop_AuthType;
    enum PDF_ENUM_NAME_Prop_Build = _Anonymous_4.PDF_ENUM_NAME_Prop_Build;
    enum PDF_ENUM_NAME_PubSec = _Anonymous_4.PDF_ENUM_NAME_PubSec;
    enum PDF_ENUM_NAME_Push = _Anonymous_4.PDF_ENUM_NAME_Push;
    enum PDF_ENUM_NAME_Q = _Anonymous_4.PDF_ENUM_NAME_Q;
    enum PDF_ENUM_NAME_QuadPoints = _Anonymous_4.PDF_ENUM_NAME_QuadPoints;
    enum PDF_ENUM_NAME_R = _Anonymous_4.PDF_ENUM_NAME_R;
    enum PDF_ENUM_NAME_RBGroups = _Anonymous_4.PDF_ENUM_NAME_RBGroups;
    enum PDF_ENUM_NAME_RC = _Anonymous_4.PDF_ENUM_NAME_RC;
    enum PDF_ENUM_NAME_RClosedArrow = _Anonymous_4.PDF_ENUM_NAME_RClosedArrow;
    enum PDF_ENUM_NAME_REx = _Anonymous_4.PDF_ENUM_NAME_REx;
    enum PDF_ENUM_NAME_RGB = _Anonymous_4.PDF_ENUM_NAME_RGB;
    enum PDF_ENUM_NAME_RI = _Anonymous_4.PDF_ENUM_NAME_RI;
    enum PDF_ENUM_NAME_RL = _Anonymous_4.PDF_ENUM_NAME_RL;
    enum PDF_ENUM_NAME_ROpenArrow = _Anonymous_4.PDF_ENUM_NAME_ROpenArrow;
    enum PDF_ENUM_NAME_Range = _Anonymous_4.PDF_ENUM_NAME_Range;
    enum PDF_ENUM_NAME_Reason = _Anonymous_4.PDF_ENUM_NAME_Reason;
    enum PDF_ENUM_NAME_Rect = _Anonymous_4.PDF_ENUM_NAME_Rect;
    enum PDF_ENUM_NAME_Redact = _Anonymous_4.PDF_ENUM_NAME_Redact;
    enum PDF_ENUM_NAME_Ref = _Anonymous_4.PDF_ENUM_NAME_Ref;
    enum PDF_ENUM_NAME_Reference = _Anonymous_4.PDF_ENUM_NAME_Reference;
    enum PDF_ENUM_NAME_Registry = _Anonymous_4.PDF_ENUM_NAME_Registry;
    enum PDF_ENUM_NAME_ResetForm = _Anonymous_4.PDF_ENUM_NAME_ResetForm;
    enum PDF_ENUM_NAME_Resources = _Anonymous_4.PDF_ENUM_NAME_Resources;
    enum PDF_ENUM_NAME_Root = _Anonymous_4.PDF_ENUM_NAME_Root;
    enum PDF_ENUM_NAME_Rotate = _Anonymous_4.PDF_ENUM_NAME_Rotate;
    enum PDF_ENUM_NAME_Rows = _Anonymous_4.PDF_ENUM_NAME_Rows;
    enum PDF_ENUM_NAME_RunLengthDecode = _Anonymous_4.PDF_ENUM_NAME_RunLengthDecode;
    enum PDF_ENUM_NAME_S = _Anonymous_4.PDF_ENUM_NAME_S;
    enum PDF_ENUM_NAME_SMask = _Anonymous_4.PDF_ENUM_NAME_SMask;
    enum PDF_ENUM_NAME_SMaskInData = _Anonymous_4.PDF_ENUM_NAME_SMaskInData;
    enum PDF_ENUM_NAME_Schema = _Anonymous_4.PDF_ENUM_NAME_Schema;
    enum PDF_ENUM_NAME_Screen = _Anonymous_4.PDF_ENUM_NAME_Screen;
    enum PDF_ENUM_NAME_Separation = _Anonymous_4.PDF_ENUM_NAME_Separation;
    enum PDF_ENUM_NAME_Shading = _Anonymous_4.PDF_ENUM_NAME_Shading;
    enum PDF_ENUM_NAME_ShadingType = _Anonymous_4.PDF_ENUM_NAME_ShadingType;
    enum PDF_ENUM_NAME_Si = _Anonymous_4.PDF_ENUM_NAME_Si;
    enum PDF_ENUM_NAME_Sig = _Anonymous_4.PDF_ENUM_NAME_Sig;
    enum PDF_ENUM_NAME_SigFlags = _Anonymous_4.PDF_ENUM_NAME_SigFlags;
    enum PDF_ENUM_NAME_SigQ = _Anonymous_4.PDF_ENUM_NAME_SigQ;
    enum PDF_ENUM_NAME_SigRef = _Anonymous_4.PDF_ENUM_NAME_SigRef;
    enum PDF_ENUM_NAME_Size = _Anonymous_4.PDF_ENUM_NAME_Size;
    enum PDF_ENUM_NAME_Slash = _Anonymous_4.PDF_ENUM_NAME_Slash;
    enum PDF_ENUM_NAME_Sold = _Anonymous_4.PDF_ENUM_NAME_Sold;
    enum PDF_ENUM_NAME_Sound = _Anonymous_4.PDF_ENUM_NAME_Sound;
    enum PDF_ENUM_NAME_Split = _Anonymous_4.PDF_ENUM_NAME_Split;
    enum PDF_ENUM_NAME_Square = _Anonymous_4.PDF_ENUM_NAME_Square;
    enum PDF_ENUM_NAME_Squiggly = _Anonymous_4.PDF_ENUM_NAME_Squiggly;
    enum PDF_ENUM_NAME_Stamp = _Anonymous_4.PDF_ENUM_NAME_Stamp;
    enum PDF_ENUM_NAME_Standard = _Anonymous_4.PDF_ENUM_NAME_Standard;
    enum PDF_ENUM_NAME_StdCF = _Anonymous_4.PDF_ENUM_NAME_StdCF;
    enum PDF_ENUM_NAME_StemV = _Anonymous_4.PDF_ENUM_NAME_StemV;
    enum PDF_ENUM_NAME_StmF = _Anonymous_4.PDF_ENUM_NAME_StmF;
    enum PDF_ENUM_NAME_StrF = _Anonymous_4.PDF_ENUM_NAME_StrF;
    enum PDF_ENUM_NAME_StrikeOut = _Anonymous_4.PDF_ENUM_NAME_StrikeOut;
    enum PDF_ENUM_NAME_StructParent = _Anonymous_4.PDF_ENUM_NAME_StructParent;
    enum PDF_ENUM_NAME_StructParents = _Anonymous_4.PDF_ENUM_NAME_StructParents;
    enum PDF_ENUM_NAME_SubFilter = _Anonymous_4.PDF_ENUM_NAME_SubFilter;
    enum PDF_ENUM_NAME_Subject = _Anonymous_4.PDF_ENUM_NAME_Subject;
    enum PDF_ENUM_NAME_Subtype = _Anonymous_4.PDF_ENUM_NAME_Subtype;
    enum PDF_ENUM_NAME_Subtype2 = _Anonymous_4.PDF_ENUM_NAME_Subtype2;
    enum PDF_ENUM_NAME_Supplement = _Anonymous_4.PDF_ENUM_NAME_Supplement;
    enum PDF_ENUM_NAME_Symb = _Anonymous_4.PDF_ENUM_NAME_Symb;
    enum PDF_ENUM_NAME_T = _Anonymous_4.PDF_ENUM_NAME_T;
    enum PDF_ENUM_NAME_TI = _Anonymous_4.PDF_ENUM_NAME_TI;
    enum PDF_ENUM_NAME_TR = _Anonymous_4.PDF_ENUM_NAME_TR;
    enum PDF_ENUM_NAME_TR2 = _Anonymous_4.PDF_ENUM_NAME_TR2;
    enum PDF_ENUM_NAME_TU = _Anonymous_4.PDF_ENUM_NAME_TU;
    enum PDF_ENUM_NAME_Text = _Anonymous_4.PDF_ENUM_NAME_Text;
    enum PDF_ENUM_NAME_TilingType = _Anonymous_4.PDF_ENUM_NAME_TilingType;
    enum PDF_ENUM_NAME_Times = _Anonymous_4.PDF_ENUM_NAME_Times;
    enum PDF_ENUM_NAME_Title = _Anonymous_4.PDF_ENUM_NAME_Title;
    enum PDF_ENUM_NAME_ToUnicode = _Anonymous_4.PDF_ENUM_NAME_ToUnicode;
    enum PDF_ENUM_NAME_TopSecret = _Anonymous_4.PDF_ENUM_NAME_TopSecret;
    enum PDF_ENUM_NAME_Trans = _Anonymous_4.PDF_ENUM_NAME_Trans;
    enum PDF_ENUM_NAME_TransformMethod = _Anonymous_4.PDF_ENUM_NAME_TransformMethod;
    enum PDF_ENUM_NAME_TransformParams = _Anonymous_4.PDF_ENUM_NAME_TransformParams;
    enum PDF_ENUM_NAME_Transparency = _Anonymous_4.PDF_ENUM_NAME_Transparency;
    enum PDF_ENUM_NAME_TrapNet = _Anonymous_4.PDF_ENUM_NAME_TrapNet;
    enum PDF_ENUM_NAME_TrimBox = _Anonymous_4.PDF_ENUM_NAME_TrimBox;
    enum PDF_ENUM_NAME_TrueType = _Anonymous_4.PDF_ENUM_NAME_TrueType;
    enum PDF_ENUM_NAME_TrustedMode = _Anonymous_4.PDF_ENUM_NAME_TrustedMode;
    enum PDF_ENUM_NAME_Tx = _Anonymous_4.PDF_ENUM_NAME_Tx;
    enum PDF_ENUM_NAME_Type = _Anonymous_4.PDF_ENUM_NAME_Type;
    enum PDF_ENUM_NAME_Type0 = _Anonymous_4.PDF_ENUM_NAME_Type0;
    enum PDF_ENUM_NAME_Type1 = _Anonymous_4.PDF_ENUM_NAME_Type1;
    enum PDF_ENUM_NAME_Type1C = _Anonymous_4.PDF_ENUM_NAME_Type1C;
    enum PDF_ENUM_NAME_Type3 = _Anonymous_4.PDF_ENUM_NAME_Type3;
    enum PDF_ENUM_NAME_U = _Anonymous_4.PDF_ENUM_NAME_U;
    enum PDF_ENUM_NAME_UE = _Anonymous_4.PDF_ENUM_NAME_UE;
    enum PDF_ENUM_NAME_UF = _Anonymous_4.PDF_ENUM_NAME_UF;
    enum PDF_ENUM_NAME_URI = _Anonymous_4.PDF_ENUM_NAME_URI;
    enum PDF_ENUM_NAME_URL = _Anonymous_4.PDF_ENUM_NAME_URL;
    enum PDF_ENUM_NAME_Unchanged = _Anonymous_4.PDF_ENUM_NAME_Unchanged;
    enum PDF_ENUM_NAME_Uncover = _Anonymous_4.PDF_ENUM_NAME_Uncover;
    enum PDF_ENUM_NAME_Underline = _Anonymous_4.PDF_ENUM_NAME_Underline;
    enum PDF_ENUM_NAME_Unix = _Anonymous_4.PDF_ENUM_NAME_Unix;
    enum PDF_ENUM_NAME_Usage = _Anonymous_4.PDF_ENUM_NAME_Usage;
    enum PDF_ENUM_NAME_UseBlackPtComp = _Anonymous_4.PDF_ENUM_NAME_UseBlackPtComp;
    enum PDF_ENUM_NAME_UseCMap = _Anonymous_4.PDF_ENUM_NAME_UseCMap;
    enum PDF_ENUM_NAME_UseOutlines = _Anonymous_4.PDF_ENUM_NAME_UseOutlines;
    enum PDF_ENUM_NAME_UserUnit = _Anonymous_4.PDF_ENUM_NAME_UserUnit;
    enum PDF_ENUM_NAME_V = _Anonymous_4.PDF_ENUM_NAME_V;
    enum PDF_ENUM_NAME_V2 = _Anonymous_4.PDF_ENUM_NAME_V2;
    enum PDF_ENUM_NAME_VE = _Anonymous_4.PDF_ENUM_NAME_VE;
    enum PDF_ENUM_NAME_Version = _Anonymous_4.PDF_ENUM_NAME_Version;
    enum PDF_ENUM_NAME_Vertices = _Anonymous_4.PDF_ENUM_NAME_Vertices;
    enum PDF_ENUM_NAME_VerticesPerRow = _Anonymous_4.PDF_ENUM_NAME_VerticesPerRow;
    enum PDF_ENUM_NAME_View = _Anonymous_4.PDF_ENUM_NAME_View;
    enum PDF_ENUM_NAME_W = _Anonymous_4.PDF_ENUM_NAME_W;
    enum PDF_ENUM_NAME_W2 = _Anonymous_4.PDF_ENUM_NAME_W2;
    enum PDF_ENUM_NAME_WMode = _Anonymous_4.PDF_ENUM_NAME_WMode;
    enum PDF_ENUM_NAME_Watermark = _Anonymous_4.PDF_ENUM_NAME_Watermark;
    enum PDF_ENUM_NAME_WhitePoint = _Anonymous_4.PDF_ENUM_NAME_WhitePoint;
    enum PDF_ENUM_NAME_Widget = _Anonymous_4.PDF_ENUM_NAME_Widget;
    enum PDF_ENUM_NAME_Width = _Anonymous_4.PDF_ENUM_NAME_Width;
    enum PDF_ENUM_NAME_Widths = _Anonymous_4.PDF_ENUM_NAME_Widths;
    enum PDF_ENUM_NAME_WinAnsiEncoding = _Anonymous_4.PDF_ENUM_NAME_WinAnsiEncoding;
    enum PDF_ENUM_NAME_Wipe = _Anonymous_4.PDF_ENUM_NAME_Wipe;
    enum PDF_ENUM_NAME_XFA = _Anonymous_4.PDF_ENUM_NAME_XFA;
    enum PDF_ENUM_NAME_XHeight = _Anonymous_4.PDF_ENUM_NAME_XHeight;
    enum PDF_ENUM_NAME_XML = _Anonymous_4.PDF_ENUM_NAME_XML;
    enum PDF_ENUM_NAME_XObject = _Anonymous_4.PDF_ENUM_NAME_XObject;
    enum PDF_ENUM_NAME_XRef = _Anonymous_4.PDF_ENUM_NAME_XRef;
    enum PDF_ENUM_NAME_XRefStm = _Anonymous_4.PDF_ENUM_NAME_XRefStm;
    enum PDF_ENUM_NAME_XStep = _Anonymous_4.PDF_ENUM_NAME_XStep;
    enum PDF_ENUM_NAME_XYZ = _Anonymous_4.PDF_ENUM_NAME_XYZ;
    enum PDF_ENUM_NAME_YStep = _Anonymous_4.PDF_ENUM_NAME_YStep;
    enum PDF_ENUM_NAME_Yes = _Anonymous_4.PDF_ENUM_NAME_Yes;
    enum PDF_ENUM_NAME_ZaDb = _Anonymous_4.PDF_ENUM_NAME_ZaDb;
    enum PDF_ENUM_NAME_adbe_pkcs7_detached = _Anonymous_4.PDF_ENUM_NAME_adbe_pkcs7_detached;
    enum PDF_ENUM_NAME_ca = _Anonymous_4.PDF_ENUM_NAME_ca;
    enum PDF_ENUM_NAME_n0 = _Anonymous_4.PDF_ENUM_NAME_n0;
    enum PDF_ENUM_NAME_n1 = _Anonymous_4.PDF_ENUM_NAME_n1;
    enum PDF_ENUM_NAME_n2 = _Anonymous_4.PDF_ENUM_NAME_n2;
    enum PDF_ENUM_NAME_op = _Anonymous_4.PDF_ENUM_NAME_op;
    enum PDF_ENUM_LIMIT = _Anonymous_4.PDF_ENUM_LIMIT;

    void pdf_set_int(fz_context*, pdf_obj*, long) @nogc nothrow;

    pdf_document* pdf_get_bound_document(fz_context*, pdf_obj*) @nogc nothrow;

    pdf_document* pdf_get_indirect_document(fz_context*, pdf_obj*) @nogc nothrow;

    long pdf_to_date(fz_context*, pdf_obj*) @nogc nothrow;

    fz_matrix pdf_to_matrix(fz_context*, pdf_obj*) @nogc nothrow;

    fz_rect pdf_to_rect(fz_context*, pdf_obj*) @nogc nothrow;

    fz_quad pdf_to_quad(fz_context*, pdf_obj*, int) @nogc nothrow;

    char* pdf_load_stream_or_string_as_utf8(fz_context*, pdf_obj*) @nogc nothrow;

    char* pdf_new_utf8_from_pdf_stream_obj(fz_context*, pdf_obj*) @nogc nothrow;

    char* pdf_new_utf8_from_pdf_string_obj(fz_context*, pdf_obj*) @nogc nothrow;

    char* pdf_new_utf8_from_pdf_string(fz_context*, const(char)*, ulong) @nogc nothrow;

    void pdf_debug_ref(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_debug_obj(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_print_encrypted_obj(fz_context*, fz_output*, pdf_obj*, int, int, pdf_crypt*, int, int) @nogc nothrow;

    void pdf_print_obj(fz_context*, fz_output*, pdf_obj*, int, int) @nogc nothrow;

    char* pdf_sprint_obj(fz_context*, char*, ulong, ulong*, pdf_obj*, int, int) @nogc nothrow;

    int pdf_obj_parent_num(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_obj_refs(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_set_obj_parent(fz_context*, pdf_obj*, int) @nogc nothrow;

    fz_matrix pdf_array_get_matrix(fz_context*, pdf_obj*, int) @nogc nothrow;

    fz_rect pdf_array_get_rect(fz_context*, pdf_obj*, int) @nogc nothrow;

    const(char)* pdf_array_get_text_string(fz_context*, pdf_obj*, int) @nogc nothrow;

    const(char)* pdf_array_get_string(fz_context*, pdf_obj*, int, ulong*) @nogc nothrow;

    const(char)* pdf_array_get_name(fz_context*, pdf_obj*, int) @nogc nothrow;

    float pdf_array_get_real(fz_context*, pdf_obj*, int) @nogc nothrow;

    int pdf_array_get_int(fz_context*, pdf_obj*, int) @nogc nothrow;

    int pdf_array_get_bool(fz_context*, pdf_obj*, int) @nogc nothrow;

    pdf_obj* pdf_array_push_dict(fz_context*, pdf_obj*, int) @nogc nothrow;

    pdf_obj* pdf_array_push_array(fz_context*, pdf_obj*, int) @nogc nothrow;

    void pdf_array_push_text_string(fz_context*, pdf_obj*, const(char)*) @nogc nothrow;

    void pdf_array_push_string(fz_context*, pdf_obj*, const(char)*, ulong) @nogc nothrow;

    void pdf_array_push_name(fz_context*, pdf_obj*, const(char)*) @nogc nothrow;

    void pdf_array_push_real(fz_context*, pdf_obj*, double) @nogc nothrow;

    void pdf_array_push_int(fz_context*, pdf_obj*, long) @nogc nothrow;

    void pdf_array_push_bool(fz_context*, pdf_obj*, int) @nogc nothrow;

    long pdf_dict_get_date(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    fz_matrix pdf_dict_get_matrix(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    fz_rect pdf_dict_get_rect(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    const(char)* pdf_dict_get_text_string(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    const(char)* pdf_dict_get_string(fz_context*, pdf_obj*, pdf_obj*, ulong*) @nogc nothrow;

    const(char)* pdf_dict_get_name(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    float pdf_dict_get_real(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    int pdf_dict_get_int(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    int pdf_dict_get_bool(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_dict_puts_dict(fz_context*, pdf_obj*, const(char)*, int) @nogc nothrow;

    pdf_obj* pdf_dict_put_dict(fz_context*, pdf_obj*, pdf_obj*, int) @nogc nothrow;

    pdf_obj* pdf_dict_put_array(fz_context*, pdf_obj*, pdf_obj*, int) @nogc nothrow;

    void pdf_dict_put_date(fz_context*, pdf_obj*, pdf_obj*, long) @nogc nothrow;

    void pdf_dict_put_matrix(fz_context*, pdf_obj*, pdf_obj*, fz_matrix) @nogc nothrow;

    void pdf_dict_put_rect(fz_context*, pdf_obj*, pdf_obj*, fz_rect) @nogc nothrow;

    void pdf_dict_put_text_string(fz_context*, pdf_obj*, pdf_obj*, const(char)*) @nogc nothrow;

    void pdf_dict_put_string(fz_context*, pdf_obj*, pdf_obj*, const(char)*, ulong) @nogc nothrow;

    void pdf_dict_put_name(fz_context*, pdf_obj*, pdf_obj*, const(char)*) @nogc nothrow;

    void pdf_dict_put_real(fz_context*, pdf_obj*, pdf_obj*, double) @nogc nothrow;

    void pdf_dict_put_int(fz_context*, pdf_obj*, pdf_obj*, long) @nogc nothrow;

    void pdf_dict_put_bool(fz_context*, pdf_obj*, pdf_obj*, int) @nogc nothrow;

    void pdf_sort_dict(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_dict_dels(fz_context*, pdf_obj*, const(char)*) @nogc nothrow;

    void pdf_dict_del(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    void pdf_dict_putl_drop(fz_context*, pdf_obj*, pdf_obj*, ...) @nogc nothrow;

    void pdf_dict_putl(fz_context*, pdf_obj*, pdf_obj*, ...) @nogc nothrow;

    void pdf_dict_putp_drop(fz_context*, pdf_obj*, const(char)*, pdf_obj*) @nogc nothrow;

    void pdf_dict_putp(fz_context*, pdf_obj*, const(char)*, pdf_obj*) @nogc nothrow;

    void pdf_dict_puts_drop(fz_context*, pdf_obj*, const(char)*, pdf_obj*) @nogc nothrow;

    void pdf_dict_puts(fz_context*, pdf_obj*, const(char)*, pdf_obj*) @nogc nothrow;

    void pdf_dict_get_put_drop(fz_context*, pdf_obj*, pdf_obj*, pdf_obj*, pdf_obj**) @nogc nothrow;

    void pdf_dict_put_drop(fz_context*, pdf_obj*, pdf_obj*, pdf_obj*) @nogc nothrow;

    void pdf_dict_put(fz_context*, pdf_obj*, pdf_obj*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_dict_getp_inheritable(fz_context*, pdf_obj*, const(char)*) @nogc nothrow;

    pdf_obj* pdf_dict_get_inheritable(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_dict_getsa(fz_context*, pdf_obj*, const(char)*, const(char)*) @nogc nothrow;

    pdf_obj* pdf_dict_gets(fz_context*, pdf_obj*, const(char)*) @nogc nothrow;

    pdf_obj* pdf_dict_geta(fz_context*, pdf_obj*, pdf_obj*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_dict_getl(fz_context*, pdf_obj*, ...) @nogc nothrow;

    pdf_obj* pdf_dict_getp(fz_context*, pdf_obj*, const(char)*) @nogc nothrow;

    pdf_obj* pdf_dict_get(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    void pdf_dict_put_val_null(fz_context*, pdf_obj*, int) @nogc nothrow;

    pdf_obj* pdf_dict_get_val(fz_context*, pdf_obj*, int) @nogc nothrow;

    pdf_obj* pdf_dict_get_key(fz_context*, pdf_obj*, int) @nogc nothrow;

    int pdf_dict_len(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_array_contains(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    int pdf_array_find(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    void pdf_array_delete(fz_context*, pdf_obj*, int) @nogc nothrow;

    void pdf_array_insert_drop(fz_context*, pdf_obj*, pdf_obj*, int) @nogc nothrow;

    void pdf_array_insert(fz_context*, pdf_obj*, pdf_obj*, int) @nogc nothrow;

    void pdf_array_push_drop(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    void pdf_array_push(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    void pdf_array_put_drop(fz_context*, pdf_obj*, int, pdf_obj*) @nogc nothrow;

    void pdf_array_put(fz_context*, pdf_obj*, int, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_array_get(fz_context*, pdf_obj*, int) @nogc nothrow;

    int pdf_array_len(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_to_gen(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_to_num(fz_context*, pdf_obj*) @nogc nothrow;

    ulong pdf_to_str_len(fz_context*, pdf_obj*) @nogc nothrow;

    char* pdf_to_str_buf(fz_context*, pdf_obj*) @nogc nothrow;

    const(char)* pdf_to_string(fz_context*, pdf_obj*, ulong*) @nogc nothrow;

    const(char)* pdf_to_text_string(fz_context*, pdf_obj*) @nogc nothrow;

    const(char)* pdf_to_name(fz_context*, pdf_obj*) @nogc nothrow;

    float pdf_to_real(fz_context*, pdf_obj*) @nogc nothrow;

    long pdf_to_int64(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_to_int(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_to_bool(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_clean_obj(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_dirty_obj(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_obj_is_dirty(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_obj_memo(fz_context*, pdf_obj*, int, int*) @nogc nothrow;

    void pdf_set_obj_memo(fz_context*, pdf_obj*, int, int) @nogc nothrow;

    void pdf_mark_list_free(fz_context*, pdf_mark_list*) @nogc nothrow;

    void pdf_mark_list_init(fz_context*, pdf_mark_list*) @nogc nothrow;

    void pdf_mark_list_pop(fz_context*, pdf_mark_list*) @nogc nothrow;

    int pdf_mark_list_push(fz_context*, pdf_mark_list*, pdf_obj*) @nogc nothrow;

    struct pdf_mark_list
    {

        int len;

        int max;

        int* list;

        int[8] local_list;
    }

    int pdf_mark_bits_set(fz_context*, pdf_mark_bits*, pdf_obj*) @nogc nothrow;

    void pdf_mark_bits_reset(fz_context*, pdf_mark_bits*) @nogc nothrow;

    void pdf_drop_mark_bits(fz_context*, pdf_mark_bits*) @nogc nothrow;

    pdf_mark_bits* pdf_new_mark_bits(fz_context*, pdf_document*) @nogc nothrow;

    struct pdf_mark_bits
    {

        int len;

        ubyte[1] bits;
    }

    int pdf_cycle(fz_context*, pdf_cycle_list*, pdf_cycle_list*, pdf_obj*) @nogc nothrow;

    struct pdf_cycle_list
    {

        pdf_cycle_list* up;

        int num;
    }

    void pdf_unmark_obj(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_mark_obj(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_obj_marked(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_name_eq(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    int pdf_objcmp_deep(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    int pdf_objcmp_resolve(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    int pdf_objcmp(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    int pdf_is_stream(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_obj_num_is_stream(fz_context*, pdf_document*, int) @nogc nothrow;

    int pdf_is_indirect(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_is_dict(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_is_array(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_is_string(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_is_name(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_is_number(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_is_real(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_is_int(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_is_bool(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_is_null(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_drop_obj(fz_context*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_keep_obj(fz_context*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_deep_copy_obj(fz_context*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_copy_dict(fz_context*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_copy_array(fz_context*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_new_date(fz_context*, pdf_document*, long) @nogc nothrow;

    pdf_obj* pdf_new_matrix(fz_context*, pdf_document*, fz_matrix) @nogc nothrow;

    pdf_obj* pdf_new_rect(fz_context*, pdf_document*, fz_rect) @nogc nothrow;

    pdf_obj* pdf_new_dict(fz_context*, pdf_document*, int) @nogc nothrow;

    pdf_obj* pdf_new_array(fz_context*, pdf_document*, int) @nogc nothrow;

    pdf_obj* pdf_new_indirect(fz_context*, pdf_document*, int, int) @nogc nothrow;

    pdf_obj* pdf_new_text_string(fz_context*, const(char)*) @nogc nothrow;

    pdf_obj* pdf_new_string(fz_context*, const(char)*, ulong) @nogc nothrow;

    pdf_obj* pdf_new_name(fz_context*, const(char)*) @nogc nothrow;

    pdf_obj* pdf_new_real(fz_context*, float) @nogc nothrow;

    pdf_obj* pdf_new_int(fz_context*, long) @nogc nothrow;
    struct pdf_obj;
    struct pdf_journal;
    struct pdf_crypt;

    struct pdf_document
    {

        fz_document super_;

        fz_stream* file;

        int version_;

        long startxref;

        long file_size;

        pdf_crypt* crypt;

        pdf_ocg_descriptor* ocg;

        fz_colorspace* oi;

        int max_xref_len;

        int num_xref_sections;

        int saved_num_xref_sections;

        int num_incremental_sections;

        int xref_base;

        int disallow_new_increments;

        pdf_xref* local_xref;

        int local_xref_nesting;

        pdf_xref* xref_sections;

        pdf_xref* saved_xref_sections;

        int* xref_index;

        int save_in_progress;

        int has_xref_streams;

        int has_old_style_xrefs;

        int has_linearization_object;

        int page_map_nesting;

        int map_page_count;

        pdf_rev_page_map* rev_page_map;

        int* fwd_page_map;

        int repair_attempted;

        int repair_in_progress;

        int file_reading_linearly;

        long file_length;

        int linear_page_count;

        pdf_obj* linear_obj;

        pdf_obj** linear_page_refs;

        int linear_page1_obj_num;

        long linear_pos;

        int linear_page_num;

        int hint_object_offset;

        int hint_object_length;

        int hints_loaded;

        pdf_hint_page* hint_page;

        int* hint_shared_ref;

        pdf_hint_shared* hint_shared;

        int hint_obj_offsets_max;

        long* hint_obj_offsets;

        int resources_localised;

        pdf_lexbuf_large lexbuf;

        pdf_js* js;

        int recalculate;

        int redacted;

        int resynth_required;

        void function(fz_context*, pdf_document*, pdf_doc_event*, void*) event_cb;

        void function(fz_context*, void*) free_event_data_cb;

        void* event_cb_data;

        int num_type3_fonts;

        int max_type3_fonts;

        fz_font** type3_fonts;

        int type3_lock;

        static struct _Anonymous_5
        {

            fz_hash_table* fonts;
        }

        _Anonymous_5 resources;

        int orphans_max;

        int orphans_count;

        pdf_obj** orphans;

        fz_xml* xfa;

        pdf_journal* journal;
    }

    void pdf_js_execute(pdf_js*, const(char)*, const(char)*, char**) @nogc nothrow;

    int pdf_js_event_result_keystroke(pdf_js*, pdf_keystroke_event*) @nogc nothrow;

    void pdf_js_event_init_keystroke(pdf_js*, pdf_obj*, pdf_keystroke_event*) @nogc nothrow;

    char* pdf_js_event_value(pdf_js*) @nogc nothrow;

    int pdf_js_event_result_validate(pdf_js*, char**) @nogc nothrow;

    int pdf_js_event_result(pdf_js*) @nogc nothrow;

    void pdf_js_event_init(pdf_js*, pdf_obj*, const(char)*, int) @nogc nothrow;

    void pdf_drop_js(fz_context*, pdf_js*) @nogc nothrow;

    int pdf_js_supported(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_disable_js(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_enable_js(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_tos_newline(pdf_text_object_state*, float) @nogc nothrow;

    void pdf_tos_set_matrix(pdf_text_object_state*, float, float, float, float, float, float) @nogc nothrow;

    void pdf_tos_translate(pdf_text_object_state*, float, float) @nogc nothrow;

    void pdf_tos_move_after_char(fz_context*, pdf_text_object_state*) @nogc nothrow;

    int pdf_tos_make_trm(fz_context*, pdf_text_object_state*, pdf_text_state*, pdf_font_desc*, int, fz_matrix*) @nogc nothrow;

    void pdf_tos_reset(fz_context*, pdf_text_object_state*, int) @nogc nothrow;

    fz_text* pdf_tos_get_text(fz_context*, pdf_text_object_state*) @nogc nothrow;

    void pdf_tos_restore(fz_context*, pdf_text_object_state*, fz_matrix*) @nogc nothrow;

    void pdf_tos_save(fz_context*, pdf_text_object_state*, fz_matrix*) @nogc nothrow;

    struct pdf_text_object_state
    {

        fz_text* text;

        fz_rect text_bbox;

        fz_matrix tlm;

        fz_matrix tm;

        int text_mode;

        int cid;

        int gid;

        fz_rect char_bbox;

        pdf_font_desc* fontdesc;

        float char_tx;

        float char_ty;
    }

    struct pdf_text_state
    {

        float char_space;

        float word_space;

        float scale;

        float leading;

        pdf_font_desc* font;

        float size;

        int render;

        float rise;
    }

    void pdf_process_glyph(fz_context*, pdf_processor*, pdf_document*, pdf_obj*, fz_buffer*) @nogc nothrow;

    void pdf_process_annot(fz_context*, pdf_processor*, pdf_annot*, fz_cookie*) @nogc nothrow;

    void pdf_process_contents(fz_context*, pdf_processor*, pdf_document*, pdf_obj*, pdf_obj*, fz_cookie*) @nogc nothrow;

    pdf_obj* pdf_filter_xobject_instance(fz_context*, pdf_obj*, pdf_obj*, fz_matrix, pdf_filter_options*, pdf_cycle_list*) @nogc nothrow;

    pdf_processor* pdf_new_filter_processor(fz_context*, pdf_document*, pdf_processor*, pdf_obj*, pdf_obj*, int, fz_matrix, pdf_filter_options*) @nogc nothrow;

    struct pdf_filter_options
    {

        void* opaque;

        fz_image* function(fz_context*, void*, fz_matrix, const(char)*, fz_image*) image_filter;

        int function(fz_context*, void*, int*, int, fz_matrix, fz_matrix, fz_rect) text_filter;

        void function(fz_context*, void*, pdf_document*, pdf_processor*, fz_matrix) after_text_object;

        void function(fz_context*, fz_buffer*, void*) end_page;

        int recurse;

        int instance_forms;

        int sanitize;

        int ascii;
    }

    pdf_processor* pdf_new_output_processor(fz_context*, fz_output*, int) @nogc nothrow;

    pdf_processor* pdf_new_buffer_processor(fz_context*, fz_buffer*, int) @nogc nothrow;

    pdf_processor* pdf_new_run_processor(fz_context*, fz_device*, fz_matrix, const(char)*, pdf_gstate*, fz_default_colorspaces*, fz_cookie*) @nogc nothrow;

    struct pdf_csi
    {

        pdf_document* doc;

        pdf_obj* rdb;

        pdf_lexbuf* buf;

        fz_cookie* cookie;

        int gstate;

        int xbalance;

        int in_text;

        fz_rect d1_rect;

        pdf_obj* obj;

        char[256] name;

        char[256] string_;

        ulong string_len;

        int top;

        float[32] stack;
    }

    void pdf_drop_processor(fz_context*, pdf_processor*) @nogc nothrow;

    void pdf_close_processor(fz_context*, pdf_processor*) @nogc nothrow;

    pdf_processor* pdf_keep_processor(fz_context*, pdf_processor*) @nogc nothrow;

    void* pdf_new_processor(fz_context*, int) @nogc nothrow;

    struct pdf_processor
    {

        int refs;

        void function(fz_context*, pdf_processor*) close_processor;

        void function(fz_context*, pdf_processor*) drop_processor;

        void function(fz_context*, pdf_processor*, float) op_w;

        void function(fz_context*, pdf_processor*, int) op_j;

        void function(fz_context*, pdf_processor*, int) op_J;

        void function(fz_context*, pdf_processor*, float) op_M;

        void function(fz_context*, pdf_processor*, pdf_obj*, float) op_d;

        void function(fz_context*, pdf_processor*, const(char)*) op_ri;

        void function(fz_context*, pdf_processor*, float) op_i;

        void function(fz_context*, pdf_processor*, const(char)*, pdf_obj*) op_gs_begin;

        void function(fz_context*, pdf_processor*, const(char)*) op_gs_BM;

        void function(fz_context*, pdf_processor*, float) op_gs_ca;

        void function(fz_context*, pdf_processor*, float) op_gs_CA;

        void function(fz_context*, pdf_processor*, pdf_obj*, pdf_obj*, float*, int) op_gs_SMask;

        void function(fz_context*, pdf_processor*) op_gs_end;

        void function(fz_context*, pdf_processor*) op_q;

        void function(fz_context*, pdf_processor*) op_Q;

        void function(fz_context*, pdf_processor*, float, float, float, float, float, float) op_cm;

        void function(fz_context*, pdf_processor*, float, float) op_m;

        void function(fz_context*, pdf_processor*, float, float) op_l;

        void function(fz_context*, pdf_processor*, float, float, float, float, float, float) op_c;

        void function(fz_context*, pdf_processor*, float, float, float, float) op_v;

        void function(fz_context*, pdf_processor*, float, float, float, float) op_y;

        void function(fz_context*, pdf_processor*) op_h;

        void function(fz_context*, pdf_processor*, float, float, float, float) op_re;

        void function(fz_context*, pdf_processor*) op_S;

        void function(fz_context*, pdf_processor*) op_s;

        void function(fz_context*, pdf_processor*) op_F;

        void function(fz_context*, pdf_processor*) op_f;

        void function(fz_context*, pdf_processor*) op_fstar;

        void function(fz_context*, pdf_processor*) op_B;

        void function(fz_context*, pdf_processor*) op_Bstar;

        void function(fz_context*, pdf_processor*) op_b;

        void function(fz_context*, pdf_processor*) op_bstar;

        void function(fz_context*, pdf_processor*) op_n;

        void function(fz_context*, pdf_processor*) op_W;

        void function(fz_context*, pdf_processor*) op_Wstar;

        void function(fz_context*, pdf_processor*) op_BT;

        void function(fz_context*, pdf_processor*) op_ET;

        void function(fz_context*, pdf_processor*, float) op_Tc;

        void function(fz_context*, pdf_processor*, float) op_Tw;

        void function(fz_context*, pdf_processor*, float) op_Tz;

        void function(fz_context*, pdf_processor*, float) op_TL;

        void function(fz_context*, pdf_processor*, const(char)*, pdf_font_desc*, float) op_Tf;

        void function(fz_context*, pdf_processor*, int) op_Tr;

        void function(fz_context*, pdf_processor*, float) op_Ts;

        void function(fz_context*, pdf_processor*, float, float) op_Td;

        void function(fz_context*, pdf_processor*, float, float) op_TD;

        void function(fz_context*, pdf_processor*, float, float, float, float, float, float) op_Tm;

        void function(fz_context*, pdf_processor*) op_Tstar;

        void function(fz_context*, pdf_processor*, pdf_obj*) op_TJ;

        void function(fz_context*, pdf_processor*, char*, ulong) op_Tj;

        void function(fz_context*, pdf_processor*, char*, ulong) op_squote;

        void function(fz_context*, pdf_processor*, float, float, char*, ulong) op_dquote;

        void function(fz_context*, pdf_processor*, float, float) op_d0;

        void function(fz_context*, pdf_processor*, float, float, float, float, float, float) op_d1;

        void function(fz_context*, pdf_processor*, const(char)*, fz_colorspace*) op_CS;

        void function(fz_context*, pdf_processor*, const(char)*, fz_colorspace*) op_cs;

        void function(fz_context*, pdf_processor*, const(char)*, pdf_pattern*, int, float*) op_SC_pattern;

        void function(fz_context*, pdf_processor*, const(char)*, pdf_pattern*, int, float*) op_sc_pattern;

        void function(fz_context*, pdf_processor*, const(char)*, fz_shade*) op_SC_shade;

        void function(fz_context*, pdf_processor*, const(char)*, fz_shade*) op_sc_shade;

        void function(fz_context*, pdf_processor*, int, float*) op_SC_color;

        void function(fz_context*, pdf_processor*, int, float*) op_sc_color;

        void function(fz_context*, pdf_processor*, float) op_G;

        void function(fz_context*, pdf_processor*, float) op_g;

        void function(fz_context*, pdf_processor*, float, float, float) op_RG;

        void function(fz_context*, pdf_processor*, float, float, float) op_rg;

        void function(fz_context*, pdf_processor*, float, float, float, float) op_K;

        void function(fz_context*, pdf_processor*, float, float, float, float) op_k;

        void function(fz_context*, pdf_processor*, fz_image*, const(char)*) op_BI;

        void function(fz_context*, pdf_processor*, const(char)*, fz_shade*) op_sh;

        void function(fz_context*, pdf_processor*, const(char)*, fz_image*) op_Do_image;

        void function(fz_context*, pdf_processor*, const(char)*, pdf_obj*, pdf_obj*) op_Do_form;

        void function(fz_context*, pdf_processor*, const(char)*) op_MP;

        void function(fz_context*, pdf_processor*, const(char)*, pdf_obj*, pdf_obj*) op_DP;

        void function(fz_context*, pdf_processor*, const(char)*) op_BMC;

        void function(fz_context*, pdf_processor*, const(char)*, pdf_obj*, pdf_obj*) op_BDC;

        void function(fz_context*, pdf_processor*) op_EMC;

        void function(fz_context*, pdf_processor*) op_BX;

        void function(fz_context*, pdf_processor*) op_EX;

        void function(fz_context*, pdf_processor*, int) op_gs_OP;

        void function(fz_context*, pdf_processor*, int) op_gs_op;

        void function(fz_context*, pdf_processor*, int) op_gs_OPM;

        void function(fz_context*, pdf_processor*, pdf_obj*) op_gs_UseBlackPtComp;

        void function(fz_context*, pdf_processor*) op_END;

        const(char)* usage;

        int hidden;
    }
    struct pdf_gstate;

    void pdf_annot_event_page_invisible(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_event_page_visible(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_event_page_close(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_event_page_open(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_event_blur(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_event_focus(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_event_up(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_event_down(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_event_exit(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_event_enter(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_page_event_close(fz_context*, pdf_page*) @nogc nothrow;

    void pdf_page_event_open(fz_context*, pdf_page*) @nogc nothrow;

    void pdf_document_event_did_print(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_document_event_will_print(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_document_event_did_save(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_document_event_will_save(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_document_event_will_close(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_annot_field_event_keystroke(fz_context*, pdf_document*, pdf_annot*, pdf_keystroke_event*) @nogc nothrow;

    char* pdf_field_event_format(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    void pdf_field_event_calculate(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    int pdf_field_event_validate(fz_context*, pdf_document*, pdf_obj*, const(char)*, char**) @nogc nothrow;

    int pdf_field_event_keystroke(fz_context*, pdf_document*, pdf_obj*, pdf_keystroke_event*) @nogc nothrow;

    struct pdf_keystroke_event
    {

        const(char)* value;

        const(char)* change;

        int selStart;

        int selEnd;

        int willCommit;

        char* newChange;

        char* newValue;
    }

    pdf_obj* pdf_lookup_field(fz_context*, pdf_obj*, const(char)*) @nogc nothrow;

    void pdf_field_reset(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    void pdf_drop_verifier(fz_context*, pdf_pkcs7_verifier*) @nogc nothrow;

    void pdf_drop_signer(fz_context*, pdf_pkcs7_signer*) @nogc nothrow;

    int pdf_check_signature(fz_context*, pdf_pkcs7_verifier*, pdf_document*, pdf_obj*, char*, ulong) @nogc nothrow;

    fz_pixmap* pdf_preview_signature_as_pixmap(fz_context*, int, int, fz_text_language, pdf_pkcs7_signer*, int, fz_image*, const(char)*, const(char)*) @nogc nothrow;

    fz_display_list* pdf_preview_signature_as_display_list(fz_context*, float, float, fz_text_language, pdf_pkcs7_signer*, int, fz_image*, const(char)*, const(char)*) @nogc nothrow;

    void pdf_sign_signature(fz_context*, pdf_annot*, pdf_pkcs7_signer*, int, fz_image*, const(char)*, const(char)*) @nogc nothrow;

    enum _Anonymous_6
    {

        PDF_SIGNATURE_SHOW_LABELS = 1,

        PDF_SIGNATURE_SHOW_DN = 2,

        PDF_SIGNATURE_SHOW_DATE = 4,

        PDF_SIGNATURE_SHOW_TEXT_NAME = 8,

        PDF_SIGNATURE_SHOW_GRAPHIC_NAME = 16,

        PDF_SIGNATURE_SHOW_LOGO = 32,
    }
    enum PDF_SIGNATURE_SHOW_LABELS = _Anonymous_6.PDF_SIGNATURE_SHOW_LABELS;
    enum PDF_SIGNATURE_SHOW_DN = _Anonymous_6.PDF_SIGNATURE_SHOW_DN;
    enum PDF_SIGNATURE_SHOW_DATE = _Anonymous_6.PDF_SIGNATURE_SHOW_DATE;
    enum PDF_SIGNATURE_SHOW_TEXT_NAME = _Anonymous_6.PDF_SIGNATURE_SHOW_TEXT_NAME;
    enum PDF_SIGNATURE_SHOW_GRAPHIC_NAME = _Anonymous_6.PDF_SIGNATURE_SHOW_GRAPHIC_NAME;
    enum PDF_SIGNATURE_SHOW_LOGO = _Anonymous_6.PDF_SIGNATURE_SHOW_LOGO;

    void pdf_sign_signature_with_appearance(fz_context*, pdf_annot*, pdf_pkcs7_signer*, long, fz_display_list*) @nogc nothrow;

    void pdf_clear_signature(fz_context*, pdf_annot*) @nogc nothrow;

    pdf_signature_error pdf_check_widget_certificate(fz_context*, pdf_pkcs7_verifier*, pdf_annot*) @nogc nothrow;

    pdf_signature_error pdf_check_widget_digest(fz_context*, pdf_pkcs7_verifier*, pdf_annot*) @nogc nothrow;

    pdf_signature_error pdf_check_certificate(fz_context*, pdf_pkcs7_verifier*, pdf_document*, pdf_obj*) @nogc nothrow;

    pdf_signature_error pdf_check_digest(fz_context*, pdf_pkcs7_verifier*, pdf_document*, pdf_obj*) @nogc nothrow;

    fz_display_list* pdf_signature_appearance_unsigned(fz_context*, fz_rect, fz_text_language) @nogc nothrow;

    fz_display_list* pdf_signature_appearance_signed(fz_context*, fz_rect, fz_text_language, fz_image*, const(char)*, const(char)*, int) @nogc nothrow;

    char* pdf_signature_info(fz_context*, const(char)*, pdf_pkcs7_distinguished_name*, const(char)*, const(char)*, long, int) @nogc nothrow;

    char* pdf_signature_format_distinguished_name(fz_context*, pdf_pkcs7_distinguished_name*) @nogc nothrow;

    void pdf_signature_drop_distinguished_name(fz_context*, pdf_pkcs7_distinguished_name*) @nogc nothrow;

    pdf_pkcs7_distinguished_name* pdf_signature_get_widget_signatory(fz_context*, pdf_pkcs7_verifier*, pdf_annot*) @nogc nothrow;

    pdf_pkcs7_distinguished_name* pdf_signature_get_signatory(fz_context*, pdf_pkcs7_verifier*, pdf_document*, pdf_obj*) @nogc nothrow;

    char* pdf_signature_error_description(pdf_signature_error) @nogc nothrow;

    int pdf_count_signatures(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_signature_set_value(fz_context*, pdf_document*, pdf_obj*, pdf_pkcs7_signer*, long) @nogc nothrow;

    int pdf_signature_is_signed(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;
    alias pdf_pkcs7_get_signatory_fn = pdf_pkcs7_distinguished_name* function(fz_context*, pdf_pkcs7_verifier*, ubyte*, ulong);
    alias pdf_pkcs7_check_digest_fn = pdf_signature_error function(fz_context*, pdf_pkcs7_verifier*, fz_stream*, ubyte*, ulong);
    alias pdf_pkcs7_check_certificate_fn = pdf_signature_error function(fz_context*, pdf_pkcs7_verifier*, ubyte*, ulong);
    alias pdf_pkcs7_drop_verifier_fn = void function(fz_context*, pdf_pkcs7_verifier*);

    struct pdf_pkcs7_verifier
    {

        void function(fz_context*, pdf_pkcs7_verifier*) drop;

        pdf_signature_error function(fz_context*, pdf_pkcs7_verifier*, ubyte*, ulong) check_certificate;

        pdf_signature_error function(fz_context*, pdf_pkcs7_verifier*, fz_stream*, ubyte*, ulong) check_digest;

        pdf_pkcs7_distinguished_name* function(fz_context*, pdf_pkcs7_verifier*, ubyte*, ulong) get_signatory;
    }
    alias pdf_pkcs7_create_digest_fn = int function(fz_context*, pdf_pkcs7_signer*, fz_stream*, ubyte*, ulong);
    alias pdf_pkcs7_max_digest_size_fn = ulong function(fz_context*, pdf_pkcs7_signer*);
    alias pdf_pkcs7_get_signing_name_fn = pdf_pkcs7_distinguished_name* function(fz_context*, pdf_pkcs7_signer*);
    alias pdf_pkcs7_drop_signer_fn = void function(fz_context*, pdf_pkcs7_signer*);
    alias pdf_pkcs7_keep_signer_fn = pdf_pkcs7_signer* function(fz_context*, pdf_pkcs7_signer*);

    enum _Anonymous_7
    {

        PDF_SIGNATURE_ERROR_OKAY = 0,

        PDF_SIGNATURE_ERROR_NO_SIGNATURES = 1,

        PDF_SIGNATURE_ERROR_NO_CERTIFICATE = 2,

        PDF_SIGNATURE_ERROR_DIGEST_FAILURE = 3,

        PDF_SIGNATURE_ERROR_SELF_SIGNED = 4,

        PDF_SIGNATURE_ERROR_SELF_SIGNED_IN_CHAIN = 5,

        PDF_SIGNATURE_ERROR_NOT_TRUSTED = 6,

        PDF_SIGNATURE_ERROR_UNKNOWN = 7,
    }
    enum PDF_SIGNATURE_ERROR_OKAY = _Anonymous_7.PDF_SIGNATURE_ERROR_OKAY;
    enum PDF_SIGNATURE_ERROR_NO_SIGNATURES = _Anonymous_7.PDF_SIGNATURE_ERROR_NO_SIGNATURES;
    enum PDF_SIGNATURE_ERROR_NO_CERTIFICATE = _Anonymous_7.PDF_SIGNATURE_ERROR_NO_CERTIFICATE;
    enum PDF_SIGNATURE_ERROR_DIGEST_FAILURE = _Anonymous_7.PDF_SIGNATURE_ERROR_DIGEST_FAILURE;
    enum PDF_SIGNATURE_ERROR_SELF_SIGNED = _Anonymous_7.PDF_SIGNATURE_ERROR_SELF_SIGNED;
    enum PDF_SIGNATURE_ERROR_SELF_SIGNED_IN_CHAIN = _Anonymous_7.PDF_SIGNATURE_ERROR_SELF_SIGNED_IN_CHAIN;
    enum PDF_SIGNATURE_ERROR_NOT_TRUSTED = _Anonymous_7.PDF_SIGNATURE_ERROR_NOT_TRUSTED;
    enum PDF_SIGNATURE_ERROR_UNKNOWN = _Anonymous_7.PDF_SIGNATURE_ERROR_UNKNOWN;

    alias pdf_signature_error = _Anonymous_7;

    struct pdf_pkcs7_distinguished_name
    {

        char* cn;

        char* o;

        char* ou;

        char* email;

        char* c;
    }

    int pdf_edit_text_field_value(fz_context*, pdf_annot*, const(char)*, const(char)*, int*, int*, char**) @nogc nothrow;

    int pdf_set_choice_field_value(fz_context*, pdf_annot*, const(char)*) @nogc nothrow;

    int pdf_set_text_field_value(fz_context*, pdf_annot*, const(char)*) @nogc nothrow;

    int pdf_set_field_value(fz_context*, pdf_document*, pdf_obj*, const(char)*, int) @nogc nothrow;

    pdf_obj* pdf_button_field_on_state(fz_context*, pdf_obj*) @nogc nothrow;

    const(char)* pdf_field_label(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_field_set_display(fz_context*, pdf_obj*, int) @nogc nothrow;

    int pdf_field_display(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_field_set_text_color(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    void pdf_field_set_fill_color(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    void pdf_field_set_button_caption(fz_context*, pdf_obj*, const(char)*) @nogc nothrow;

    void pdf_field_set_border_style(fz_context*, pdf_obj*, const(char)*) @nogc nothrow;

    char* pdf_field_border_style(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_create_field_name(fz_context*, pdf_document*, const(char)*, char*, ulong) @nogc nothrow;

    const(char)* pdf_field_value(fz_context*, pdf_obj*) @nogc nothrow;

    char* pdf_field_name(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_field_flags(fz_context*, pdf_obj*) @nogc nothrow;

    const(char)* pdf_field_type_string(fz_context*, pdf_obj*) @nogc nothrow;

    int pdf_field_type(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_reset_form(fz_context*, pdf_document*, pdf_obj*, int) @nogc nothrow;

    void pdf_calculate_form(fz_context*, pdf_document*) @nogc nothrow;

    enum _Anonymous_8
    {

        PDF_FIELD_IS_READ_ONLY = 1,

        PDF_FIELD_IS_REQUIRED = 2,

        PDF_FIELD_IS_NO_EXPORT = 4,

        PDF_TX_FIELD_IS_MULTILINE = 4096,

        PDF_TX_FIELD_IS_PASSWORD = 8192,

        PDF_TX_FIELD_IS_FILE_SELECT = 1048576,

        PDF_TX_FIELD_IS_DO_NOT_SPELL_CHECK = 4194304,

        PDF_TX_FIELD_IS_DO_NOT_SCROLL = 8388608,

        PDF_TX_FIELD_IS_COMB = 16777216,

        PDF_TX_FIELD_IS_RICH_TEXT = 33554432,

        PDF_BTN_FIELD_IS_NO_TOGGLE_TO_OFF = 16384,

        PDF_BTN_FIELD_IS_RADIO = 32768,

        PDF_BTN_FIELD_IS_PUSHBUTTON = 65536,

        PDF_BTN_FIELD_IS_RADIOS_IN_UNISON = 33554432,

        PDF_CH_FIELD_IS_COMBO = 131072,

        PDF_CH_FIELD_IS_EDIT = 262144,

        PDF_CH_FIELD_IS_SORT = 524288,

        PDF_CH_FIELD_IS_MULTI_SELECT = 2097152,

        PDF_CH_FIELD_IS_DO_NOT_SPELL_CHECK = 4194304,

        PDF_CH_FIELD_IS_COMMIT_ON_SEL_CHANGE = 33554432,
    }
    enum PDF_FIELD_IS_READ_ONLY = _Anonymous_8.PDF_FIELD_IS_READ_ONLY;
    enum PDF_FIELD_IS_REQUIRED = _Anonymous_8.PDF_FIELD_IS_REQUIRED;
    enum PDF_FIELD_IS_NO_EXPORT = _Anonymous_8.PDF_FIELD_IS_NO_EXPORT;
    enum PDF_TX_FIELD_IS_MULTILINE = _Anonymous_8.PDF_TX_FIELD_IS_MULTILINE;
    enum PDF_TX_FIELD_IS_PASSWORD = _Anonymous_8.PDF_TX_FIELD_IS_PASSWORD;
    enum PDF_TX_FIELD_IS_FILE_SELECT = _Anonymous_8.PDF_TX_FIELD_IS_FILE_SELECT;
    enum PDF_TX_FIELD_IS_DO_NOT_SPELL_CHECK = _Anonymous_8.PDF_TX_FIELD_IS_DO_NOT_SPELL_CHECK;
    enum PDF_TX_FIELD_IS_DO_NOT_SCROLL = _Anonymous_8.PDF_TX_FIELD_IS_DO_NOT_SCROLL;
    enum PDF_TX_FIELD_IS_COMB = _Anonymous_8.PDF_TX_FIELD_IS_COMB;
    enum PDF_TX_FIELD_IS_RICH_TEXT = _Anonymous_8.PDF_TX_FIELD_IS_RICH_TEXT;
    enum PDF_BTN_FIELD_IS_NO_TOGGLE_TO_OFF = _Anonymous_8.PDF_BTN_FIELD_IS_NO_TOGGLE_TO_OFF;
    enum PDF_BTN_FIELD_IS_RADIO = _Anonymous_8.PDF_BTN_FIELD_IS_RADIO;
    enum PDF_BTN_FIELD_IS_PUSHBUTTON = _Anonymous_8.PDF_BTN_FIELD_IS_PUSHBUTTON;
    enum PDF_BTN_FIELD_IS_RADIOS_IN_UNISON = _Anonymous_8.PDF_BTN_FIELD_IS_RADIOS_IN_UNISON;
    enum PDF_CH_FIELD_IS_COMBO = _Anonymous_8.PDF_CH_FIELD_IS_COMBO;
    enum PDF_CH_FIELD_IS_EDIT = _Anonymous_8.PDF_CH_FIELD_IS_EDIT;
    enum PDF_CH_FIELD_IS_SORT = _Anonymous_8.PDF_CH_FIELD_IS_SORT;
    enum PDF_CH_FIELD_IS_MULTI_SELECT = _Anonymous_8.PDF_CH_FIELD_IS_MULTI_SELECT;
    enum PDF_CH_FIELD_IS_DO_NOT_SPELL_CHECK = _Anonymous_8.PDF_CH_FIELD_IS_DO_NOT_SPELL_CHECK;
    enum PDF_CH_FIELD_IS_COMMIT_ON_SEL_CHANGE = _Anonymous_8.PDF_CH_FIELD_IS_COMMIT_ON_SEL_CHANGE;

    int pdf_widget_is_readonly(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_widget_is_signed(fz_context*, pdf_annot*) @nogc nothrow;

    const(char)* pdf_choice_field_option(fz_context*, pdf_obj*, int, int) @nogc nothrow;

    int pdf_choice_field_option_count(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_choice_widget_set_value(fz_context*, pdf_annot*, int, const(char)**) @nogc nothrow;

    int pdf_choice_widget_value(fz_context*, pdf_annot*, const(char)**) @nogc nothrow;

    int pdf_choice_widget_is_multiselect(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_choice_widget_options(fz_context*, pdf_annot*, int, const(char)**) @nogc nothrow;

    int pdf_text_widget_format(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_text_widget_max_len(fz_context*, pdf_annot*) @nogc nothrow;

    fz_rect pdf_bound_widget(fz_context*, pdf_annot*) @nogc nothrow;
    pragma(mangle, "pdf_widget_type")
    pdf_widget_type pdf_widget_type_(fz_context*, pdf_annot*) @nogc nothrow;

    pdf_annot* pdf_create_signature_widget(fz_context*, pdf_page*, char*) @nogc nothrow;

    int pdf_update_widget(fz_context*, pdf_annot*) @nogc nothrow;

    pdf_annot* pdf_next_widget(fz_context*, pdf_annot*) @nogc nothrow;

    pdf_annot* pdf_first_widget(fz_context*, pdf_page*) @nogc nothrow;

    void pdf_drop_widget(fz_context*, pdf_annot*) @nogc nothrow;

    pdf_annot* pdf_keep_widget(fz_context*, pdf_annot*) @nogc nothrow;

    enum pdf_widget_tx_format
    {

        PDF_WIDGET_TX_FORMAT_NONE = 0,

        PDF_WIDGET_TX_FORMAT_NUMBER = 1,

        PDF_WIDGET_TX_FORMAT_SPECIAL = 2,

        PDF_WIDGET_TX_FORMAT_DATE = 3,

        PDF_WIDGET_TX_FORMAT_TIME = 4,
    }
    enum PDF_WIDGET_TX_FORMAT_NONE = pdf_widget_tx_format.PDF_WIDGET_TX_FORMAT_NONE;
    enum PDF_WIDGET_TX_FORMAT_NUMBER = pdf_widget_tx_format.PDF_WIDGET_TX_FORMAT_NUMBER;
    enum PDF_WIDGET_TX_FORMAT_SPECIAL = pdf_widget_tx_format.PDF_WIDGET_TX_FORMAT_SPECIAL;
    enum PDF_WIDGET_TX_FORMAT_DATE = pdf_widget_tx_format.PDF_WIDGET_TX_FORMAT_DATE;
    enum PDF_WIDGET_TX_FORMAT_TIME = pdf_widget_tx_format.PDF_WIDGET_TX_FORMAT_TIME;

    enum pdf_widget_type
    {

        PDF_WIDGET_TYPE_UNKNOWN = 0,

        PDF_WIDGET_TYPE_BUTTON = 1,

        PDF_WIDGET_TYPE_CHECKBOX = 2,

        PDF_WIDGET_TYPE_COMBOBOX = 3,

        PDF_WIDGET_TYPE_LISTBOX = 4,

        PDF_WIDGET_TYPE_RADIOBUTTON = 5,

        PDF_WIDGET_TYPE_SIGNATURE = 6,

        PDF_WIDGET_TYPE_TEXT = 7,
    }
    enum PDF_WIDGET_TYPE_UNKNOWN = pdf_widget_type.PDF_WIDGET_TYPE_UNKNOWN;
    enum PDF_WIDGET_TYPE_BUTTON = pdf_widget_type.PDF_WIDGET_TYPE_BUTTON;
    enum PDF_WIDGET_TYPE_CHECKBOX = pdf_widget_type.PDF_WIDGET_TYPE_CHECKBOX;
    enum PDF_WIDGET_TYPE_COMBOBOX = pdf_widget_type.PDF_WIDGET_TYPE_COMBOBOX;
    enum PDF_WIDGET_TYPE_LISTBOX = pdf_widget_type.PDF_WIDGET_TYPE_LISTBOX;
    enum PDF_WIDGET_TYPE_RADIOBUTTON = pdf_widget_type.PDF_WIDGET_TYPE_RADIOBUTTON;
    enum PDF_WIDGET_TYPE_SIGNATURE = pdf_widget_type.PDF_WIDGET_TYPE_SIGNATURE;
    enum PDF_WIDGET_TYPE_TEXT = pdf_widget_type.PDF_WIDGET_TYPE_TEXT;

    int pdf_font_writing_supported(fz_font*) @nogc nothrow;

    pdf_obj* pdf_add_substitute_font(fz_context*, pdf_document*, fz_font*) @nogc nothrow;

    pdf_obj* pdf_add_cjk_font(fz_context*, pdf_document*, fz_font*, int, int, int) @nogc nothrow;

    pdf_obj* pdf_add_cid_font(fz_context*, pdf_document*, fz_font*) @nogc nothrow;

    pdf_obj* pdf_add_simple_font(fz_context*, pdf_document*, fz_font*, int) @nogc nothrow;

    void pdf_run_glyph(fz_context*, pdf_document*, pdf_obj*, fz_buffer*, fz_device*, fz_matrix, void*, fz_default_colorspaces*) @nogc nothrow;

    void pdf_print_font(fz_context*, fz_output*, pdf_font_desc*) @nogc nothrow;

    void pdf_drop_font(fz_context*, pdf_font_desc*) @nogc nothrow;

    pdf_font_desc* pdf_keep_font(fz_context*, pdf_font_desc*) @nogc nothrow;

    pdf_font_desc* pdf_new_font_desc(fz_context*) @nogc nothrow;

    pdf_font_desc* pdf_load_hail_mary_font(fz_context*, pdf_document*) @nogc nothrow;

    pdf_font_desc* pdf_load_font(fz_context*, pdf_document*, pdf_obj*, pdf_obj*) @nogc nothrow;

    void pdf_load_type3_glyphs(fz_context*, pdf_document*, pdf_font_desc*) @nogc nothrow;

    pdf_font_desc* pdf_load_type3_font(fz_context*, pdf_document*, pdf_obj*, pdf_obj*) @nogc nothrow;

    const(ubyte)* pdf_lookup_substitute_font(fz_context*, int, int, int, int, int*) @nogc nothrow;

    const(char)* pdf_clean_font_name(const(char)*) @nogc nothrow;

    int pdf_font_cid_to_gid(fz_context*, pdf_font_desc*, int) @nogc nothrow;

    void pdf_load_to_unicode(fz_context*, pdf_document*, pdf_font_desc*, const(char)**, char*, pdf_obj*) @nogc nothrow;

    pdf_vmtx pdf_lookup_vmtx(fz_context*, pdf_font_desc*, int) @nogc nothrow;

    pdf_hmtx pdf_lookup_hmtx(fz_context*, pdf_font_desc*, int) @nogc nothrow;

    void pdf_end_vmtx(fz_context*, pdf_font_desc*) @nogc nothrow;

    void pdf_end_hmtx(fz_context*, pdf_font_desc*) @nogc nothrow;

    void pdf_add_vmtx(fz_context*, pdf_font_desc*, int, int, int, int, int) @nogc nothrow;

    void pdf_add_hmtx(fz_context*, pdf_font_desc*, int, int, int) @nogc nothrow;

    void pdf_set_default_vmtx(fz_context*, pdf_font_desc*, int, int) @nogc nothrow;

    void pdf_set_default_hmtx(fz_context*, pdf_font_desc*, int) @nogc nothrow;

    void pdf_set_font_wmode(fz_context*, pdf_font_desc*, int) @nogc nothrow;

    struct pdf_font_desc
    {

        fz_storable storable;

        ulong size;

        fz_font* font;

        int flags;

        float italic_angle;

        float ascent;

        float descent;

        float cap_height;

        float x_height;

        float missing_width;

        pdf_cmap* encoding;

        pdf_cmap* to_ttf_cmap;

        ulong cid_to_gid_len;

        ushort* cid_to_gid;

        pdf_cmap* to_unicode;

        ulong cid_to_ucs_len;

        ushort* cid_to_ucs;

        int wmode;

        int hmtx_len;

        int hmtx_cap;

        pdf_hmtx dhmtx;

        pdf_hmtx* hmtx;

        int vmtx_len;

        int vmtx_cap;

        pdf_vmtx dvmtx;

        pdf_vmtx* vmtx;

        int is_embedded;
    }

    struct pdf_vmtx
    {

        ushort lo;

        ushort hi;

        short x;

        short y;

        short w;
    }

    struct pdf_hmtx
    {

        ushort lo;

        ushort hi;

        int w;
    }

    void pdf_load_encoding(const(char)**, const(char)*) @nogc nothrow;

    enum _Anonymous_9
    {

        PDF_FD_FIXED_PITCH = 1,

        PDF_FD_SERIF = 2,

        PDF_FD_SYMBOLIC = 4,

        PDF_FD_SCRIPT = 8,

        PDF_FD_NONSYMBOLIC = 32,

        PDF_FD_ITALIC = 64,

        PDF_FD_ALL_CAP = 65536,

        PDF_FD_SMALL_CAP = 131072,

        PDF_FD_FORCE_BOLD = 262144,
    }
    enum PDF_FD_FIXED_PITCH = _Anonymous_9.PDF_FD_FIXED_PITCH;
    enum PDF_FD_SERIF = _Anonymous_9.PDF_FD_SERIF;
    enum PDF_FD_SYMBOLIC = _Anonymous_9.PDF_FD_SYMBOLIC;
    enum PDF_FD_SCRIPT = _Anonymous_9.PDF_FD_SCRIPT;
    enum PDF_FD_NONSYMBOLIC = _Anonymous_9.PDF_FD_NONSYMBOLIC;
    enum PDF_FD_ITALIC = _Anonymous_9.PDF_FD_ITALIC;
    enum PDF_FD_ALL_CAP = _Anonymous_9.PDF_FD_ALL_CAP;
    enum PDF_FD_SMALL_CAP = _Anonymous_9.PDF_FD_SMALL_CAP;
    enum PDF_FD_FORCE_BOLD = _Anonymous_9.PDF_FD_FORCE_BOLD;

    void pdf_event_issue_mail_doc(fz_context*, pdf_document*, pdf_mail_doc_event*) @nogc nothrow;

    void pdf_event_issue_launch_url(fz_context*, pdf_document*, const(char)*, int) @nogc nothrow;

    void pdf_event_issue_exec_menu_item(fz_context*, pdf_document*, const(char)*) @nogc nothrow;

    void pdf_event_issue_print(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_event_issue_alert(fz_context*, pdf_document*, pdf_alert_event*) @nogc nothrow;

    pdf_mail_doc_event* pdf_access_mail_doc_event(fz_context*, pdf_doc_event*) @nogc nothrow;

    struct pdf_mail_doc_event
    {

        int ask_user;

        const(char)* to;

        const(char)* cc;

        const(char)* bcc;

        const(char)* subject;

        const(char)* message;
    }

    pdf_launch_url_event* pdf_access_launch_url_event(fz_context*, pdf_doc_event*) @nogc nothrow;

    struct pdf_launch_url_event
    {

        const(char)* url;

        int new_frame;
    }

    const(char)* pdf_access_exec_menu_item_event(fz_context*, pdf_doc_event*) @nogc nothrow;

    pdf_alert_event* pdf_access_alert_event(fz_context*, pdf_doc_event*) @nogc nothrow;

    enum _Anonymous_10
    {

        PDF_ALERT_BUTTON_NONE = 0,

        PDF_ALERT_BUTTON_OK = 1,

        PDF_ALERT_BUTTON_CANCEL = 2,

        PDF_ALERT_BUTTON_NO = 3,

        PDF_ALERT_BUTTON_YES = 4,
    }
    enum PDF_ALERT_BUTTON_NONE = _Anonymous_10.PDF_ALERT_BUTTON_NONE;
    enum PDF_ALERT_BUTTON_OK = _Anonymous_10.PDF_ALERT_BUTTON_OK;
    enum PDF_ALERT_BUTTON_CANCEL = _Anonymous_10.PDF_ALERT_BUTTON_CANCEL;
    enum PDF_ALERT_BUTTON_NO = _Anonymous_10.PDF_ALERT_BUTTON_NO;
    enum PDF_ALERT_BUTTON_YES = _Anonymous_10.PDF_ALERT_BUTTON_YES;

    enum _Anonymous_11
    {

        PDF_ALERT_BUTTON_GROUP_OK = 0,

        PDF_ALERT_BUTTON_GROUP_OK_CANCEL = 1,

        PDF_ALERT_BUTTON_GROUP_YES_NO = 2,

        PDF_ALERT_BUTTON_GROUP_YES_NO_CANCEL = 3,
    }
    enum PDF_ALERT_BUTTON_GROUP_OK = _Anonymous_11.PDF_ALERT_BUTTON_GROUP_OK;
    enum PDF_ALERT_BUTTON_GROUP_OK_CANCEL = _Anonymous_11.PDF_ALERT_BUTTON_GROUP_OK_CANCEL;
    enum PDF_ALERT_BUTTON_GROUP_YES_NO = _Anonymous_11.PDF_ALERT_BUTTON_GROUP_YES_NO;
    enum PDF_ALERT_BUTTON_GROUP_YES_NO_CANCEL = _Anonymous_11.PDF_ALERT_BUTTON_GROUP_YES_NO_CANCEL;

    enum _Anonymous_12
    {

        PDF_ALERT_ICON_ERROR = 0,

        PDF_ALERT_ICON_WARNING = 1,

        PDF_ALERT_ICON_QUESTION = 2,

        PDF_ALERT_ICON_STATUS = 3,
    }
    enum PDF_ALERT_ICON_ERROR = _Anonymous_12.PDF_ALERT_ICON_ERROR;
    enum PDF_ALERT_ICON_WARNING = _Anonymous_12.PDF_ALERT_ICON_WARNING;
    enum PDF_ALERT_ICON_QUESTION = _Anonymous_12.PDF_ALERT_ICON_QUESTION;
    enum PDF_ALERT_ICON_STATUS = _Anonymous_12.PDF_ALERT_ICON_STATUS;

    struct pdf_alert_event
    {

        pdf_document* doc;

        const(char)* message;

        int icon_type;

        int button_group_type;

        const(char)* title;

        int has_check_box;

        const(char)* check_box_message;

        int initially_checked;

        int finally_checked;

        int button_pressed;
    }

    void* pdf_get_doc_event_callback_data(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_set_doc_event_callback(fz_context*, pdf_document*, void function(fz_context*, pdf_document*, pdf_doc_event*, void*), void function(fz_context*, void*), void*) @nogc nothrow;

    enum _Anonymous_13
    {

        PDF_DOCUMENT_EVENT_ALERT = 0,

        PDF_DOCUMENT_EVENT_PRINT = 1,

        PDF_DOCUMENT_EVENT_LAUNCH_URL = 2,

        PDF_DOCUMENT_EVENT_MAIL_DOC = 3,

        PDF_DOCUMENT_EVENT_SUBMIT = 4,

        PDF_DOCUMENT_EVENT_EXEC_MENU_ITEM = 5,
    }
    enum PDF_DOCUMENT_EVENT_ALERT = _Anonymous_13.PDF_DOCUMENT_EVENT_ALERT;
    enum PDF_DOCUMENT_EVENT_PRINT = _Anonymous_13.PDF_DOCUMENT_EVENT_PRINT;
    enum PDF_DOCUMENT_EVENT_LAUNCH_URL = _Anonymous_13.PDF_DOCUMENT_EVENT_LAUNCH_URL;
    enum PDF_DOCUMENT_EVENT_MAIL_DOC = _Anonymous_13.PDF_DOCUMENT_EVENT_MAIL_DOC;
    enum PDF_DOCUMENT_EVENT_SUBMIT = _Anonymous_13.PDF_DOCUMENT_EVENT_SUBMIT;
    enum PDF_DOCUMENT_EVENT_EXEC_MENU_ITEM = _Anonymous_13.PDF_DOCUMENT_EVENT_EXEC_MENU_ITEM;

    void pdf_read_journal(fz_context*, pdf_document*, fz_stream*) @nogc nothrow;

    void pdf_load_journal(fz_context*, pdf_document*, const(char)*) @nogc nothrow;

    void pdf_save_journal(fz_context*, pdf_document*, const(char)*) @nogc nothrow;

    void pdf_write_journal(fz_context*, pdf_document*, fz_output*) @nogc nothrow;

    int pdf_can_be_saved_incrementally(fz_context*, pdf_document*) @nogc nothrow;

    char* pdf_format_write_options(fz_context*, char*, ulong, const(pdf_write_options)*) @nogc nothrow;

    void pdf_write_snapshot(fz_context*, pdf_document*, fz_output*) @nogc nothrow;

    void pdf_save_snapshot(fz_context*, pdf_document*, const(char)*) @nogc nothrow;

    void pdf_save_document(fz_context*, pdf_document*, const(char)*, const(pdf_write_options)*) @nogc nothrow;

    void pdf_write_document(fz_context*, pdf_document*, fz_output*, const(pdf_write_options)*) @nogc nothrow;

    int pdf_has_unsaved_sigs(fz_context*, pdf_document*) @nogc nothrow;

    pdf_write_options* pdf_parse_write_options(fz_context*, pdf_write_options*, const(char)*) @nogc nothrow;

    extern __gshared const(pdf_write_options) pdf_default_write_options;

    struct pdf_write_options
    {

        int do_incremental;

        int do_pretty;

        int do_ascii;

        int do_compress;

        int do_compress_images;

        int do_compress_fonts;

        int do_decompress;

        int do_garbage;

        int do_linear;

        int do_clean;

        int do_sanitize;

        int do_appearance;

        int do_encrypt;

        int dont_regenerate_id;

        int permissions;

        char[128] opwd_utf8;

        char[128] upwd_utf8;

        int do_snapshot;

        int do_preserve_metadata;
    }

    void pdf_set_document_language(fz_context*, pdf_document*, fz_text_language) @nogc nothrow;

    fz_text_language pdf_document_language(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_delete_page_range(fz_context*, pdf_document*, int, int) @nogc nothrow;

    void pdf_delete_page(fz_context*, pdf_document*, int) @nogc nothrow;

    void pdf_insert_page(fz_context*, pdf_document*, int, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_add_page(fz_context*, pdf_document*, fz_rect, int, pdf_obj*, fz_buffer*) @nogc nothrow;

    fz_device* pdf_new_pdf_device(fz_context*, pdf_document*, fz_matrix, pdf_obj*, fz_buffer*) @nogc nothrow;

    fz_device* pdf_page_write(fz_context*, pdf_document*, fz_rect, pdf_obj**, fz_buffer**) @nogc nothrow;

    void pdf_graft_mapped_page(fz_context*, pdf_graft_map*, int, pdf_document*, int) @nogc nothrow;

    void pdf_graft_page(fz_context*, pdf_document*, int, pdf_document*, int) @nogc nothrow;

    pdf_obj* pdf_graft_mapped_object(fz_context*, pdf_graft_map*, pdf_obj*) @nogc nothrow;

    void pdf_drop_graft_map(fz_context*, pdf_graft_map*) @nogc nothrow;

    pdf_graft_map* pdf_keep_graft_map(fz_context*, pdf_graft_map*) @nogc nothrow;

    pdf_graft_map* pdf_new_graft_map(fz_context*, pdf_document*) @nogc nothrow;

    pdf_obj* pdf_graft_object(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;
    struct pdf_graft_map;

    pdf_document* pdf_create_document(fz_context*) @nogc nothrow;

    struct pdf_hint_shared
    {

        int number;

        long offset;
    }

    struct pdf_hint_page
    {

        int number;

        long offset;

        long index;
    }

    struct pdf_rev_page_map
    {

        int page;

        int object;
    }

    struct pdf_unsaved_sig
    {

        pdf_obj* field;

        ulong byte_range_start;

        ulong byte_range_end;

        ulong contents_start;

        ulong contents_end;

        pdf_pkcs7_signer* signer;

        pdf_unsaved_sig* next;
    }

    struct pdf_pkcs7_signer
    {

        pdf_pkcs7_signer* function(fz_context*, pdf_pkcs7_signer*) keep;

        void function(fz_context*, pdf_pkcs7_signer*) drop;

        pdf_pkcs7_distinguished_name* function(fz_context*, pdf_pkcs7_signer*) get_signing_name;

        ulong function(fz_context*, pdf_pkcs7_signer*) max_digest_size;

        int function(fz_context*, pdf_pkcs7_signer*, fz_stream*, ubyte*, ulong) create_digest;
    }

    int pdf_was_repaired(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_has_unsaved_changes(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_set_layer_config_as_default(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_layer_config_ui_info(fz_context*, pdf_document*, int, pdf_layer_config_ui*) @nogc nothrow;

    struct pdf_layer_config_ui
    {

        const(char)* text;

        int depth;

        pdf_layer_config_ui_type type;

        int selected;

        int locked;
    }

    enum _Anonymous_14
    {

        PDF_LAYER_UI_LABEL = 0,

        PDF_LAYER_UI_CHECKBOX = 1,

        PDF_LAYER_UI_RADIOBOX = 2,
    }
    enum PDF_LAYER_UI_LABEL = _Anonymous_14.PDF_LAYER_UI_LABEL;
    enum PDF_LAYER_UI_CHECKBOX = _Anonymous_14.PDF_LAYER_UI_CHECKBOX;
    enum PDF_LAYER_UI_RADIOBOX = _Anonymous_14.PDF_LAYER_UI_RADIOBOX;

    alias pdf_layer_config_ui_type = _Anonymous_14;

    void pdf_toggle_layer_config_ui(fz_context*, pdf_document*, int) @nogc nothrow;

    void pdf_deselect_layer_config_ui(fz_context*, pdf_document*, int) @nogc nothrow;

    void pdf_select_layer_config_ui(fz_context*, pdf_document*, int) @nogc nothrow;

    int pdf_count_layer_config_ui(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_select_layer_config(fz_context*, pdf_document*, int) @nogc nothrow;

    void pdf_layer_config_info(fz_context*, pdf_document*, int, pdf_layer_config*) @nogc nothrow;

    struct pdf_layer_config
    {

        const(char)* name;

        const(char)* creator;
    }

    void pdf_enable_layer(fz_context*, pdf_document*, int, int) @nogc nothrow;

    int pdf_layer_is_enabled(fz_context*, pdf_document*, int) @nogc nothrow;

    const(char)* pdf_layer_name(fz_context*, pdf_document*, int) @nogc nothrow;

    int pdf_count_layers(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_count_layer_configs(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_invalidate_xfa(fz_context*, pdf_document*) @nogc nothrow;

    fz_outline_iterator* pdf_new_outline_iterator(fz_context*, pdf_document*) @nogc nothrow;

    fz_outline* pdf_load_outline(fz_context*, pdf_document*) @nogc nothrow;

    int pdf_lookup_metadata(fz_context*, pdf_document*, const(char)*, char*, int) @nogc nothrow;

    int pdf_has_permission(fz_context*, pdf_document*, fz_permission) @nogc nothrow;

    int pdf_authenticate_password(fz_context*, pdf_document*, const(char)*) @nogc nothrow;

    int pdf_needs_password(fz_context*, pdf_document*) @nogc nothrow;

    pdf_page* pdf_page_from_fz_page(fz_context*, fz_page*) @nogc nothrow;

    pdf_document* pdf_document_from_fz_document(fz_context*, fz_document*) @nogc nothrow;

    pdf_document* pdf_specifics(fz_context*, fz_document*) @nogc nothrow;

    pdf_document* pdf_keep_document(fz_context*, pdf_document*) @nogc nothrow;

    void pdf_drop_document(fz_context*, pdf_document*) @nogc nothrow;

    pdf_document* pdf_open_document_with_stream(fz_context*, fz_stream*) @nogc nothrow;

    pdf_document* pdf_open_document(fz_context*, const(char)*) @nogc nothrow;

    void pdf_js_set_console(fz_context*, pdf_document*, pdf_js_console*, void*) @nogc nothrow;

    pdf_js_console* pdf_js_get_console(fz_context*, pdf_document*) @nogc nothrow;
    alias pdf_js_console_write_cb = void function(void*, const(char)*);
    alias pdf_js_console_clear_cb = void function(void*);
    alias pdf_js_console_hide_cb = void function(void*);
    alias pdf_js_console_show_cb = void function(void*);
    alias pdf_js_console_drop_cb = void function(pdf_js_console*, void*);

    struct pdf_js_console
    {

        void function(pdf_js_console*, void*) drop;

        void function(void*) show;

        void function(void*) hide;

        void function(void*) clear;

        void function(void*, const(char)*) write;
    }
    alias pdf_free_doc_event_data_cb = void function(fz_context*, void*);
    alias pdf_doc_event_cb = void function(fz_context*, pdf_document*, pdf_doc_event*, void*);

    struct pdf_doc_event
    {

        int type;
    }

    struct pdf_lexbuf_large
    {

        pdf_lexbuf base;

        char[65280] buffer;
    }

    struct pdf_lexbuf
    {

        ulong size;

        ulong base_size;

        ulong len;

        long i;

        float f;

        char* scratch;

        char[256] buffer;
    }

    enum _Anonymous_15
    {

        PDF_LEXBUF_SMALL = 256,

        PDF_LEXBUF_LARGE = 65536,
    }
    enum PDF_LEXBUF_SMALL = _Anonymous_15.PDF_LEXBUF_SMALL;
    enum PDF_LEXBUF_LARGE = _Anonymous_15.PDF_LEXBUF_LARGE;
    struct pdf_js;
    struct pdf_annot;

    struct pdf_page
    {

        fz_page super_;

        pdf_document* doc;

        pdf_obj* obj;

        int transparency;

        int overprint;

        fz_link* links;

        pdf_annot* annots;

        pdf_annot** annot_tailp;

        pdf_annot* widgets;

        pdf_annot** widget_tailp;
    }
    struct pdf_ocg_descriptor;

    struct pdf_xref
    {

        int num_objects;

        pdf_xref_subsec* subsec;

        pdf_obj* trailer;

        pdf_obj* pre_repair_trailer;

        pdf_unsaved_sig* unsaved_sigs;

        pdf_unsaved_sig** unsaved_sigs_end;

        long end_ofs;
    }

    ulong pdf_encrypted_len(fz_context*, pdf_crypt*, int, int, ulong) @nogc nothrow;

    void pdf_encrypt_data(fz_context*, pdf_crypt*, int, int, void function(fz_context*, void*, const(ubyte)*, ulong), void*, const(ubyte)*, ulong) @nogc nothrow;

    ulong pdf_signature_contents(fz_context*, pdf_document*, pdf_obj*, char**) @nogc nothrow;

    int pdf_signature_incremental_change_since_signing(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    fz_stream* pdf_signature_hash_bytes(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    int pdf_signature_byte_range(fz_context*, pdf_document*, pdf_obj*, fz_range*) @nogc nothrow;

    int pdf_document_permissions(fz_context*, pdf_document*) @nogc nothrow;

    enum _Anonymous_16
    {

        PDF_PERM_PRINT = 4,

        PDF_PERM_MODIFY = 8,

        PDF_PERM_COPY = 16,

        PDF_PERM_ANNOTATE = 32,

        PDF_PERM_FORM = 256,

        PDF_PERM_ACCESSIBILITY = 512,

        PDF_PERM_ASSEMBLE = 1024,

        PDF_PERM_PRINT_HQ = 2048,
    }
    enum PDF_PERM_PRINT = _Anonymous_16.PDF_PERM_PRINT;
    enum PDF_PERM_MODIFY = _Anonymous_16.PDF_PERM_MODIFY;
    enum PDF_PERM_COPY = _Anonymous_16.PDF_PERM_COPY;
    enum PDF_PERM_ANNOTATE = _Anonymous_16.PDF_PERM_ANNOTATE;
    enum PDF_PERM_FORM = _Anonymous_16.PDF_PERM_FORM;
    enum PDF_PERM_ACCESSIBILITY = _Anonymous_16.PDF_PERM_ACCESSIBILITY;
    enum PDF_PERM_ASSEMBLE = _Anonymous_16.PDF_PERM_ASSEMBLE;
    enum PDF_PERM_PRINT_HQ = _Anonymous_16.PDF_PERM_PRINT_HQ;

    void pdf_write_digest(fz_context*, fz_output*, pdf_obj*, pdf_obj*, ulong, ulong, pdf_pkcs7_signer*) @nogc nothrow;

    void pdf_print_crypt(fz_context*, fz_output*, pdf_crypt*) @nogc nothrow;

    ubyte* pdf_crypt_key(fz_context*, pdf_crypt*) @nogc nothrow;

    ubyte* pdf_crypt_permissions_encryption(fz_context*, pdf_crypt*) @nogc nothrow;

    ubyte* pdf_crypt_user_encryption(fz_context*, pdf_crypt*) @nogc nothrow;

    ubyte* pdf_crypt_owner_encryption(fz_context*, pdf_crypt*) @nogc nothrow;

    ubyte* pdf_crypt_user_password(fz_context*, pdf_crypt*) @nogc nothrow;

    ubyte* pdf_crypt_owner_password(fz_context*, pdf_crypt*) @nogc nothrow;

    int pdf_crypt_encrypt_metadata(fz_context*, pdf_crypt*) @nogc nothrow;

    int pdf_crypt_permissions(fz_context*, pdf_crypt*) @nogc nothrow;

    int pdf_crypt_length(fz_context*, pdf_crypt*) @nogc nothrow;

    char* pdf_crypt_method(fz_context*, pdf_crypt*) @nogc nothrow;

    int pdf_crypt_revision(fz_context*, pdf_crypt*) @nogc nothrow;

    int pdf_crypt_version(fz_context*, pdf_crypt*) @nogc nothrow;

    fz_stream* pdf_open_crypt_with_filter(fz_context*, fz_stream*, pdf_crypt*, pdf_obj*, int, int) @nogc nothrow;

    fz_stream* pdf_open_crypt(fz_context*, fz_stream*, pdf_crypt*, int, int) @nogc nothrow;

    void pdf_crypt_obj(fz_context*, pdf_crypt*, pdf_obj*, int, int) @nogc nothrow;

    void pdf_drop_crypt(fz_context*, pdf_crypt*) @nogc nothrow;

    pdf_crypt* pdf_new_encrypt(fz_context*, const(char)*, const(char)*, pdf_obj*, int, int) @nogc nothrow;

    pdf_crypt* pdf_new_crypt(fz_context*, pdf_obj*, pdf_obj*) @nogc nothrow;

    enum _Anonymous_17
    {

        PDF_ENCRYPT_KEEP = 0,

        PDF_ENCRYPT_NONE = 1,

        PDF_ENCRYPT_RC4_40 = 2,

        PDF_ENCRYPT_RC4_128 = 3,

        PDF_ENCRYPT_AES_128 = 4,

        PDF_ENCRYPT_AES_256 = 5,

        PDF_ENCRYPT_UNKNOWN = 6,
    }
    enum PDF_ENCRYPT_KEEP = _Anonymous_17.PDF_ENCRYPT_KEEP;
    enum PDF_ENCRYPT_NONE = _Anonymous_17.PDF_ENCRYPT_NONE;
    enum PDF_ENCRYPT_RC4_40 = _Anonymous_17.PDF_ENCRYPT_RC4_40;
    enum PDF_ENCRYPT_RC4_128 = _Anonymous_17.PDF_ENCRYPT_RC4_128;
    enum PDF_ENCRYPT_AES_128 = _Anonymous_17.PDF_ENCRYPT_AES_128;
    enum PDF_ENCRYPT_AES_256 = _Anonymous_17.PDF_ENCRYPT_AES_256;
    enum PDF_ENCRYPT_UNKNOWN = _Anonymous_17.PDF_ENCRYPT_UNKNOWN;

    pdf_cmap* pdf_load_embedded_cmap(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    pdf_cmap* pdf_load_builtin_cmap(fz_context*, const(char)*) @nogc nothrow;

    pdf_cmap* pdf_load_system_cmap(fz_context*, const(char)*) @nogc nothrow;

    pdf_cmap* pdf_load_cmap(fz_context*, fz_stream*) @nogc nothrow;

    pdf_cmap* pdf_new_identity_cmap(fz_context*, int, int) @nogc nothrow;

    int pdf_decode_cmap(pdf_cmap*, ubyte*, ubyte*, uint*) @nogc nothrow;

    int pdf_lookup_cmap_full(pdf_cmap*, uint, int*) @nogc nothrow;

    int pdf_lookup_cmap(pdf_cmap*, uint) @nogc nothrow;

    void pdf_sort_cmap(fz_context*, pdf_cmap*) @nogc nothrow;

    void pdf_map_one_to_many(fz_context*, pdf_cmap*, uint, int*, ulong) @nogc nothrow;

    void pdf_map_range_to_range(fz_context*, pdf_cmap*, uint, uint, int) @nogc nothrow;

    void pdf_add_codespace(fz_context*, pdf_cmap*, uint, uint, ulong) @nogc nothrow;

    void pdf_set_usecmap(fz_context*, pdf_cmap*, pdf_cmap*) @nogc nothrow;

    void pdf_set_cmap_wmode(fz_context*, pdf_cmap*, int) @nogc nothrow;

    int pdf_cmap_wmode(fz_context*, pdf_cmap*) @nogc nothrow;

    ulong pdf_cmap_size(fz_context*, pdf_cmap*) @nogc nothrow;

    void pdf_drop_cmap_imp(fz_context*, fz_storable*) @nogc nothrow;

    void pdf_drop_cmap(fz_context*, pdf_cmap*) @nogc nothrow;

    pdf_cmap* pdf_keep_cmap(fz_context*, pdf_cmap*) @nogc nothrow;

    pdf_cmap* pdf_new_cmap(fz_context*) @nogc nothrow;

    struct pdf_cmap
    {

        fz_storable storable;

        char[32] cmap_name;

        char[32] usecmap_name;

        pdf_cmap* usecmap;

        int wmode;

        int codespace_len;

        static struct _Anonymous_18
        {

            int n;

            uint low;

            uint high;
        }

        _Anonymous_18[40] codespace;

        int rlen;

        int rcap;

        pdf_range* ranges;

        int xlen;

        int xcap;

        pdf_xrange* xranges;

        int mlen;

        int mcap;

        pdf_mrange* mranges;

        int dlen;

        int dcap;

        int* dict;

        int tlen;

        int tcap;

        int ttop;

        cmap_splay* tree;
    }
    struct cmap_splay;

    struct pdf_mrange
    {

        uint low;

        uint out_;
    }

    struct pdf_xrange
    {

        uint low;

        uint high;

        uint out_;
    }

    struct pdf_range
    {

        ushort low;

        ushort high;

        ushort out_;
    }

    void pdf_clean_file(fz_context*, char*, char*, char*, pdf_write_options*, int, char**) @nogc nothrow;

    void pdf_set_annot_filespec(fz_context*, pdf_annot*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_annot_filespec(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_has_filespec(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_appearance_from_display_list(fz_context*, pdf_annot*, const(char)*, const(char)*, fz_matrix, fz_display_list*) @nogc nothrow;

    void pdf_set_annot_appearance(fz_context*, pdf_annot*, const(char)*, const(char)*, fz_matrix, fz_rect, pdf_obj*, fz_buffer*) @nogc nothrow;

    void pdf_set_annot_hot(fz_context*, pdf_annot*, int) @nogc nothrow;

    int pdf_annot_hot(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_active(fz_context*, pdf_annot*, int) @nogc nothrow;

    int pdf_annot_active(fz_context*, pdf_annot*) @nogc nothrow;

    pdf_obj* pdf_annot_ap(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_MK_BC_rgb(fz_context*, pdf_annot*, float*) @nogc nothrow;

    int pdf_annot_MK_BG_rgb(fz_context*, pdf_annot*, float*) @nogc nothrow;

    void pdf_annot_MK_BC(fz_context*, pdf_annot*, int*, float*) @nogc nothrow;

    void pdf_annot_MK_BG(fz_context*, pdf_annot*, int*, float*) @nogc nothrow;

    fz_link* pdf_load_link_annots(fz_context*, pdf_document*, pdf_page*, pdf_obj*, int, fz_matrix) @nogc nothrow;

    pdf_obj* pdf_lookup_dest(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    char* pdf_parse_link_action(fz_context*, pdf_document*, pdf_obj*, int) @nogc nothrow;

    char* pdf_parse_link_dest(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    int pdf_verify_embedded_file_checksum(fz_context*, pdf_obj*) @nogc nothrow;

    fz_buffer* pdf_load_embedded_file_contents(fz_context*, pdf_obj*) @nogc nothrow;

    void pdf_get_embedded_file_params(fz_context*, pdf_obj*, pdf_embedded_file_params*) @nogc nothrow;

    pdf_obj* pdf_add_embedded_file(fz_context*, pdf_document*, const(char)*, const(char)*, fz_buffer*, long, long, int) @nogc nothrow;

    int pdf_is_embedded_file(fz_context*, pdf_obj*) @nogc nothrow;

    struct pdf_embedded_file_params
    {

        const(char)* filename;

        const(char)* mimetype;

        int size;

        long created;

        long modified;
    }

    fz_layout_block* pdf_layout_text_widget(fz_context*, pdf_annot*) @nogc nothrow;

    fz_stext_page* pdf_new_stext_page_from_annot(fz_context*, pdf_annot*, const(fz_stext_options)*) @nogc nothrow;

    fz_pixmap* pdf_new_pixmap_from_annot(fz_context*, pdf_annot*, fz_matrix, fz_colorspace*, fz_separations*, int) @nogc nothrow;

    fz_display_list* pdf_new_display_list_from_annot(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_toggle_widget(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_get_widget_editing_state(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_widget_editing_state(fz_context*, pdf_annot*, int) @nogc nothrow;

    int pdf_update_page(fz_context*, pdf_page*) @nogc nothrow;

    int pdf_update_annot(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_pop_and_discard_local_xref(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_ensure_local_xref(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_pop_local_xref(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_push_local_xref(fz_context*, pdf_annot*) @nogc nothrow;

    fz_text* pdf_layout_fit_text(fz_context*, fz_font*, fz_text_language, const(char)*, fz_rect) @nogc nothrow;

    int pdf_set_annot_field_value(fz_context*, pdf_document*, pdf_annot*, const(char)*, int) @nogc nothrow;

    const(char)* pdf_annot_field_label(fz_context*, pdf_annot*) @nogc nothrow;

    const(char)* pdf_annot_field_value(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_field_flags(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_dirty_annot(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_resynthesised(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_needs_resynthesis(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_request_resynthesis(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_default_appearance(fz_context*, pdf_annot*, const(char)*, float, int, const(float)*) @nogc nothrow;

    void pdf_annot_default_appearance(fz_context*, pdf_annot*, const(char)**, float*, int*, float*) @nogc nothrow;

    void pdf_print_default_appearance(fz_context*, char*, int, const(char)*, float, int, const(float)*) @nogc nothrow;

    void pdf_parse_default_appearance(fz_context*, const(char)*, const(char)**, float*, int*, float*) @nogc nothrow;

    void pdf_set_annot_creation_date(fz_context*, pdf_annot*, long) @nogc nothrow;

    long pdf_annot_creation_date(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_modification_date(fz_context*, pdf_annot*, long) @nogc nothrow;

    long pdf_annot_modification_date(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_author(fz_context*, pdf_annot*, const(char)*) @nogc nothrow;

    const(char)* pdf_annot_author(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_contents(fz_context*, pdf_annot*, const(char)*) @nogc nothrow;

    const(char)* pdf_annot_contents(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_vertex(fz_context*, pdf_annot*, int, fz_point) @nogc nothrow;

    void pdf_add_annot_vertex(fz_context*, pdf_annot*, fz_point) @nogc nothrow;

    void pdf_clear_annot_vertices(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_vertices(fz_context*, pdf_annot*, int, const(fz_point)*) @nogc nothrow;

    fz_point pdf_annot_vertex(fz_context*, pdf_annot*, int) @nogc nothrow;

    int pdf_annot_vertex_count(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_line(fz_context*, pdf_annot*, fz_point, fz_point) @nogc nothrow;

    void pdf_annot_line(fz_context*, pdf_annot*, fz_point*, fz_point*) @nogc nothrow;

    int pdf_annot_is_standard_stamp(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_is_open(fz_context*, pdf_annot*) @nogc nothrow;

    const(char)* pdf_annot_icon_name(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_line_ending_styles(fz_context*, pdf_annot*, pdf_line_ending, pdf_line_ending) @nogc nothrow;

    void pdf_set_annot_line_end_style(fz_context*, pdf_annot*, pdf_line_ending) @nogc nothrow;

    void pdf_set_annot_line_start_style(fz_context*, pdf_annot*, pdf_line_ending) @nogc nothrow;

    void pdf_annot_line_ending_styles(fz_context*, pdf_annot*, pdf_line_ending*, pdf_line_ending*) @nogc nothrow;

    pdf_line_ending pdf_annot_line_end_style(fz_context*, pdf_annot*) @nogc nothrow;

    pdf_line_ending pdf_annot_line_start_style(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_is_open(fz_context*, pdf_annot*, int) @nogc nothrow;

    void pdf_set_annot_icon_name(fz_context*, pdf_annot*, const(char)*) @nogc nothrow;

    void pdf_add_annot_ink_list(fz_context*, pdf_annot*, int, fz_point*) @nogc nothrow;

    void pdf_add_annot_ink_list_stroke_vertex(fz_context*, pdf_annot*, fz_point) @nogc nothrow;

    void pdf_add_annot_ink_list_stroke(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_clear_annot_ink_list(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_ink_list(fz_context*, pdf_annot*, int, const(int)*, const(fz_point)*) @nogc nothrow;

    void pdf_add_annot_quad_point(fz_context*, pdf_annot*, fz_quad) @nogc nothrow;

    void pdf_clear_annot_quad_points(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_quad_points(fz_context*, pdf_annot*, int, const(fz_quad)*) @nogc nothrow;

    void pdf_set_annot_language(fz_context*, pdf_annot*, fz_text_language) @nogc nothrow;

    void pdf_set_annot_quadding(fz_context*, pdf_annot*, int) @nogc nothrow;

    void pdf_set_annot_interior_color(fz_context*, pdf_annot*, int, const(float)*) @nogc nothrow;

    void pdf_set_annot_color(fz_context*, pdf_annot*, int, const(float)*) @nogc nothrow;

    void pdf_set_annot_opacity(fz_context*, pdf_annot*, float) @nogc nothrow;

    void pdf_set_annot_border(fz_context*, pdf_annot*, float) @nogc nothrow;

    void pdf_set_annot_rect(fz_context*, pdf_annot*, fz_rect) @nogc nothrow;

    void pdf_set_annot_stamp_image(fz_context*, pdf_annot*, fz_image*) @nogc nothrow;

    void pdf_set_annot_flags(fz_context*, pdf_annot*, int) @nogc nothrow;

    fz_point pdf_annot_ink_list_stroke_vertex(fz_context*, pdf_annot*, int, int) @nogc nothrow;

    int pdf_annot_ink_list_stroke_count(fz_context*, pdf_annot*, int) @nogc nothrow;

    int pdf_annot_ink_list_count(fz_context*, pdf_annot*) @nogc nothrow;

    fz_quad pdf_annot_quad_point(fz_context*, pdf_annot*, int) @nogc nothrow;

    int pdf_annot_quad_point_count(fz_context*, pdf_annot*) @nogc nothrow;

    fz_text_language pdf_annot_language(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_quadding(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_annot_interior_color(fz_context*, pdf_annot*, int*, float*) @nogc nothrow;

    void pdf_annot_color(fz_context*, pdf_annot*, int*, float*) @nogc nothrow;

    float pdf_annot_opacity(fz_context*, pdf_annot*) @nogc nothrow;

    float pdf_annot_border(fz_context*, pdf_annot*) @nogc nothrow;

    fz_rect pdf_annot_rect(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_flags(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_has_author(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_has_open(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_has_icon_name(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_has_line_ending_styles(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_has_interior_color(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_has_line(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_has_vertices(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_has_quad_points(fz_context*, pdf_annot*) @nogc nothrow;

    int pdf_annot_has_ink_list(fz_context*, pdf_annot*) @nogc nothrow;

    fz_rect pdf_annot_popup(fz_context*, pdf_annot*) @nogc nothrow;

    void pdf_set_annot_popup(fz_context*, pdf_annot*, fz_rect) @nogc nothrow;

    void pdf_delete_annot(fz_context*, pdf_page*, pdf_annot*) @nogc nothrow;

    pdf_annot* pdf_create_annot(fz_context*, pdf_page*, pdf_annot_type) @nogc nothrow;

    void pdf_delete_link(fz_context*, pdf_page*, fz_link*) @nogc nothrow;

    fz_link* pdf_create_link(fz_context*, pdf_page*, fz_rect, const(char)*) @nogc nothrow;

    pdf_annot* pdf_create_annot_raw(fz_context*, pdf_page*, pdf_annot_type) @nogc nothrow;

    fz_link* pdf_new_link(fz_context*, pdf_page*, fz_rect, const(char)*, pdf_obj*) @nogc nothrow;

    fz_matrix pdf_annot_transform(fz_context*, pdf_annot*) @nogc nothrow;

    fz_link_dest pdf_parse_link_uri(fz_context*, const(char)*) @nogc nothrow;

    char* pdf_format_link_uri(fz_context*, fz_link_dest) @nogc nothrow;

    pdf_obj* pdf_new_action_from_link(fz_context*, pdf_document*, const(char)*) @nogc nothrow;

    pdf_obj* pdf_new_destination_from_link(fz_context*, pdf_document*, const(char)*) @nogc nothrow;

    fz_link_dest pdf_resolve_link_dest(fz_context*, pdf_document*, const(char)*) @nogc nothrow;

    int pdf_resolve_link(fz_context*, pdf_document*, const(char)*, float*, float*) @nogc nothrow;

    void pdf_walk_tree(fz_context*, pdf_obj*, pdf_obj*, void function(fz_context*, pdf_obj*, void*, pdf_obj**), void function(fz_context*, pdf_obj*, void*), void*, pdf_obj**, pdf_obj**) @nogc nothrow;

    pdf_obj* pdf_lookup_number(fz_context*, pdf_obj*, int) @nogc nothrow;

    pdf_obj* pdf_load_name_tree(fz_context*, pdf_document*, pdf_obj*) @nogc nothrow;

    pdf_obj* pdf_lookup_name(fz_context*, pdf_document*, pdf_obj*, pdf_obj*) @nogc nothrow;

    void pdf_run_annot(fz_context*, pdf_annot*, fz_device*, fz_matrix, fz_cookie*) @nogc nothrow;
    pragma(mangle, "pdf_annot_type")
    pdf_annot_type pdf_annot_type_(fz_context*, pdf_annot*) @nogc nothrow;

    fz_rect pdf_bound_annot(fz_context*, pdf_annot*) @nogc nothrow;

    pdf_page* pdf_annot_page(fz_context*, pdf_annot*) @nogc nothrow;

    pdf_obj* pdf_annot_obj(fz_context*, pdf_annot*) @nogc nothrow;

    pdf_annot* pdf_next_annot(fz_context*, pdf_annot*) @nogc nothrow;

    pdf_annot* pdf_first_annot(fz_context*, pdf_page*) @nogc nothrow;

    void pdf_drop_annot(fz_context*, pdf_annot*) @nogc nothrow;

    pdf_annot* pdf_keep_annot(fz_context*, pdf_annot*) @nogc nothrow;

    const(char)* pdf_string_from_line_ending(fz_context*, pdf_line_ending) @nogc nothrow;

    alias SETJMP_FLOAT128 = _SETJMP_FLOAT128;

    struct _SETJMP_FLOAT128
    {

        ulong[2] Part;
    }

    pdf_obj* pdf_name_from_line_ending(fz_context*, pdf_line_ending) @nogc nothrow;

    alias _JBTYPE = _SETJMP_FLOAT128;

    struct _JUMP_BUFFER
    {

        ulong Frame;

        ulong Rbx;

        ulong Rsp;

        ulong Rbp;

        ulong Rsi;

        ulong Rdi;

        ulong R12;

        ulong R13;

        ulong R14;

        ulong R15;

        ulong Rip;

        c_ulong MxCsr;

        ushort FpCsr;

        ushort Spare;

        _SETJMP_FLOAT128 Xmm6;

        _SETJMP_FLOAT128 Xmm7;

        _SETJMP_FLOAT128 Xmm8;

        _SETJMP_FLOAT128 Xmm9;

        _SETJMP_FLOAT128 Xmm10;

        _SETJMP_FLOAT128 Xmm11;

        _SETJMP_FLOAT128 Xmm12;

        _SETJMP_FLOAT128 Xmm13;

        _SETJMP_FLOAT128 Xmm14;

        _SETJMP_FLOAT128 Xmm15;
    }

    pdf_line_ending pdf_line_ending_from_string(fz_context*, const(char)*) @nogc nothrow;

    alias jmp_buf = _SETJMP_FLOAT128[16];

    pdf_line_ending pdf_line_ending_from_name(fz_context*, pdf_obj*) @nogc nothrow;

    int _setjmp(_SETJMP_FLOAT128*) @nogc nothrow;

    void longjmp(_SETJMP_FLOAT128*, int) @nogc nothrow;

    enum _Anonymous_19
    {

        PDF_ANNOT_Q_LEFT = 0,

        PDF_ANNOT_Q_CENTER = 1,

        PDF_ANNOT_Q_RIGHT = 2,
    }
    enum PDF_ANNOT_Q_LEFT = _Anonymous_19.PDF_ANNOT_Q_LEFT;
    enum PDF_ANNOT_Q_CENTER = _Anonymous_19.PDF_ANNOT_Q_CENTER;
    enum PDF_ANNOT_Q_RIGHT = _Anonymous_19.PDF_ANNOT_Q_RIGHT;

    alias int8_t = byte;

    alias int16_t = short;

    alias int32_t = int;

    alias int64_t = long;

    alias uint8_t = ubyte;

    alias uint16_t = ushort;

    alias uint32_t = uint;

    alias uint64_t = ulong;

    alias int_least8_t = byte;

    alias int_least16_t = short;

    alias int_least32_t = int;

    alias int_least64_t = long;

    alias uint_least8_t = ubyte;

    alias uint_least16_t = ushort;

    alias uint_least32_t = uint;

    alias uint_least64_t = ulong;

    alias int_fast8_t = byte;

    alias int_fast16_t = int;

    alias int_fast32_t = int;

    alias int_fast64_t = long;

    alias uint_fast8_t = ubyte;

    alias uint_fast16_t = uint;

    alias uint_fast32_t = uint;

    alias uint_fast64_t = ulong;

    alias intmax_t = long;

    alias uintmax_t = ulong;

    enum pdf_line_ending
    {

        PDF_ANNOT_LE_NONE = 0,

        PDF_ANNOT_LE_SQUARE = 1,

        PDF_ANNOT_LE_CIRCLE = 2,

        PDF_ANNOT_LE_DIAMOND = 3,

        PDF_ANNOT_LE_OPEN_ARROW = 4,

        PDF_ANNOT_LE_CLOSED_ARROW = 5,

        PDF_ANNOT_LE_BUTT = 6,

        PDF_ANNOT_LE_R_OPEN_ARROW = 7,

        PDF_ANNOT_LE_R_CLOSED_ARROW = 8,

        PDF_ANNOT_LE_SLASH = 9,
    }
    enum PDF_ANNOT_LE_NONE = pdf_line_ending.PDF_ANNOT_LE_NONE;
    enum PDF_ANNOT_LE_SQUARE = pdf_line_ending.PDF_ANNOT_LE_SQUARE;
    enum PDF_ANNOT_LE_CIRCLE = pdf_line_ending.PDF_ANNOT_LE_CIRCLE;
    enum PDF_ANNOT_LE_DIAMOND = pdf_line_ending.PDF_ANNOT_LE_DIAMOND;
    enum PDF_ANNOT_LE_OPEN_ARROW = pdf_line_ending.PDF_ANNOT_LE_OPEN_ARROW;
    enum PDF_ANNOT_LE_CLOSED_ARROW = pdf_line_ending.PDF_ANNOT_LE_CLOSED_ARROW;
    enum PDF_ANNOT_LE_BUTT = pdf_line_ending.PDF_ANNOT_LE_BUTT;
    enum PDF_ANNOT_LE_R_OPEN_ARROW = pdf_line_ending.PDF_ANNOT_LE_R_OPEN_ARROW;
    enum PDF_ANNOT_LE_R_CLOSED_ARROW = pdf_line_ending.PDF_ANNOT_LE_R_CLOSED_ARROW;
    enum PDF_ANNOT_LE_SLASH = pdf_line_ending.PDF_ANNOT_LE_SLASH;

    enum _Anonymous_20
    {

        PDF_ANNOT_IS_INVISIBLE = 1,

        PDF_ANNOT_IS_HIDDEN = 2,

        PDF_ANNOT_IS_PRINT = 4,

        PDF_ANNOT_IS_NO_ZOOM = 8,

        PDF_ANNOT_IS_NO_ROTATE = 16,

        PDF_ANNOT_IS_NO_VIEW = 32,

        PDF_ANNOT_IS_READ_ONLY = 64,

        PDF_ANNOT_IS_LOCKED = 128,

        PDF_ANNOT_IS_TOGGLE_NO_VIEW = 256,

        PDF_ANNOT_IS_LOCKED_CONTENTS = 512,
    }
    enum PDF_ANNOT_IS_INVISIBLE = _Anonymous_20.PDF_ANNOT_IS_INVISIBLE;
    enum PDF_ANNOT_IS_HIDDEN = _Anonymous_20.PDF_ANNOT_IS_HIDDEN;
    enum PDF_ANNOT_IS_PRINT = _Anonymous_20.PDF_ANNOT_IS_PRINT;
    enum PDF_ANNOT_IS_NO_ZOOM = _Anonymous_20.PDF_ANNOT_IS_NO_ZOOM;
    enum PDF_ANNOT_IS_NO_ROTATE = _Anonymous_20.PDF_ANNOT_IS_NO_ROTATE;
    enum PDF_ANNOT_IS_NO_VIEW = _Anonymous_20.PDF_ANNOT_IS_NO_VIEW;
    enum PDF_ANNOT_IS_READ_ONLY = _Anonymous_20.PDF_ANNOT_IS_READ_ONLY;
    enum PDF_ANNOT_IS_LOCKED = _Anonymous_20.PDF_ANNOT_IS_LOCKED;
    enum PDF_ANNOT_IS_TOGGLE_NO_VIEW = _Anonymous_20.PDF_ANNOT_IS_TOGGLE_NO_VIEW;
    enum PDF_ANNOT_IS_LOCKED_CONTENTS = _Anonymous_20.PDF_ANNOT_IS_LOCKED_CONTENTS;

    pdf_annot_type pdf_annot_type_from_string(fz_context*, const(char)*) @nogc nothrow;

    const(char)* pdf_string_from_annot_type(fz_context*, pdf_annot_type) @nogc nothrow;

    enum pdf_annot_type
    {

        PDF_ANNOT_TEXT = 0,

        PDF_ANNOT_LINK = 1,

        PDF_ANNOT_FREE_TEXT = 2,

        PDF_ANNOT_LINE = 3,

        PDF_ANNOT_SQUARE = 4,

        PDF_ANNOT_CIRCLE = 5,

        PDF_ANNOT_POLYGON = 6,

        PDF_ANNOT_POLY_LINE = 7,

        PDF_ANNOT_HIGHLIGHT = 8,

        PDF_ANNOT_UNDERLINE = 9,

        PDF_ANNOT_SQUIGGLY = 10,

        PDF_ANNOT_STRIKE_OUT = 11,

        PDF_ANNOT_REDACT = 12,

        PDF_ANNOT_STAMP = 13,

        PDF_ANNOT_CARET = 14,

        PDF_ANNOT_INK = 15,

        PDF_ANNOT_POPUP = 16,

        PDF_ANNOT_FILE_ATTACHMENT = 17,

        PDF_ANNOT_SOUND = 18,

        PDF_ANNOT_MOVIE = 19,

        PDF_ANNOT_RICH_MEDIA = 20,

        PDF_ANNOT_WIDGET = 21,

        PDF_ANNOT_SCREEN = 22,

        PDF_ANNOT_PRINTER_MARK = 23,

        PDF_ANNOT_TRAP_NET = 24,

        PDF_ANNOT_WATERMARK = 25,

        PDF_ANNOT_3D = 26,

        PDF_ANNOT_PROJECTION = 27,

        PDF_ANNOT_UNKNOWN = -1,
    }
    enum PDF_ANNOT_TEXT = pdf_annot_type.PDF_ANNOT_TEXT;
    enum PDF_ANNOT_LINK = pdf_annot_type.PDF_ANNOT_LINK;
    enum PDF_ANNOT_FREE_TEXT = pdf_annot_type.PDF_ANNOT_FREE_TEXT;
    enum PDF_ANNOT_LINE = pdf_annot_type.PDF_ANNOT_LINE;
    enum PDF_ANNOT_SQUARE = pdf_annot_type.PDF_ANNOT_SQUARE;
    enum PDF_ANNOT_CIRCLE = pdf_annot_type.PDF_ANNOT_CIRCLE;
    enum PDF_ANNOT_POLYGON = pdf_annot_type.PDF_ANNOT_POLYGON;
    enum PDF_ANNOT_POLY_LINE = pdf_annot_type.PDF_ANNOT_POLY_LINE;
    enum PDF_ANNOT_HIGHLIGHT = pdf_annot_type.PDF_ANNOT_HIGHLIGHT;
    enum PDF_ANNOT_UNDERLINE = pdf_annot_type.PDF_ANNOT_UNDERLINE;
    enum PDF_ANNOT_SQUIGGLY = pdf_annot_type.PDF_ANNOT_SQUIGGLY;
    enum PDF_ANNOT_STRIKE_OUT = pdf_annot_type.PDF_ANNOT_STRIKE_OUT;
    enum PDF_ANNOT_REDACT = pdf_annot_type.PDF_ANNOT_REDACT;
    enum PDF_ANNOT_STAMP = pdf_annot_type.PDF_ANNOT_STAMP;
    enum PDF_ANNOT_CARET = pdf_annot_type.PDF_ANNOT_CARET;
    enum PDF_ANNOT_INK = pdf_annot_type.PDF_ANNOT_INK;
    enum PDF_ANNOT_POPUP = pdf_annot_type.PDF_ANNOT_POPUP;
    enum PDF_ANNOT_FILE_ATTACHMENT = pdf_annot_type.PDF_ANNOT_FILE_ATTACHMENT;
    enum PDF_ANNOT_SOUND = pdf_annot_type.PDF_ANNOT_SOUND;
    enum PDF_ANNOT_MOVIE = pdf_annot_type.PDF_ANNOT_MOVIE;
    enum PDF_ANNOT_RICH_MEDIA = pdf_annot_type.PDF_ANNOT_RICH_MEDIA;
    enum PDF_ANNOT_WIDGET = pdf_annot_type.PDF_ANNOT_WIDGET;
    enum PDF_ANNOT_SCREEN = pdf_annot_type.PDF_ANNOT_SCREEN;
    enum PDF_ANNOT_PRINTER_MARK = pdf_annot_type.PDF_ANNOT_PRINTER_MARK;
    enum PDF_ANNOT_TRAP_NET = pdf_annot_type.PDF_ANNOT_TRAP_NET;
    enum PDF_ANNOT_WATERMARK = pdf_annot_type.PDF_ANNOT_WATERMARK;
    enum PDF_ANNOT_3D = pdf_annot_type.PDF_ANNOT_3D;
    enum PDF_ANNOT_PROJECTION = pdf_annot_type.PDF_ANNOT_PROJECTION;
    enum PDF_ANNOT_UNKNOWN = pdf_annot_type.PDF_ANNOT_UNKNOWN;

    void Memento_cpp_delete_array(void*) @nogc nothrow;

    void* Memento_cpp_new_array(ulong) @nogc nothrow;

    void Memento_cpp_delete(void*) @nogc nothrow;

    void* Memento_cpp_new(ulong) @nogc nothrow;
    pragma(mangle, "Memento_bt")
    void Memento_bt_() @nogc nothrow;
    pragma(mangle, "Memento_fin")
    void Memento_fin_() @nogc nothrow;
    pragma(mangle, "Memento_squeezing")
    int Memento_squeezing_() @nogc nothrow;
    pragma(mangle, "Memento_sequence")
    int Memento_sequence_() @nogc nothrow;
    pragma(mangle, "Memento_stopLeaking")
    void Memento_stopLeaking_() @nogc nothrow;
    pragma(mangle, "Memento_startLeaking")
    void Memento_startLeaking_() @nogc nothrow;
    pragma(mangle, "Memento_checkIntPointerOrNull")
    int Memento_checkIntPointerOrNull_(void*) @nogc nothrow;
    pragma(mangle, "Memento_checkShortPointerOrNull")
    int Memento_checkShortPointerOrNull_(void*) @nogc nothrow;
    pragma(mangle, "Memento_checkBytePointerOrNull")
    int Memento_checkBytePointerOrNull_(void*) @nogc nothrow;
    pragma(mangle, "Memento_checkPointerOrNull")
    int Memento_checkPointerOrNull_(void*) @nogc nothrow;
    pragma(mangle, "Memento_reference")
    void* Memento_reference_(void*) @nogc nothrow;
    pragma(mangle, "Memento_adjustRef")
    void* Memento_adjustRef_(void*, int) @nogc nothrow;
    pragma(mangle, "Memento_dropRef")
    void* Memento_dropRef_(void*) @nogc nothrow;
    pragma(mangle, "Memento_takeRef")
    void* Memento_takeRef_(void*) @nogc nothrow;
    pragma(mangle, "Memento_dropIntRef")
    void* Memento_dropIntRef_(void*) @nogc nothrow;
    pragma(mangle, "Memento_takeIntRef")
    void* Memento_takeIntRef_(void*) @nogc nothrow;
    pragma(mangle, "Memento_dropShortRef")
    void* Memento_dropShortRef_(void*) @nogc nothrow;
    pragma(mangle, "Memento_takeShortRef")
    void* Memento_takeShortRef_(void*) @nogc nothrow;
    pragma(mangle, "Memento_dropByteRef")
    void* Memento_dropByteRef_(void*) @nogc nothrow;
    pragma(mangle, "Memento_takeByteRef")
    void* Memento_takeByteRef_(void*) @nogc nothrow;
    pragma(mangle, "Memento_blockInfo")
    void Memento_blockInfo_(void*) @nogc nothrow;
    pragma(mangle, "Memento_listBlockInfo")
    void Memento_listBlockInfo_() @nogc nothrow;
    pragma(mangle, "Memento_info")
    void Memento_info_(void*) @nogc nothrow;

    int Memento_vasprintf(char**, const(char)*, char*) @nogc nothrow;

    int Memento_asprintf(char**, const(char)*, ...) @nogc nothrow;

    char* Memento_strdup(const(char)*) @nogc nothrow;

    void* Memento_calloc(ulong, ulong) @nogc nothrow;

    void Memento_free(void*) @nogc nothrow;

    void* Memento_realloc(void*, ulong) @nogc nothrow;

    void* Memento_malloc(ulong) @nogc nothrow;
    pragma(mangle, "Memento_setIgnoreNewDelete")
    int Memento_setIgnoreNewDelete_(int) @nogc nothrow;
    pragma(mangle, "Memento_setVerbose")
    int Memento_setVerbose_(int) @nogc nothrow;
    pragma(mangle, "Memento_tick")
    void Memento_tick_() @nogc nothrow;
    pragma(mangle, "Memento_label")
    void* Memento_label_(void*, const(char)*) @nogc nothrow;
    pragma(mangle, "Memento_stats")
    void Memento_stats_() @nogc nothrow;
    pragma(mangle, "Memento_setMax")
    ulong Memento_setMax_(ulong) @nogc nothrow;
    pragma(mangle, "Memento_listNewBlocks")
    void Memento_listNewBlocks_() @nogc nothrow;
    pragma(mangle, "Memento_listBlocks")
    void Memento_listBlocks_() @nogc nothrow;
    pragma(mangle, "Memento_failThisEvent")
    int Memento_failThisEvent_() @nogc nothrow;

    alias uintptr_t = ulong;
    pragma(mangle, "Memento_failAt")
    int Memento_failAt_(int) @nogc nothrow;
    pragma(mangle, "Memento_breakpoint")
    void Memento_breakpoint_() @nogc nothrow;
    pragma(mangle, "Memento_find")
    int Memento_find_(void*) @nogc nothrow;
    pragma(mangle, "Memento_getBlockNum")
    int Memento_getBlockNum_(void*) @nogc nothrow;

    void __va_start(char**, ...) @nogc nothrow;
    pragma(mangle, "Memento_breakOnRealloc")
    void Memento_breakOnRealloc_(void*) @nogc nothrow;
    pragma(mangle, "Memento_breakOnFree")
    void Memento_breakOnFree_(void*) @nogc nothrow;
    pragma(mangle, "Memento_breakAt")
    int Memento_breakAt_(int) @nogc nothrow;
    pragma(mangle, "Memento_paranoidAt")
    int Memento_paranoidAt_(int) @nogc nothrow;
    pragma(mangle, "Memento_setParanoia")
    int Memento_setParanoia_(int) @nogc nothrow;
    pragma(mangle, "Memento_check")
    int Memento_check_() @nogc nothrow;
    pragma(mangle, "Memento_checkAllMemory")
    int Memento_checkAllMemory_() @nogc nothrow;
    pragma(mangle, "Memento_checkBlock")
    int Memento_checkBlock_(void*) @nogc nothrow;
    /**

	Enumerate through the attributes of an element.



	Call with i=0,1,2,3... to enumerate attributes.



	On return *att and the return value will be NULL if there are not

	that many attributes to read. Otherwise, *att will be filled in

	with a borrowed pointer to the attribute name, and the return

	value will be a borrowed pointer to the value.

*/
    const(char)* fz_dom_get_attribute(fz_context*, fz_xml*, int, const(char)**) @nogc nothrow;
    /**

	Retrieve the value of a given attribute from a given element.



	Returns a borrowed pointer to the value or NULL if not found.

*/
    const(char)* fz_dom_attribute(fz_context*, fz_xml*, const(char)*) @nogc nothrow;
    /**

	Remove an attribute from an element.

*/
    void fz_dom_remove_attribute(fz_context*, fz_xml*, const(char)*) @nogc nothrow;
    /**

	Add an attribute to an element.



	Ownership of att and value remain with the caller.

*/
    void fz_dom_add_attribute(fz_context*, fz_xml*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Return a borrowed reference to the previous sibling of a node,

	or NULL if there isn't one.

*/
    fz_xml* fz_dom_previous(fz_context*, fz_xml*) @nogc nothrow;
    /**

	Return a borrowed reference to the next sibling of a node,

	or NULL if there isn't one.

*/
    fz_xml* fz_dom_next(fz_context*, fz_xml*) @nogc nothrow;
    /**

	Return a borrowed reference to the parent of a node,

	or NULL if there isn't one.

*/
    fz_xml* fz_dom_parent(fz_context*, fz_xml*) @nogc nothrow;
    /**

	Return a borrowed reference to the first child of a node,

	or NULL if there isn't one.

*/
    fz_xml* fz_dom_first_child(fz_context*, fz_xml*) @nogc nothrow;
    /**

	Clone an element (and its children).



	A borrowed reference to the clone is returned. The clone is not

	yet linked into the DOM.

*/
    fz_xml* fz_dom_clone(fz_context*, fz_xml*) @nogc nothrow;
    /**

	Remove an element from the DOM. The element can be added back elsewhere

	if required.



	No reference counting changes for the element.

*/
    void fz_dom_remove(fz_context*, fz_xml*) @nogc nothrow;
    /**

	Insert an element (new_elt), after another element (node),

	unlinking the new_elt from its current position if required.

*/
    void fz_dom_insert_after(fz_context*, fz_xml*, fz_xml*) @nogc nothrow;
    /**

	Insert an element (new_elt), before another element (node),

	unlinking the new_elt from its current position if required.

*/
    void fz_dom_insert_before(fz_context*, fz_xml*, fz_xml*) @nogc nothrow;
    /**

	Insert an element as the last child of a parent, unlinking the

	child from its current position if required.

*/
    void fz_dom_append_child(fz_context*, fz_xml*, fz_xml*) @nogc nothrow;
    /**

	Find the next element matching the requirements.

*/
    fz_xml* fz_dom_find_next(fz_context*, fz_xml*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Find the first element matching the requirements in a depth first traversal from elt.



	The tagname must match tag, unless tag is NULL, when all tag names are considered to match.



	If att is NULL, then all tags match.

	Otherwise:

		If match is NULL, then only nodes that have an att attribute match.

		If match is non-NULL, then only nodes that have an att attribute that matches match match.



	Returns NULL (if no match found), or a borrowed reference to the first matching element.

*/
    fz_xml* fz_dom_find(fz_context*, fz_xml*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Create a text node for the given DOM.



	The element is not linked into the DOM yet.

*/
    fz_xml* fz_dom_create_text_node(fz_context*, fz_xml*, const(char)*) @nogc nothrow;
    /**

	Create an element of a given tag type for the given DOM.



	The element is not linked into the DOM yet.

*/
    fz_xml* fz_dom_create_element(fz_context*, fz_xml*, const(char)*) @nogc nothrow;
    /**

	Return a borrowed reference for the document (the top

	level element) of the DOM.

*/
    fz_xml* fz_dom_document_element(fz_context*, fz_xml*) @nogc nothrow;
    /**

	Return a borrowed reference for the 'body' element of

	the given DOM.

*/
    fz_xml* fz_dom_body(fz_context*, fz_xml*) @nogc nothrow;
    /**

	Perform a depth first search onwards from item, returning the first

	child that matches the given tag (or any tag if tag is NULL),

	with the given attribute (if att is non NULL), that matches

	match (if match is non NULL).

*/
    fz_xml* fz_xml_find_next_dfs(fz_xml*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Perform a depth first search from item, returning the first

	child that matches the given tag (or any tag if tag is NULL),

	with the given attribute (if att is non NULL), that matches

	match (if match is non NULL).

*/
    fz_xml* fz_xml_find_dfs(fz_xml*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Search the siblings of XML nodes starting with the first child

	of item looking for the first with the given tag (or any tag if

	tag is NULL), and with a matching attribute.



	Return NULL if none found.

*/
    fz_xml* fz_xml_find_down_match(fz_xml*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Search the siblings of XML nodes starting with the first sibling

	of item looking for the first with the given tag (or any tag if tag

	is NULL), and with a matching attribute.



	Return NULL if none found.

*/
    fz_xml* fz_xml_find_next_match(fz_xml*, const(char)*, const(char)*, const(char)*) @nogc nothrow;

    alias intptr_t = long;

    alias __vcrt_bool = bool;
    /**

	Search the siblings of XML nodes starting with item looking for

	the first with the given tag (or any tag if tag is NULL), and

	with a matching attribute.



	Return NULL if none found.

*/
    fz_xml* fz_xml_find_match(fz_xml*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Search the siblings of XML nodes starting with the first child

	of item looking for the first with the given tag.



	Return NULL if none found.

*/
    fz_xml* fz_xml_find_down(fz_xml*, const(char)*) @nogc nothrow;
    /**

	Search the siblings of XML nodes starting with the first sibling

	of item looking for the first with the given tag.



	Return NULL if none found.

*/
    fz_xml* fz_xml_find_next(fz_xml*, const(char)*) @nogc nothrow;
    /**

	Search the siblings of XML nodes starting with item looking for

	the first with the given tag.



	Return NULL if none found.

*/
    fz_xml* fz_xml_find(fz_xml*, const(char)*) @nogc nothrow;
    /**

	Pretty-print an XML tree to stdout.

*/
    void fz_debug_xml(fz_xml*, int) @nogc nothrow;
    /**

	Return the text content of an XML node.

	Return NULL if the node is a tag.

*/
    char* fz_xml_text(fz_xml*) @nogc nothrow;
    /**

	Add an attribute to an XML node.

*/
    void fz_xml_add_att(fz_context*, fz_pool*, fz_xml*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Check for a matching attribute on an XML node.



	If the node has the requested attribute (name), and the value

	matches (match) then return 1. Otherwise, 0.

*/
    int fz_xml_att_eq(fz_xml*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Return the value of an attribute of an XML node.

	If the first attribute doesn't exist, try the second.

	NULL if neither attribute exists.

*/
    char* fz_xml_att_alt(fz_xml*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Return the value of an attribute of an XML node.

	NULL if the attribute doesn't exist.

*/
    char* fz_xml_att(fz_xml*, const(char)*) @nogc nothrow;
    /**

	Return tag of XML node. Return NULL for text nodes.

*/
    char* fz_xml_tag(fz_xml*) @nogc nothrow;
    /**

	Return true if the tag name matches.

*/
    int fz_xml_is_tag(fz_xml*, const(char)*) @nogc nothrow;
    /**

	Return first child of XML node.

*/
    fz_xml* fz_xml_down(fz_xml*) @nogc nothrow;

    void __security_init_cookie() @nogc nothrow;

    void __security_check_cookie(ulong) @nogc nothrow;

    void __report_gsfailure(ulong) @nogc nothrow;

    extern __gshared ulong __security_cookie;
    /**

	Return parent of XML node.

*/
    fz_xml* fz_xml_up(fz_xml*) @nogc nothrow;
    /**

	Return next sibling of XML node.

*/
    fz_xml* fz_xml_next(fz_xml*) @nogc nothrow;
    /**

	Return previous sibling of XML node.

*/
    fz_xml* fz_xml_prev(fz_xml*) @nogc nothrow;

    void _wassert(const(ushort)*, const(ushort)*, uint) @nogc nothrow;
    /**

	Return the topmost XML node of a document.

*/
    fz_xml* fz_xml_root(fz_xml*) @nogc nothrow;
    /**

	Detach a node from the tree, unlinking it from its parent,

	and setting the document root to the node.

*/
    void fz_detach_xml(fz_context*, fz_xml*) @nogc nothrow;
    /**

	Drop a reference to the XML. When the last reference is

	dropped, the node and all its children and siblings will

	be freed.

*/
    void fz_drop_xml(fz_context*, fz_xml*) @nogc nothrow;
    /**

	Add a reference to the XML.

*/
    fz_xml* fz_keep_xml(fz_context*, fz_xml*) @nogc nothrow;
    /**

	Parse the contents of a buffer into a tree of XML nodes,

	using the HTML5 parsing algorithm.

*/
    fz_xml* fz_parse_xml_from_html5(fz_context*, fz_buffer*) @nogc nothrow;
    /**

	Parse the contents of buffer into a tree of xml nodes.



	preserve_white: whether to keep or delete all-whitespace nodes.

*/
    fz_xml* fz_parse_xml(fz_context*, fz_buffer*, int) @nogc nothrow;

    alias fz_xml_doc = fz_xml;
    struct fz_xml;
    /**

	Internal function to allocate a

	block for a derived document_writer structure, with the base

	structure's function pointers populated correctly, and the extra

	space zero initialised.

*/
    fz_document_writer* fz_new_document_writer_of_size(fz_context*, ulong, fz_device* function(fz_context*, fz_document_writer*, fz_rect), void function(fz_context*, fz_document_writer*, fz_device*), void function(fz_context*, fz_document_writer*), void function(fz_context*, fz_document_writer*)) @nogc nothrow;

    extern __gshared const(char)* fz_pdfocr_write_options_usage;

    extern __gshared const(char)* fz_pwg_write_options_usage;

    extern __gshared const(char)* fz_pclm_write_options_usage;

    alias __crt_bool = bool;

    extern __gshared const(char)* fz_pcl_write_options_usage;

    extern __gshared const(char)* fz_svg_write_options_usage;

    extern __gshared const(char)* fz_pdf_write_options_usage;

    fz_document_writer* fz_new_pixmap_writer(fz_context*, const(char)*, const(char)*, const(char)*, int, void function(fz_context*, fz_pixmap*, const(char)*)) @nogc nothrow;
    /**

	Called to discard a fz_document_writer.

	This may be called at any time during the process to release all

	the resources owned by the writer.



	Calling drop without having previously called close may leave

	the file in an inconsistent state.

*/
    void fz_drop_document_writer(fz_context*, fz_document_writer*) @nogc nothrow;
    /**

	Called to end the process of writing

	pages to a document.



	This writes any file level trailers required. After this

	completes successfully the file is up to date and complete.

*/
    void fz_close_document_writer(fz_context*, fz_document_writer*) @nogc nothrow;
    /**

	Convenience function to feed all the pages of a document to

	fz_begin_page/fz_run_page/fz_end_page.

*/
    void fz_write_document(fz_context*, fz_document_writer*, fz_document*) @nogc nothrow;
    /**

	Called to end the process of writing a page to a

	document.

*/
    void fz_end_page(fz_context*, fz_document_writer*) @nogc nothrow;
    /**

	Called to start the process of writing a page to

	a document.



	mediabox: page size rectangle in points.



	Returns a borrowed fz_device to write page contents to. This

	should be kept if required, and only dropped if it was kept.

*/
    fz_device* fz_begin_page(fz_context*, fz_document_writer*, fz_rect) @nogc nothrow;

    fz_document_writer* fz_new_pkm_pixmap_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    void _invalid_parameter_noinfo() @nogc nothrow;

    void _invalid_parameter_noinfo_noreturn() @nogc nothrow;

    void _invoke_watson(const(ushort)*, const(ushort)*, const(ushort)*, uint, ulong) @nogc nothrow;

    fz_document_writer* fz_new_pbm_pixmap_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_ppm_pixmap_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_pgm_pixmap_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_pnm_pixmap_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_pam_pixmap_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_png_pixmap_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    void fz_pdfocr_writer_set_progress(fz_context*, fz_document_writer*, int function(fz_context*, void*, int, int), void*) @nogc nothrow;

    fz_document_writer* fz_new_pdfocr_writer_with_output(fz_context*, fz_output*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_pdfocr_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;
    alias fz_pdfocr_progress_fn = int function(fz_context*, void*, int, int);

    fz_document_writer* fz_new_cbz_writer_with_output(fz_context*, fz_output*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_cbz_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_pwg_writer_with_output(fz_context*, fz_output*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_pwg_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_pclm_writer_with_output(fz_context*, fz_output*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_pclm_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_pcl_writer_with_output(fz_context*, fz_output*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_pcl_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    alias errno_t = int;

    alias wint_t = ushort;

    alias wctype_t = ushort;

    alias __time32_t = c_long;

    alias __time64_t = long;

    struct __crt_locale_data_public
    {

        const(ushort)* _locale_pctype;

        int _locale_mb_cur_max;

        uint _locale_lc_codepage;
    }

    struct __crt_locale_pointers
    {

        __crt_locale_data* locinfo;

        __crt_multibyte_data* mbcinfo;
    }

    alias _locale_t = __crt_locale_pointers*;

    struct _Mbstatet
    {

        c_ulong _Wchar;

        ushort _Byte;

        ushort _State;
    }

    alias mbstate_t = _Mbstatet;

    alias time_t = long;

    fz_document_writer* fz_new_ps_writer_with_output(fz_context*, fz_output*, const(char)*) @nogc nothrow;

    alias rsize_t = ulong;

    fz_document_writer* fz_new_ps_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_docx_writer_with_output(fz_context*, fz_output*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_docx_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_odt_writer_with_output(fz_context*, fz_output*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_odt_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_text_writer_with_output(fz_context*, const(char)*, fz_output*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_text_writer(fz_context*, const(char)*, const(char)*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_svg_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;

    fz_document_writer* fz_new_pdf_writer_with_output(fz_context*, fz_output*, const(char)*) @nogc nothrow;
    /**

	Document writers for various possible output formats.



	All of the "_with_output" variants pass the ownership of out in

	immediately upon calling. The writers are responsible for

	dropping the fz_output when they are finished with it (even

	if they throw an exception during creation).

*/
    fz_document_writer* fz_new_pdf_writer(fz_context*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Like fz_new_document_writer but takes a fz_output for writing

	the result. Only works for multi-page formats.

*/
    fz_document_writer* fz_new_document_writer_with_output(fz_context*, fz_output*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Create a new fz_document_writer, for a

	file of the given type.



	path: The document name to write (or NULL for default)



	format: Which format to write (currently cbz, html, pdf, pam,

	pbm, pgm, pkm, png, ppm, pnm, svg, text, xhtml, docx, odt)



	options: NULL, or pointer to comma separated string to control

	file generation.

*/
    fz_document_writer* fz_new_document_writer(fz_context*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Copy an option (val) into a destination buffer (dest), of maxlen

	bytes.



	Returns the number of bytes (including terminator) that did not

	fit. If val is maxlen or greater bytes in size, it will be left

	unterminated.

*/
    ulong fz_copy_option(fz_context*, const(char)*, char*, ulong) @nogc nothrow;
    /**

	Check to see if an option, a, from a string matches a reference

	option, b.



	(i.e. a could be 'foo' or 'foo,bar...' etc, but b can only be

	'foo'.)

*/
    int fz_option_eq(const(char)*, const(char)*) @nogc nothrow;
    /**

	Look for a given option (key) in the opts string. Return 1 if

	it has it, and update *val to point to the value within opts.

*/
    int fz_has_option(fz_context*, const(char)*, const(char)*, const(char)**) @nogc nothrow;
    alias fz_document_writer_drop_writer_fn = void function(fz_context*, fz_document_writer*);
    alias fz_document_writer_close_writer_fn = void function(fz_context*, fz_document_writer*);
    alias fz_document_writer_end_page_fn = void function(fz_context*, fz_document_writer*, fz_device*);
    alias fz_document_writer_begin_page_fn = fz_device* function(fz_context*, fz_document_writer*, fz_rect);
    /**

	Structure is public to allow other structures to

	be derived from it. Do not access members directly.

*/
    struct fz_document_writer
    {

        fz_device* function(fz_context*, fz_document_writer*, fz_rect) begin_page;

        void function(fz_context*, fz_document_writer*, fz_device*) end_page;

        void function(fz_context*, fz_document_writer*) close_writer;

        void function(fz_context*, fz_document_writer*) drop_writer;

        fz_device* dev;
    }
    /**

	Output the file header to a pwg stream, ready for pages to follow it.

*/
    void fz_write_pwg_file_header(fz_context*, fz_output*) @nogc nothrow;
    /**

	Create a new color pwg band writer.

*/
    fz_band_writer* fz_new_pwg_band_writer(fz_context*, fz_output*, const(fz_pwg_options)*) @nogc nothrow;
    /**

	Create a new monochrome pwg band writer.

*/
    fz_band_writer* fz_new_mono_pwg_band_writer(fz_context*, fz_output*, const(fz_pwg_options)*) @nogc nothrow;
    /**

	Write a bitmap as a PWG page.



	Caller should provide a file header by calling

	fz_write_pwg_file_header, but can then write several pages to

	the same file.

*/
    void fz_write_bitmap_as_pwg_page(fz_context*, fz_output*, const(fz_bitmap)*, const(fz_pwg_options)*) @nogc nothrow;
    /**

	Write a pixmap as a PWG page.



	Caller should provide a file header by calling

	fz_write_pwg_file_header, but can then write several pages to

	the same file.

*/
    void fz_write_pixmap_as_pwg_page(fz_context*, fz_output*, const(fz_pixmap)*, const(fz_pwg_options)*) @nogc nothrow;
    /**

	Write a bitmap as a PWG.

*/
    void fz_write_bitmap_as_pwg(fz_context*, fz_output*, const(fz_bitmap)*, const(fz_pwg_options)*) @nogc nothrow;
    /**

	Write a pixmap as a PWG.

*/
    void fz_write_pixmap_as_pwg(fz_context*, fz_output*, const(fz_pixmap)*, const(fz_pwg_options)*) @nogc nothrow;
    /**

	Save a bitmap as a PWG.

*/
    void fz_save_bitmap_as_pwg(fz_context*, fz_bitmap*, char*, int, const(fz_pwg_options)*) @nogc nothrow;
    /**

	Save a pixmap as a PWG.

*/
    void fz_save_pixmap_as_pwg(fz_context*, fz_pixmap*, char*, int, const(fz_pwg_options)*) @nogc nothrow;

    struct fz_pwg_options
    {

        char[64] media_class;

        char[64] media_color;

        char[64] media_type;

        char[64] output_type;

        uint advance_distance;

        int advance_media;

        int collate;

        int cut_media;

        int duplex;

        int insert_sheet;

        int jog;

        int leading_edge;

        int manual_feed;

        uint media_position;

        uint media_weight;

        int mirror_print;

        int negative_print;

        uint num_copies;

        int orientation;

        int output_face_up;

        uint[2] PageSize;

        int separations;

        int tray_switch;

        int tumble;

        int media_type_num;

        int compression;

        uint row_count;

        uint row_feed;

        uint row_step;

        char[64] rendering_intent;

        char[64] page_size_name;
    }
    /**

	Open a PSD band writer.

*/
    fz_band_writer* fz_new_psd_band_writer(fz_context*, fz_output*) @nogc nothrow;
    /**

	Write a pixmap as a PSD file.

*/
    void fz_write_pixmap_as_psd(fz_context*, fz_output*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Save a pixmap as a PSD file.

*/
    void fz_save_pixmap_as_psd(fz_context*, fz_pixmap*, const(char)*) @nogc nothrow;
    /**

	Write the file level trailer for ps band writer output.

*/
    void fz_write_ps_file_trailer(fz_context*, fz_output*, int) @nogc nothrow;
    /**

	Write the file level header for ps band writer output.

*/
    void fz_write_ps_file_header(fz_context*, fz_output*) @nogc nothrow;
    /**

	Create a postscript band writer for gray, rgb, or cmyk, no

	alpha.

*/
    fz_band_writer* fz_new_ps_band_writer(fz_context*, fz_output*) @nogc nothrow;
    /**

	Save a (gray, rgb, or cmyk, no alpha) pixmap out as postscript.

*/
    void fz_save_pixmap_as_ps(fz_context*, fz_pixmap*, char*, int) @nogc nothrow;
    /**

	Write a (gray, rgb, or cmyk, no alpha) pixmap out as postscript.

*/
    void fz_write_pixmap_as_ps(fz_context*, fz_output*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Save a CMYK pixmap as a pkm. (Performing halftoning).

*/
    void fz_save_pixmap_as_pkm(fz_context*, fz_pixmap*, const(char)*) @nogc nothrow;
    /**

	Create a new pkm band writer for CMYK pixmaps.

*/
    fz_band_writer* fz_new_pkm_band_writer(fz_context*, fz_output*) @nogc nothrow;
    /**

	Write a CMYK bitmap as a pkm.

*/
    void fz_write_bitmap_as_pkm(fz_context*, fz_output*, fz_bitmap*) @nogc nothrow;
    /**

	Save a CMYK bitmap as a pkm.

*/
    void fz_save_bitmap_as_pkm(fz_context*, fz_bitmap*, const(char)*) @nogc nothrow;
    /**

	Save a pixmap as a pbm. (Performing halftoning).

*/
    void fz_save_pixmap_as_pbm(fz_context*, fz_pixmap*, const(char)*) @nogc nothrow;
    /**

	Create a new band writer, targetting pbm.

*/
    fz_band_writer* fz_new_pbm_band_writer(fz_context*, fz_output*) @nogc nothrow;
    /**

	Write a bitmap as a pbm.

*/
    void fz_write_bitmap_as_pbm(fz_context*, fz_output*, fz_bitmap*) @nogc nothrow;
    /**

	Save a bitmap as a pbm.

*/
    void fz_save_bitmap_as_pbm(fz_context*, fz_bitmap*, const(char)*) @nogc nothrow;
    /**

	Create a band writer targetting pnm (greyscale, rgb or cmyk,

	with or without alpha).

*/
    fz_band_writer* fz_new_pam_band_writer(fz_context*, fz_output*) @nogc nothrow;
    /**

	Write a pixmap as a pnm (greyscale, rgb or cmyk, with or without

	alpha).

*/
    void fz_write_pixmap_as_pam(fz_context*, fz_output*, fz_pixmap*) @nogc nothrow;
    /**

	Save a pixmap as a pnm (greyscale, rgb or cmyk, with or without

	alpha).

*/
    void fz_save_pixmap_as_pam(fz_context*, fz_pixmap*, const(char)*) @nogc nothrow;
    /**

	Create a band writer targetting pnm (greyscale or rgb, no

	alpha).

*/
    fz_band_writer* fz_new_pnm_band_writer(fz_context*, fz_output*) @nogc nothrow;
    /**

	Write a pixmap as a pnm (greyscale or rgb, no alpha).

*/
    void fz_write_pixmap_as_pnm(fz_context*, fz_output*, fz_pixmap*) @nogc nothrow;
    /**

	Save a pixmap as a pnm (greyscale or rgb, no alpha).

*/
    void fz_save_pixmap_as_pnm(fz_context*, fz_pixmap*, const(char)*) @nogc nothrow;
    /**

	Reencode a given pixmap as a PNG into a buffer.



	Ownership of the buffer is returned.

*/
    fz_buffer* fz_new_buffer_from_pixmap_as_png(fz_context*, fz_pixmap*, fz_color_params) @nogc nothrow;
    /**

	Reencode a given image as a PNG into a buffer.



	Ownership of the buffer is returned.

*/
    fz_buffer* fz_new_buffer_from_image_as_png(fz_context*, fz_image*, fz_color_params) @nogc nothrow;
    /**

	Create a new png band writer (greyscale or RGB, with or without

	alpha).

*/
    fz_band_writer* fz_new_png_band_writer(fz_context*, fz_output*) @nogc nothrow;
    /**

	Write a (Greyscale or RGB) pixmap as a png.

*/
    void fz_write_pixmap_as_png(fz_context*, fz_output*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Save a (Greyscale or RGB) pixmap as a png.

*/
    void fz_save_pixmap_as_png(fz_context*, fz_pixmap*, const(char)*) @nogc nothrow;
    /**

	Save a (Greyscale or RGB) pixmap as pdfocr.

*/
    void fz_save_pixmap_as_pdfocr(fz_context*, fz_pixmap*, char*, int, const(fz_pdfocr_options)*) @nogc nothrow;
    /**

	Write a (Greyscale or RGB) pixmap as pdfocr.

*/
    void fz_write_pixmap_as_pdfocr(fz_context*, fz_output*, const(fz_pixmap)*, const(fz_pdfocr_options)*) @nogc nothrow;
    /**

	Set the progress callback for a pdfocr bandwriter.

*/
    void fz_pdfocr_band_writer_set_progress(fz_context*, fz_band_writer*, int function(fz_context*, void*, int, int), void*) @nogc nothrow;
    /**

	Create a new band writer, outputing pdfocr.



	Ownership of output stays with the caller, the band writer

	borrows the reference. The caller must keep the output around

	for the duration of the band writer, and then close/drop as

	appropriate.

*/
    fz_band_writer* fz_new_pdfocr_band_writer(fz_context*, fz_output*, const(fz_pdfocr_options)*) @nogc nothrow;
    /**

	Parse PDFOCR options.



	Currently defined options and values are as follows:



		compression=none: No compression

		compression=flate: Flate compression

		strip-height=n: Strip height (default 16)

		ocr-language=<lang>: OCR Language (default eng)

		ocr-datadir=<datadir>: OCR data path (default rely on TESSDATA_PREFIX)

*/
    fz_pdfocr_options* fz_parse_pdfocr_options(fz_context*, fz_pdfocr_options*, const(char)*) @nogc nothrow;
    /**

	PDFOCR output

*/
    struct fz_pdfocr_options
    {

        int compress;

        int strip_height;

        char[256] language;

        char[1024] datadir;

        int page_count;
    }
    /**

	Save a (Greyscale or RGB) pixmap as pclm.

*/
    void fz_save_pixmap_as_pclm(fz_context*, fz_pixmap*, char*, int, const(fz_pclm_options)*) @nogc nothrow;
    /**

	Write a (Greyscale or RGB) pixmap as pclm.

*/
    void fz_write_pixmap_as_pclm(fz_context*, fz_output*, const(fz_pixmap)*, const(fz_pclm_options)*) @nogc nothrow;
    /**

	Create a new band writer, outputing pclm

*/
    fz_band_writer* fz_new_pclm_band_writer(fz_context*, fz_output*, const(fz_pclm_options)*) @nogc nothrow;
    /**

	Parse PCLm options.



	Currently defined options and values are as follows:



		compression=none: No compression

		compression=flate: Flate compression

		strip-height=n: Strip height (default 16)

*/
    fz_pclm_options* fz_parse_pclm_options(fz_context*, fz_pclm_options*, const(char)*) @nogc nothrow;
    /**

	PCLm output

*/
    struct fz_pclm_options
    {

        int compress;

        int strip_height;

        int page_count;
    }
    /**

	Save an (RGB) pixmap as color PCL.

*/
    void fz_save_pixmap_as_pcl(fz_context*, fz_pixmap*, char*, int, const(fz_pcl_options)*) @nogc nothrow;

    void* _calloc_base(ulong, ulong) @nogc nothrow;

    void* calloc(ulong, ulong) @nogc nothrow;

    int _callnewh(ulong) @nogc nothrow;

    void* _expand(void*, ulong) @nogc nothrow;

    void _free_base(void*) @nogc nothrow;

    void free(void*) @nogc nothrow;

    void* _malloc_base(ulong) @nogc nothrow;

    void* malloc(ulong) @nogc nothrow;

    ulong _msize_base(void*) @nogc nothrow;

    ulong _msize(void*) @nogc nothrow;

    void* _realloc_base(void*, ulong) @nogc nothrow;

    void* realloc(void*, ulong) @nogc nothrow;

    void* _recalloc_base(void*, ulong, ulong) @nogc nothrow;

    void* _recalloc(void*, ulong, ulong) @nogc nothrow;

    void _aligned_free(void*) @nogc nothrow;

    void* _aligned_malloc(ulong, ulong) @nogc nothrow;

    void* _aligned_offset_malloc(ulong, ulong, ulong) @nogc nothrow;

    ulong _aligned_msize(void*, ulong, ulong) @nogc nothrow;

    void* _aligned_offset_realloc(void*, ulong, ulong, ulong) @nogc nothrow;

    void* _aligned_offset_recalloc(void*, ulong, ulong, ulong, ulong) @nogc nothrow;

    void* _aligned_realloc(void*, ulong, ulong) @nogc nothrow;

    void* _aligned_recalloc(void*, ulong, ulong, ulong) @nogc nothrow;
    alias _CoreCrtSecureSearchSortCompareFunction = int function(void*, const(void)*, const(void)*);
    alias _CoreCrtNonSecureSearchSortCompareFunction = int function(const(void)*, const(void)*);

    void* bsearch_s(const(void)*, const(void)*, ulong, ulong, int function(void*, const(void)*, const(void)*), void*) @nogc nothrow;

    void qsort_s(void*, ulong, ulong, int function(void*, const(void)*, const(void)*), void*) @nogc nothrow;

    void* bsearch(const(void)*, const(void)*, ulong, ulong, int function(const(void)*, const(void)*)) @nogc nothrow;

    void qsort(void*, ulong, ulong, int function(const(void)*, const(void)*)) @nogc nothrow;

    void* _lfind_s(const(void)*, const(void)*, uint*, ulong, int function(void*, const(void)*, const(void)*), void*) @nogc nothrow;

    void* _lfind(const(void)*, const(void)*, uint*, uint, int function(const(void)*, const(void)*)) @nogc nothrow;

    void* _lsearch_s(const(void)*, void*, uint*, ulong, int function(void*, const(void)*, const(void)*), void*) @nogc nothrow;

    void* _lsearch(const(void)*, void*, uint*, uint, int function(const(void)*, const(void)*)) @nogc nothrow;

    void* lfind(const(void)*, const(void)*, uint*, uint, int function(const(void)*, const(void)*)) @nogc nothrow;

    void* lsearch(const(void)*, void*, uint*, uint, int function(const(void)*, const(void)*)) @nogc nothrow;
    /**

	Write an (RGB) pixmap as color PCL.

*/
    void fz_write_pixmap_as_pcl(fz_context*, fz_output*, const(fz_pixmap)*, const(fz_pcl_options)*) @nogc nothrow;
    /**

	Create a new band writer, outputing color pcl.

*/
    fz_band_writer* fz_new_color_pcl_band_writer(fz_context*, fz_output*, const(fz_pcl_options)*) @nogc nothrow;

    ulong* __local_stdio_printf_options() @nogc nothrow;

    ulong* __local_stdio_scanf_options() @nogc nothrow;
    /**

	Save a bitmap as mono PCL.

*/
    void fz_save_bitmap_as_pcl(fz_context*, fz_bitmap*, char*, int, const(fz_pcl_options)*) @nogc nothrow;
    /**

	Write a bitmap as mono PCL.

*/
    void fz_write_bitmap_as_pcl(fz_context*, fz_output*, const(fz_bitmap)*, const(fz_pcl_options)*) @nogc nothrow;
    /**

	Create a new band writer, outputing monochrome pcl.

*/
    fz_band_writer* fz_new_mono_pcl_band_writer(fz_context*, fz_output*, const(fz_pcl_options)*) @nogc nothrow;
    /**

	Parse PCL options.



	Currently defined options and values are as follows:



		preset=X	Either "generic" or one of the presets as for fz_pcl_preset.

		spacing=0	No vertical spacing capability

		spacing=1	PCL 3 spacing (<ESC>*p+<n>Y)

		spacing=2	PCL 4 spacing (<ESC>*b<n>Y)

		spacing=3	PCL 5 spacing (<ESC>*b<n>Y and clear seed row)

		mode2		Disable/Enable mode 2 graphics compression

		mode3		Disable/Enable mode 3 graphics compression

		eog_reset	End of graphics (<ESC>*rB) resets all parameters

		has_duplex	Duplex supported (<ESC>&l<duplex>S)

		has_papersize	Papersize setting supported (<ESC>&l<sizecode>A)

		has_copies	Number of copies supported (<ESC>&l<copies>X)

		is_ljet4pjl	Disable/Enable HP 4PJL model-specific output

		is_oce9050	Disable/Enable Oce 9050 model-specific output

*/
    fz_pcl_options* fz_parse_pcl_options(fz_context*, fz_pcl_options*, const(char)*) @nogc nothrow;
    /**

	Initialize PCL option struct for a given preset.



	Currently defined presets include:



		generic	Generic PCL printer

		ljet4	HP DeskJet

		dj500	HP DeskJet 500

		fs600	Kyocera FS-600

		lj	HP LaserJet, HP LaserJet Plus

		lj2	HP LaserJet IIp, HP LaserJet IId

		lj3	HP LaserJet III

		lj3d	HP LaserJet IIId

		lj4	HP LaserJet 4

		lj4pl	HP LaserJet 4 PL

		lj4d	HP LaserJet 4d

		lp2563b	HP 2563B line printer

		oce9050	Oce 9050 Line printer

*/
    void fz_pcl_preset(fz_context*, fz_pcl_options*, const(char)*) @nogc nothrow;
    /**

	PCL output

*/
    struct fz_pcl_options
    {

        int features;

        const(char)* odd_page_init;

        const(char)* even_page_init;

        int tumble;

        int duplex_set;

        int duplex;

        int paper_size;

        int manual_feed_set;

        int manual_feed;

        int media_position_set;

        int media_position;

        int orientation;

        int page_count;
    }

    alias FILE = _iobuf;

    struct _iobuf
    {

        void* _Placeholder;
    }

    _iobuf* __acrt_iob_func(uint) @nogc nothrow;

    ushort fgetwc(_iobuf*) @nogc nothrow;

    ushort _fgetwchar() @nogc nothrow;

    ushort fputwc(ushort, _iobuf*) @nogc nothrow;

    ushort _fputwchar(ushort) @nogc nothrow;

    ushort getwc(_iobuf*) @nogc nothrow;

    ushort getwchar() @nogc nothrow;

    ushort* fgetws(ushort*, int, _iobuf*) @nogc nothrow;

    int fputws(const(ushort)*, _iobuf*) @nogc nothrow;

    ushort* _getws_s(ushort*, ulong) @nogc nothrow;

    ushort putwc(ushort, _iobuf*) @nogc nothrow;

    ushort putwchar(ushort) @nogc nothrow;

    int _putws(const(ushort)*) @nogc nothrow;

    ushort ungetwc(ushort, _iobuf*) @nogc nothrow;

    _iobuf* _wfdopen(int, const(ushort)*) @nogc nothrow;

    _iobuf* _wfopen(const(ushort)*, const(ushort)*) @nogc nothrow;

    int _wfopen_s(_iobuf**, const(ushort)*, const(ushort)*) @nogc nothrow;

    _iobuf* _wfreopen(const(ushort)*, const(ushort)*, _iobuf*) @nogc nothrow;

    int _wfreopen_s(_iobuf**, const(ushort)*, const(ushort)*, _iobuf*) @nogc nothrow;

    _iobuf* _wfsopen(const(ushort)*, const(ushort)*, int) @nogc nothrow;

    void _wperror(const(ushort)*) @nogc nothrow;

    _iobuf* _wpopen(const(ushort)*, const(ushort)*) @nogc nothrow;

    int _wremove(const(ushort)*) @nogc nothrow;

    ushort* _wtempnam(const(ushort)*, const(ushort)*) @nogc nothrow;

    int _wtmpnam_s(ushort*, ulong) @nogc nothrow;

    ushort* _wtmpnam(ushort*) @nogc nothrow;

    ushort _fgetwc_nolock(_iobuf*) @nogc nothrow;

    ushort _fputwc_nolock(ushort, _iobuf*) @nogc nothrow;

    ushort _getwc_nolock(_iobuf*) @nogc nothrow;

    ushort _putwc_nolock(ushort, _iobuf*) @nogc nothrow;

    ushort _ungetwc_nolock(ushort, _iobuf*) @nogc nothrow;

    int __stdio_common_vfwprintf(ulong, _iobuf*, const(ushort)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int __stdio_common_vfwprintf_s(ulong, _iobuf*, const(ushort)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int __stdio_common_vfwprintf_p(ulong, _iobuf*, const(ushort)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int _vfwprintf_l(_iobuf*, const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vfwprintf(_iobuf*, const(const(ushort)*), char*) @nogc nothrow;

    int _vfwprintf_s_l(_iobuf*, const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vfwprintf_s(_iobuf*, const(const(ushort)*), char*) @nogc nothrow;

    int _vfwprintf_p_l(_iobuf*, const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vfwprintf_p(_iobuf*, const(const(ushort)*), char*) @nogc nothrow;

    int _vwprintf_l(const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vwprintf(const(const(ushort)*), char*) @nogc nothrow;

    int _vwprintf_s_l(const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vwprintf_s(const(const(ushort)*), char*) @nogc nothrow;

    int _vwprintf_p_l(const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vwprintf_p(const(const(ushort)*), char*) @nogc nothrow;

    int _fwprintf_l(_iobuf*, const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int fwprintf(_iobuf*, const(const(ushort)*), ...) @nogc nothrow;

    int _fwprintf_s_l(_iobuf*, const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int fwprintf_s(_iobuf*, const(const(ushort)*), ...) @nogc nothrow;

    int _fwprintf_p_l(_iobuf*, const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _fwprintf_p(_iobuf*, const(const(ushort)*), ...) @nogc nothrow;

    int _wprintf_l(const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int wprintf(const(const(ushort)*), ...) @nogc nothrow;

    int _wprintf_s_l(const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int wprintf_s(const(const(ushort)*), ...) @nogc nothrow;

    int _wprintf_p_l(const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _wprintf_p(const(const(ushort)*), ...) @nogc nothrow;

    int __stdio_common_vfwscanf(ulong, _iobuf*, const(ushort)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int _vfwscanf_l(_iobuf*, const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vfwscanf(_iobuf*, const(const(ushort)*), char*) @nogc nothrow;

    int _vfwscanf_s_l(_iobuf*, const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vfwscanf_s(_iobuf*, const(const(ushort)*), char*) @nogc nothrow;

    int _vwscanf_l(const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vwscanf(const(const(ushort)*), char*) @nogc nothrow;

    int _vwscanf_s_l(const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vwscanf_s(const(const(ushort)*), char*) @nogc nothrow;

    int _fwscanf_l(_iobuf*, const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int fwscanf(_iobuf*, const(const(ushort)*), ...) @nogc nothrow;

    int _fwscanf_s_l(_iobuf*, const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int fwscanf_s(_iobuf*, const(const(ushort)*), ...) @nogc nothrow;

    int _wscanf_l(const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int wscanf(const(const(ushort)*), ...) @nogc nothrow;

    int _wscanf_s_l(const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int wscanf_s(const(const(ushort)*), ...) @nogc nothrow;
    /**

	Returns an fz_buffer containing a page after conversion to specified format.



	page: The page to convert.

	format, options: Passed to fz_new_document_writer_with_output() internally.

	transform, cookie: Passed to fz_run_page() internally.

*/
    fz_buffer* fz_new_buffer_from_page_with_format(fz_context*, fz_page*, const(char)*, const(char)*, fz_matrix, fz_cookie*) @nogc nothrow;

    int __stdio_common_vswprintf(ulong, ushort*, ulong, const(ushort)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int __stdio_common_vswprintf_s(ulong, ushort*, ulong, const(ushort)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int __stdio_common_vsnwprintf_s(ulong, ushort*, ulong, ulong, const(ushort)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int __stdio_common_vswprintf_p(ulong, ushort*, ulong, const(ushort)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int _vsnwprintf_l(ushort*, const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vsnwprintf_s_l(ushort*, const(ulong), const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vsnwprintf_s(ushort*, const(ulong), const(ulong), const(const(ushort)*), char*) @nogc nothrow;

    int _snwprintf(ushort*, ulong, const(ushort)*, ...) @nogc nothrow;

    int _vsnwprintf(ushort*, ulong, const(ushort)*, char*) @nogc nothrow;

    int _vswprintf_c_l(ushort*, const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vswprintf_c(ushort*, const(ulong), const(const(ushort)*), char*) @nogc nothrow;

    int _vswprintf_l(ushort*, const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int __vswprintf_l(ushort*, const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vswprintf(ushort*, const(const(ushort)*), char*) @nogc nothrow;

    int vswprintf(ushort*, const(ulong), const(const(ushort)*), char*) @nogc nothrow;

    int _vswprintf_s_l(ushort*, const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vswprintf_s(ushort*, const(ulong), const(const(ushort)*), char*) @nogc nothrow;

    int _vswprintf_p_l(ushort*, const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vswprintf_p(ushort*, const(ulong), const(const(ushort)*), char*) @nogc nothrow;

    int _vscwprintf_l(const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vscwprintf(const(const(ushort)*), char*) @nogc nothrow;

    int _vscwprintf_p_l(const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vscwprintf_p(const(const(ushort)*), char*) @nogc nothrow;

    int __swprintf_l(ushort*, const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _swprintf_l(ushort*, const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _swprintf(ushort*, const(const(ushort)*), ...) @nogc nothrow;

    int swprintf(ushort*, const(ulong), const(const(ushort)*), ...) @nogc nothrow;

    int _swprintf_s_l(ushort*, const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int swprintf_s(ushort*, const(ulong), const(const(ushort)*), ...) @nogc nothrow;

    int _swprintf_p_l(ushort*, const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _swprintf_p(ushort*, const(ulong), const(const(ushort)*), ...) @nogc nothrow;

    int _swprintf_c_l(ushort*, const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _swprintf_c(ushort*, const(ulong), const(const(ushort)*), ...) @nogc nothrow;

    int _snwprintf_l(ushort*, const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _snwprintf_s_l(ushort*, const(ulong), const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _snwprintf_s(ushort*, const(ulong), const(ulong), const(const(ushort)*), ...) @nogc nothrow;

    int _scwprintf_l(const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _scwprintf(const(const(ushort)*), ...) @nogc nothrow;

    int _scwprintf_p_l(const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _scwprintf_p(const(const(ushort)*), ...) @nogc nothrow;

    int __stdio_common_vswscanf(ulong, const(ushort)*, ulong, const(ushort)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int _vswscanf_l(const(const(ushort)*), const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vswscanf(const(ushort)*, const(ushort)*, char*) @nogc nothrow;

    int _vswscanf_s_l(const(const(ushort)*), const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vswscanf_s(const(const(ushort)*), const(const(ushort)*), char*) @nogc nothrow;

    int _vsnwscanf_l(const(const(ushort)*), const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vsnwscanf_s_l(const(const(ushort)*), const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _swscanf_l(const(const(ushort)*), const(const(ushort)*), __crt_locale_pointers*, ...) @nogc nothrow;

    int swscanf(const(const(ushort)*), const(const(ushort)*), ...) @nogc nothrow;

    int _swscanf_s_l(const(const(ushort)*), const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int swscanf_s(const(const(ushort)*), const(const(ushort)*), ...) @nogc nothrow;

    int _snwscanf_l(const(const(ushort)*), const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _snwscanf(const(const(ushort)*), const(ulong), const(const(ushort)*), ...) @nogc nothrow;

    int _snwscanf_s_l(const(const(ushort)*), const(ulong), const(const(ushort)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _snwscanf_s(const(const(ushort)*), const(ulong), const(const(ushort)*), ...) @nogc nothrow;
    /**

	Use text extraction to convert the input document into XHTML,

	then open the result as a new document that can be reflowed.

*/
    fz_document* fz_new_xhtml_document_from_document(fz_context*, fz_document*, const(fz_stext_options)*) @nogc nothrow;

    void fz_append_pixmap_as_data_uri(fz_context*, fz_buffer*, fz_pixmap*) @nogc nothrow;

    void fz_append_image_as_data_uri(fz_context*, fz_buffer*, fz_image*) @nogc nothrow;

    void fz_write_pixmap_as_data_uri(fz_context*, fz_output*, fz_pixmap*) @nogc nothrow;
    /**

	Write image as a data URI (for HTML and SVG output).

*/
    void fz_write_image_as_data_uri(fz_context*, fz_output*, fz_image*) @nogc nothrow;
    /**

	Create a scalable image from an SVG document.

*/
    fz_image* fz_new_image_from_svg_xml(fz_context*, fz_xml*, fz_xml*, const(char)*, fz_archive*) @nogc nothrow;
    /**

	Parse an SVG document into a display-list.

*/
    fz_display_list* fz_new_display_list_from_svg_xml(fz_context*, fz_xml*, fz_xml*, const(char)*, fz_archive*, float*, float*) @nogc nothrow;
    /**

	Create a scalable image from an SVG document.

*/
    fz_image* fz_new_image_from_svg(fz_context*, fz_buffer*, const(char)*, fz_archive*) @nogc nothrow;
    /**

	Parse an SVG document into a display-list.

*/
    fz_display_list* fz_new_display_list_from_svg(fz_context*, fz_buffer*, const(char)*, fz_archive*, float*, float*) @nogc nothrow;

    int fz_search_display_list(fz_context*, fz_display_list*, const(char)*, int*, fz_quad*, int) @nogc nothrow;

    int fz_search_chapter_page_number(fz_context*, fz_document*, int, int, const(char)*, int*, fz_quad*, int) @nogc nothrow;

    int fz_search_page_number(fz_context*, fz_document*, int, const(char)*, int*, fz_quad*, int) @nogc nothrow;
    /**

	Search for the 'needle' text on the page.

	Record the hits in the hit_bbox array and return the number of

	hits. Will stop looking once it has filled hit_max rectangles.

*/
    int fz_search_page(fz_context*, fz_page*, const(char)*, int*, fz_quad*, int) @nogc nothrow;

    fz_buffer* fz_new_buffer_from_display_list(fz_context*, fz_display_list*, const(fz_stext_options)*) @nogc nothrow;

    fz_buffer* fz_new_buffer_from_page_number(fz_context*, fz_document*, int, const(fz_stext_options)*) @nogc nothrow;

    fz_buffer* fz_new_buffer_from_page(fz_context*, fz_page*, const(fz_stext_options)*) @nogc nothrow;
    /**

	Convert structured text into plain text.

*/
    fz_buffer* fz_new_buffer_from_stext_page(fz_context*, fz_stext_page*) @nogc nothrow;

    fz_stext_page* fz_new_stext_page_from_display_list(fz_context*, fz_display_list*, const(fz_stext_options)*) @nogc nothrow;

    fz_stext_page* fz_new_stext_page_from_chapter_page_number(fz_context*, fz_document*, int, int, const(fz_stext_options)*) @nogc nothrow;

    fz_stext_page* fz_new_stext_page_from_page_number(fz_context*, fz_document*, int, const(fz_stext_options)*) @nogc nothrow;

    int _itow_s(int, ushort*, ulong, int) @nogc nothrow;

    ushort* _itow(int, ushort*, int) @nogc nothrow;

    int _ltow_s(c_long, ushort*, ulong, int) @nogc nothrow;

    ushort* _ltow(c_long, ushort*, int) @nogc nothrow;

    int _ultow_s(c_ulong, ushort*, ulong, int) @nogc nothrow;

    ushort* _ultow(c_ulong, ushort*, int) @nogc nothrow;

    double wcstod(const(ushort)*, ushort**) @nogc nothrow;

    double _wcstod_l(const(ushort)*, ushort**, __crt_locale_pointers*) @nogc nothrow;

    c_long wcstol(const(ushort)*, ushort**, int) @nogc nothrow;

    c_long _wcstol_l(const(ushort)*, ushort**, int, __crt_locale_pointers*) @nogc nothrow;

    long wcstoll(const(ushort)*, ushort**, int) @nogc nothrow;

    long _wcstoll_l(const(ushort)*, ushort**, int, __crt_locale_pointers*) @nogc nothrow;

    c_ulong wcstoul(const(ushort)*, ushort**, int) @nogc nothrow;

    c_ulong _wcstoul_l(const(ushort)*, ushort**, int, __crt_locale_pointers*) @nogc nothrow;

    ulong wcstoull(const(ushort)*, ushort**, int) @nogc nothrow;

    ulong _wcstoull_l(const(ushort)*, ushort**, int, __crt_locale_pointers*) @nogc nothrow;

    real wcstold(const(ushort)*, ushort**) @nogc nothrow;

    real _wcstold_l(const(ushort)*, ushort**, __crt_locale_pointers*) @nogc nothrow;

    float wcstof(const(ushort)*, ushort**) @nogc nothrow;

    float _wcstof_l(const(ushort)*, ushort**, __crt_locale_pointers*) @nogc nothrow;

    double _wtof(const(ushort)*) @nogc nothrow;

    double _wtof_l(const(ushort)*, __crt_locale_pointers*) @nogc nothrow;

    int _wtoi(const(ushort)*) @nogc nothrow;

    int _wtoi_l(const(ushort)*, __crt_locale_pointers*) @nogc nothrow;

    c_long _wtol(const(ushort)*) @nogc nothrow;

    c_long _wtol_l(const(ushort)*, __crt_locale_pointers*) @nogc nothrow;

    long _wtoll(const(ushort)*) @nogc nothrow;

    long _wtoll_l(const(ushort)*, __crt_locale_pointers*) @nogc nothrow;

    int _i64tow_s(long, ushort*, ulong, int) @nogc nothrow;

    ushort* _i64tow(long, ushort*, int) @nogc nothrow;

    int _ui64tow_s(ulong, ushort*, ulong, int) @nogc nothrow;

    ushort* _ui64tow(ulong, ushort*, int) @nogc nothrow;

    long _wtoi64(const(ushort)*) @nogc nothrow;

    long _wtoi64_l(const(ushort)*, __crt_locale_pointers*) @nogc nothrow;

    long _wcstoi64(const(ushort)*, ushort**, int) @nogc nothrow;

    long _wcstoi64_l(const(ushort)*, ushort**, int, __crt_locale_pointers*) @nogc nothrow;

    ulong _wcstoui64(const(ushort)*, ushort**, int) @nogc nothrow;

    ulong _wcstoui64_l(const(ushort)*, ushort**, int, __crt_locale_pointers*) @nogc nothrow;

    ushort* _wfullpath(ushort*, const(ushort)*, ulong) @nogc nothrow;

    int _wmakepath_s(ushort*, ulong, const(ushort)*, const(ushort)*, const(ushort)*, const(ushort)*) @nogc nothrow;

    void _wmakepath(ushort*, const(ushort)*, const(ushort)*, const(ushort)*, const(ushort)*) @nogc nothrow;

    void _wsplitpath(const(ushort)*, ushort*, ushort*, ushort*, ushort*) @nogc nothrow;

    int _wsplitpath_s(const(ushort)*, ushort*, ulong, ushort*, ulong, ushort*, ulong, ushort*, ulong) @nogc nothrow;

    int _wdupenv_s(ushort**, ulong*, const(ushort)*) @nogc nothrow;

    ushort* _wgetenv(const(ushort)*) @nogc nothrow;

    int _wgetenv_s(ulong*, ushort*, ulong, const(ushort)*) @nogc nothrow;

    int _wputenv(const(ushort)*) @nogc nothrow;

    int _wputenv_s(const(ushort)*, const(ushort)*) @nogc nothrow;

    int _wsearchenv_s(const(ushort)*, const(ushort)*, ushort*, ulong) @nogc nothrow;

    void _wsearchenv(const(ushort)*, const(ushort)*, ushort*) @nogc nothrow;

    int _wsystem(const(ushort)*) @nogc nothrow;
    /**

	Extract text from page.



	Ownership of the fz_stext_page is returned to the caller.

*/
    fz_stext_page* fz_new_stext_page_from_page(fz_context*, fz_page*, const(fz_stext_options)*) @nogc nothrow;

    fz_pixmap* fz_new_pixmap_from_page_contents_with_separations(fz_context*, fz_page*, fz_matrix, fz_colorspace*, fz_separations*, int) @nogc nothrow;

    fz_pixmap* fz_new_pixmap_from_page_number_with_separations(fz_context*, fz_document*, int, fz_matrix, fz_colorspace*, fz_separations*, int) @nogc nothrow;

    fz_pixmap* fz_new_pixmap_from_page_with_separations(fz_context*, fz_page*, fz_matrix, fz_colorspace*, fz_separations*, int) @nogc nothrow;
    /**

	Render the page contents with control over spot colors.



	Ownership of the pixmap is returned to the caller.

*/
    fz_pixmap* fz_new_pixmap_from_display_list_with_separations(fz_context*, fz_display_list*, fz_matrix, fz_colorspace*, fz_separations*, int) @nogc nothrow;
    /**

	Render the page contents without annotations.



	Ownership of the pixmap is returned to the caller.

*/
    fz_pixmap* fz_new_pixmap_from_page_contents(fz_context*, fz_page*, fz_matrix, fz_colorspace*, int) @nogc nothrow;

    fz_pixmap* fz_new_pixmap_from_page_number(fz_context*, fz_document*, int, fz_matrix, fz_colorspace*, int) @nogc nothrow;

    fz_pixmap* fz_new_pixmap_from_page(fz_context*, fz_page*, fz_matrix, fz_colorspace*, int) @nogc nothrow;
    /**

	Render the page to a pixmap using the transform and colorspace.



	Ownership of the pixmap is returned to the caller.

*/
    fz_pixmap* fz_new_pixmap_from_display_list(fz_context*, fz_display_list*, fz_matrix, fz_colorspace*, int) @nogc nothrow;
    /**

	Create a display list from page contents (no annotations).



	Ownership of the display list is returned to the caller.

*/
    fz_display_list* fz_new_display_list_from_page_contents(fz_context*, fz_page*) @nogc nothrow;

    fz_display_list* fz_new_display_list_from_page_number(fz_context*, fz_document*, int) @nogc nothrow;
    /**

	Create a display list.



	Ownership of the display list is returned to the caller.

*/
    fz_display_list* fz_new_display_list_from_page(fz_context*, fz_page*) @nogc nothrow;

    alias fpos_t = long;

    int _get_stream_buffer_pointers(_iobuf*, char***, char***, int**) @nogc nothrow;

    int clearerr_s(_iobuf*) @nogc nothrow;

    int fopen_s(_iobuf**, const(char)*, const(char)*) @nogc nothrow;

    ulong fread_s(void*, ulong, ulong, ulong, _iobuf*) @nogc nothrow;

    int freopen_s(_iobuf**, const(char)*, const(char)*, _iobuf*) @nogc nothrow;

    char* gets_s(char*, ulong) @nogc nothrow;

    int tmpfile_s(_iobuf**) @nogc nothrow;

    int tmpnam_s(char*, ulong) @nogc nothrow;

    void clearerr(_iobuf*) @nogc nothrow;

    int fclose(_iobuf*) @nogc nothrow;

    int _fcloseall() @nogc nothrow;

    _iobuf* _fdopen(int, const(char)*) @nogc nothrow;

    int feof(_iobuf*) @nogc nothrow;

    int ferror(_iobuf*) @nogc nothrow;

    int fflush(_iobuf*) @nogc nothrow;

    int fgetc(_iobuf*) @nogc nothrow;

    int _fgetchar() @nogc nothrow;

    int fgetpos(_iobuf*, long*) @nogc nothrow;

    char* fgets(char*, int, _iobuf*) @nogc nothrow;

    int _fileno(_iobuf*) @nogc nothrow;

    int _flushall() @nogc nothrow;

    _iobuf* fopen(const(char)*, const(char)*) @nogc nothrow;

    int fputc(int, _iobuf*) @nogc nothrow;

    int _fputchar(int) @nogc nothrow;

    int fputs(const(char)*, _iobuf*) @nogc nothrow;

    ulong fread(void*, ulong, ulong, _iobuf*) @nogc nothrow;

    _iobuf* freopen(const(char)*, const(char)*, _iobuf*) @nogc nothrow;

    _iobuf* _fsopen(const(char)*, const(char)*, int) @nogc nothrow;

    int fsetpos(_iobuf*, const(long)*) @nogc nothrow;

    int fseek(_iobuf*, c_long, int) @nogc nothrow;

    int _fseeki64(_iobuf*, long, int) @nogc nothrow;

    c_long ftell(_iobuf*) @nogc nothrow;

    long _ftelli64(_iobuf*) @nogc nothrow;

    ulong fwrite(const(void)*, ulong, ulong, _iobuf*) @nogc nothrow;

    int getc(_iobuf*) @nogc nothrow;

    int getchar() @nogc nothrow;

    int _getmaxstdio() @nogc nothrow;

    int _getw(_iobuf*) @nogc nothrow;

    void perror(const(char)*) @nogc nothrow;

    int _pclose(_iobuf*) @nogc nothrow;

    _iobuf* _popen(const(char)*, const(char)*) @nogc nothrow;

    int putc(int, _iobuf*) @nogc nothrow;

    int putchar(int) @nogc nothrow;

    int puts(const(char)*) @nogc nothrow;

    int _putw(int, _iobuf*) @nogc nothrow;

    int remove(const(char)*) @nogc nothrow;

    int rename(const(char)*, const(char)*) @nogc nothrow;

    int _unlink(const(char)*) @nogc nothrow;

    int unlink(const(char)*) @nogc nothrow;

    void rewind(_iobuf*) @nogc nothrow;

    int _rmtmp() @nogc nothrow;

    void setbuf(_iobuf*, char*) @nogc nothrow;

    int _setmaxstdio(int) @nogc nothrow;

    int setvbuf(_iobuf*, char*, int, ulong) @nogc nothrow;

    char* _tempnam(const(char)*, const(char)*) @nogc nothrow;

    _iobuf* tmpfile() @nogc nothrow;

    char* tmpnam(char*) @nogc nothrow;

    int ungetc(int, _iobuf*) @nogc nothrow;

    void _lock_file(_iobuf*) @nogc nothrow;

    void _unlock_file(_iobuf*) @nogc nothrow;

    int _fclose_nolock(_iobuf*) @nogc nothrow;

    int _fflush_nolock(_iobuf*) @nogc nothrow;

    int _fgetc_nolock(_iobuf*) @nogc nothrow;

    int _fputc_nolock(int, _iobuf*) @nogc nothrow;

    ulong _fread_nolock(void*, ulong, ulong, _iobuf*) @nogc nothrow;

    ulong _fread_nolock_s(void*, ulong, ulong, ulong, _iobuf*) @nogc nothrow;

    int _fseek_nolock(_iobuf*, c_long, int) @nogc nothrow;

    int _fseeki64_nolock(_iobuf*, long, int) @nogc nothrow;

    c_long _ftell_nolock(_iobuf*) @nogc nothrow;

    long _ftelli64_nolock(_iobuf*) @nogc nothrow;

    ulong _fwrite_nolock(const(void)*, ulong, ulong, _iobuf*) @nogc nothrow;

    int _getc_nolock(_iobuf*) @nogc nothrow;

    int _putc_nolock(int, _iobuf*) @nogc nothrow;

    int _ungetc_nolock(int, _iobuf*) @nogc nothrow;
    /**

	Locations within the document are referred to in terms of

	chapter and page, rather than just a page number. For some

	documents (such as epub documents with large numbers of pages

	broken into many chapters) this can make navigation much faster

	as only the required chapter needs to be decoded at a time.

*/
    struct fz_location
    {

        int chapter;

        int page;
    }

    int* __p__commode() @nogc nothrow;
    /**

	Structure definition is public so other classes can

	derive from it. Callers should not access the members

	directly, though implementations will need initialize

	functions directly.

*/
    struct fz_document
    {

        int refs;

        void function(fz_context*, fz_document*) drop_document;

        int function(fz_context*, fz_document*) needs_password;

        int function(fz_context*, fz_document*, const(char)*) authenticate_password;

        int function(fz_context*, fz_document*, fz_permission) has_permission;

        fz_outline* function(fz_context*, fz_document*) load_outline;

        fz_outline_iterator* function(fz_context*, fz_document*) outline_iterator;

        void function(fz_context*, fz_document*, float, float, float) layout;

        long function(fz_context*, fz_document*, fz_location) make_bookmark;

        fz_location function(fz_context*, fz_document*, long) lookup_bookmark;

        fz_link_dest function(fz_context*, fz_document*, const(char)*) resolve_link_dest;

        char* function(fz_context*, fz_document*, fz_link_dest) format_link_uri;

        int function(fz_context*, fz_document*) count_chapters;

        int function(fz_context*, fz_document*, int) count_pages;

        fz_page* function(fz_context*, fz_document*, int, int) load_page;

        int function(fz_context*, fz_document*, const(char)*, char*, int) lookup_metadata;

        int function(fz_context*, fz_document*, const(char)*, const(char)*) set_metadata;

        fz_colorspace* function(fz_context*, fz_document*) get_output_intent;

        void function(fz_context*, fz_document*, fz_output*) output_accelerator;

        int did_layout;

        int is_reflowable;

        fz_page* open;
    }

    int __stdio_common_vfprintf(ulong, _iobuf*, const(char)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int __stdio_common_vfprintf_s(ulong, _iobuf*, const(char)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int __stdio_common_vfprintf_p(ulong, _iobuf*, const(char)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int _vfprintf_l(_iobuf*, const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vfprintf(_iobuf*, const(char)*, char*) @nogc nothrow;

    int _vfprintf_s_l(_iobuf*, const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vfprintf_s(_iobuf*, const(const(char)*), char*) @nogc nothrow;

    int _vfprintf_p_l(_iobuf*, const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vfprintf_p(_iobuf*, const(const(char)*), char*) @nogc nothrow;

    int _vprintf_l(const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vprintf(const(char)*, char*) @nogc nothrow;

    int _vprintf_s_l(const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vprintf_s(const(const(char)*), char*) @nogc nothrow;

    int _vprintf_p_l(const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vprintf_p(const(const(char)*), char*) @nogc nothrow;

    int _fprintf_l(_iobuf*, const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int fprintf(_iobuf*, const(char)*, ...) @nogc nothrow;

    int _set_printf_count_output(int) @nogc nothrow;

    int _get_printf_count_output() @nogc nothrow;

    int _fprintf_s_l(_iobuf*, const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int fprintf_s(_iobuf*, const(const(char)*), ...) @nogc nothrow;

    int _fprintf_p_l(_iobuf*, const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _fprintf_p(_iobuf*, const(const(char)*), ...) @nogc nothrow;

    int _printf_l(const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int printf(const(char)*, ...) @nogc nothrow;

    int _printf_s_l(const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int printf_s(const(const(char)*), ...) @nogc nothrow;

    int _printf_p_l(const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _printf_p(const(const(char)*), ...) @nogc nothrow;

    int __stdio_common_vfscanf(ulong, _iobuf*, const(char)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int _vfscanf_l(_iobuf*, const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vfscanf(_iobuf*, const(char)*, char*) @nogc nothrow;

    int _vfscanf_s_l(_iobuf*, const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vfscanf_s(_iobuf*, const(const(char)*), char*) @nogc nothrow;

    int _vscanf_l(const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vscanf(const(char)*, char*) @nogc nothrow;

    int _vscanf_s_l(const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vscanf_s(const(const(char)*), char*) @nogc nothrow;

    int _fscanf_l(_iobuf*, const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int fscanf(_iobuf*, const(char)*, ...) @nogc nothrow;

    int _fscanf_s_l(_iobuf*, const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int fscanf_s(_iobuf*, const(const(char)*), ...) @nogc nothrow;

    int _scanf_l(const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int scanf(const(char)*, ...) @nogc nothrow;

    int _scanf_s_l(const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int scanf_s(const(const(char)*), ...) @nogc nothrow;

    int __stdio_common_vsprintf(ulong, char*, ulong, const(char)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int __stdio_common_vsprintf_s(ulong, char*, ulong, const(char)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int __stdio_common_vsnprintf_s(ulong, char*, ulong, ulong, const(char)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int __stdio_common_vsprintf_p(ulong, char*, ulong, const(char)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int _vsnprintf_l(char*, const(ulong), const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vsnprintf(char*, const(ulong), const(const(char)*), char*) @nogc nothrow;

    int vsnprintf(char*, ulong, const(char)*, char*) @nogc nothrow;

    int _vsprintf_l(char*, const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vsprintf(char*, const(char)*, char*) @nogc nothrow;

    int _vsprintf_s_l(char*, const(ulong), const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vsprintf_s(char*, const(ulong), const(const(char)*), char*) @nogc nothrow;

    int _vsprintf_p_l(char*, const(ulong), const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vsprintf_p(char*, const(ulong), const(const(char)*), char*) @nogc nothrow;

    int _vsnprintf_s_l(char*, const(ulong), const(ulong), const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vsnprintf_s(char*, const(ulong), const(ulong), const(const(char)*), char*) @nogc nothrow;

    int vsnprintf_s(char*, const(ulong), const(ulong), const(const(char)*), char*) @nogc nothrow;

    int _vscprintf_l(const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vscprintf(const(const(char)*), char*) @nogc nothrow;

    int _vscprintf_p_l(const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vscprintf_p(const(const(char)*), char*) @nogc nothrow;

    int _vsnprintf_c_l(char*, const(ulong), const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int _vsnprintf_c(char*, const(ulong), const(const(char)*), char*) @nogc nothrow;

    int _sprintf_l(char*, const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int sprintf(char*, const(char)*, ...) @nogc nothrow;

    int _sprintf_s_l(char*, const(ulong), const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int sprintf_s(char*, const(ulong), const(const(char)*), ...) @nogc nothrow;

    int _sprintf_p_l(char*, const(ulong), const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _sprintf_p(char*, const(ulong), const(const(char)*), ...) @nogc nothrow;

    int _snprintf_l(char*, const(ulong), const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int snprintf(char*, ulong, const(char)*, ...) @nogc nothrow;

    int _snprintf(char*, const(ulong), const(const(char)*), ...) @nogc nothrow;

    int _snprintf_c_l(char*, const(ulong), const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _snprintf_c(char*, const(ulong), const(const(char)*), ...) @nogc nothrow;

    int _snprintf_s_l(char*, const(ulong), const(ulong), const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _snprintf_s(char*, const(ulong), const(ulong), const(const(char)*), ...) @nogc nothrow;

    int _scprintf_l(const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _scprintf(const(const(char)*), ...) @nogc nothrow;

    int _scprintf_p_l(const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _scprintf_p(const(const(char)*), ...) @nogc nothrow;

    int __stdio_common_vsscanf(ulong, const(char)*, ulong, const(char)*, __crt_locale_pointers*, char*) @nogc nothrow;

    int _vsscanf_l(const(const(char)*), const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vsscanf(const(char)*, const(char)*, char*) @nogc nothrow;

    int _vsscanf_s_l(const(const(char)*), const(const(char)*), const(__crt_locale_pointers*), char*) @nogc nothrow;

    int vsscanf_s(const(const(char)*), const(const(char)*), char*) @nogc nothrow;

    int _sscanf_l(const(const(char)*), const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int sscanf(const(char)*, const(char)*, ...) @nogc nothrow;

    int _sscanf_s_l(const(const(char)*), const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int sscanf_s(const(const(char)*), const(const(char)*), ...) @nogc nothrow;

    int _snscanf_l(const(const(char)*), const(ulong), const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _snscanf(const(const(char)*), const(ulong), const(const(char)*), ...) @nogc nothrow;

    int _snscanf_s_l(const(const(char)*), const(ulong), const(const(char)*), const(__crt_locale_pointers*), ...) @nogc nothrow;

    int _snscanf_s(const(const(char)*), const(ulong), const(const(char)*), ...) @nogc nothrow;

    char* tempnam(const(char)*, const(char)*) @nogc nothrow;

    int fcloseall() @nogc nothrow;

    _iobuf* fdopen(int, const(char)*) @nogc nothrow;

    int fgetchar() @nogc nothrow;

    int fileno(_iobuf*) @nogc nothrow;

    int flushall() @nogc nothrow;

    int fputchar(int) @nogc nothrow;

    int getw(_iobuf*) @nogc nothrow;

    int putw(int, _iobuf*) @nogc nothrow;

    int rmtmp() @nogc nothrow;
    /**

	Drop the tree.



	The storage used by the tree is freed, and each value has

	dropfunc called on it.

*/
    void fz_drop_tree(fz_context*, fz_tree*, void function(fz_context*, void*)) @nogc nothrow;
    /**

	Insert a new key/value pair and rebalance the tree.

	Return the new root of the tree after inserting and rebalancing.

	May be called with a NULL root to create a new tree.



	No data is copied into the tree structure; key and value are

	merely kept as pointers.

*/
    fz_tree* fz_tree_insert(fz_context*, fz_tree*, const(char)*, void*) @nogc nothrow;
    /**

	Look for the value of a node in the tree with the given key.



	Simple pointer equivalence is used for key.



	Returns NULL for no match.

*/
    void* fz_tree_lookup(fz_context*, fz_tree*, const(char)*) @nogc nothrow;
    struct fz_tree;

    void _swab(char*, char*, int) @nogc nothrow;

    void exit(int) @nogc nothrow;

    void _exit(int) @nogc nothrow;

    void _Exit(int) @nogc nothrow;

    void quick_exit(int) @nogc nothrow;

    void abort() @nogc nothrow;
    /**

	Generate a frame of a transition.



	tpix: Target pixmap

	opix: Old pixmap

	npix: New pixmap

	time: Position within the transition (0 to 256)

	trans: Transition details



	Returns 1 if successfully generated a frame.



	Note: Pixmaps must include alpha.

*/
    int fz_generate_transition(fz_context*, fz_pixmap*, fz_pixmap*, fz_pixmap*, int, fz_transition*) @nogc nothrow;

    uint _set_abort_behavior(uint, uint) @nogc nothrow;
    alias _onexit_t = int function();

    struct fz_transition
    {

        int type;

        float duration;

        int vertical;

        int outwards;

        int direction;

        int state0;

        int state1;
    }

    int atexit(void function()) @nogc nothrow;

    int function() _onexit(int function()) @nogc nothrow;

    int at_quick_exit(void function()) @nogc nothrow;
    alias _purecall_handler = void function();
    alias _invalid_parameter_handler = void function(const(ushort)*, const(ushort)*, const(ushort)*, uint, ulong);

    void function() _set_purecall_handler(void function()) @nogc nothrow;

    void function() _get_purecall_handler() @nogc nothrow;

    void function(const(ushort)*, const(ushort)*, const(ushort)*, uint, ulong) _set_invalid_parameter_handler(void function(const(ushort)*, const(ushort)*, const(ushort)*, uint, ulong)) @nogc nothrow;

    void function(const(ushort)*, const(ushort)*, const(ushort)*, uint, ulong) _get_invalid_parameter_handler() @nogc nothrow;

    void function(const(ushort)*, const(ushort)*, const(ushort)*, uint, ulong) _set_thread_local_invalid_parameter_handler(void function(const(ushort)*, const(ushort)*, const(ushort)*, uint, ulong)) @nogc nothrow;

    void function(const(ushort)*, const(ushort)*, const(ushort)*, uint, ulong) _get_thread_local_invalid_parameter_handler() @nogc nothrow;

    enum _Anonymous_21
    {

        FZ_TRANSITION_NONE = 0,

        FZ_TRANSITION_SPLIT = 1,

        FZ_TRANSITION_BLINDS = 2,

        FZ_TRANSITION_BOX = 3,

        FZ_TRANSITION_WIPE = 4,

        FZ_TRANSITION_DISSOLVE = 5,

        FZ_TRANSITION_GLITTER = 6,

        FZ_TRANSITION_FLY = 7,

        FZ_TRANSITION_PUSH = 8,

        FZ_TRANSITION_COVER = 9,

        FZ_TRANSITION_UNCOVER = 10,

        FZ_TRANSITION_FADE = 11,
    }
    enum FZ_TRANSITION_NONE = _Anonymous_21.FZ_TRANSITION_NONE;
    enum FZ_TRANSITION_SPLIT = _Anonymous_21.FZ_TRANSITION_SPLIT;
    enum FZ_TRANSITION_BLINDS = _Anonymous_21.FZ_TRANSITION_BLINDS;
    enum FZ_TRANSITION_BOX = _Anonymous_21.FZ_TRANSITION_BOX;
    enum FZ_TRANSITION_WIPE = _Anonymous_21.FZ_TRANSITION_WIPE;
    enum FZ_TRANSITION_DISSOLVE = _Anonymous_21.FZ_TRANSITION_DISSOLVE;
    enum FZ_TRANSITION_GLITTER = _Anonymous_21.FZ_TRANSITION_GLITTER;
    enum FZ_TRANSITION_FLY = _Anonymous_21.FZ_TRANSITION_FLY;
    enum FZ_TRANSITION_PUSH = _Anonymous_21.FZ_TRANSITION_PUSH;
    enum FZ_TRANSITION_COVER = _Anonymous_21.FZ_TRANSITION_COVER;
    enum FZ_TRANSITION_UNCOVER = _Anonymous_21.FZ_TRANSITION_UNCOVER;
    enum FZ_TRANSITION_FADE = _Anonymous_21.FZ_TRANSITION_FADE;
    /**

	Recover ISO 639 (639-{1,2,3,5}) language specification

	strings losslessly from a 15 bit fz_text_language code.



	No validation is carried out. See note above.

*/
    char* fz_string_from_text_language(char*, fz_text_language) @nogc nothrow;

    int _set_error_mode(int) @nogc nothrow;

    int* _errno() @nogc nothrow;
    /**

	Convert ISO 639 (639-{1,2,3,5}) language specification

	strings losslessly to a 15 bit fz_text_language code.



	No validation is carried out. Obviously invalid (out

	of spec) codes will be mapped to FZ_LANG_UNSET, but

	well-formed (but undefined) codes will be blithely

	accepted.

*/
    fz_text_language fz_text_language_from_string(const(char)*) @nogc nothrow;

    int _set_errno(int) @nogc nothrow;

    int _get_errno(int*) @nogc nothrow;

    c_ulong* __doserrno() @nogc nothrow;
    /**

	Find the bounds of a given text object.



	text: The text object to find the bounds of.



	stroke: Pointer to the stroke attributes (for stroked

	text), or NULL (for filled text).



	ctm: The matrix in use.



	r: pointer to storage for the bounds.



	Returns a pointer to r, which is updated to contain the

	bounding box for the text object.

*/
    fz_rect fz_bound_text(fz_context*, const(fz_text)*, const(fz_stroke_state)*, fz_matrix) @nogc nothrow;

    int _set_doserrno(c_ulong) @nogc nothrow;

    int _get_doserrno(c_ulong*) @nogc nothrow;

    char** __sys_errlist() @nogc nothrow;
    /**

	Measure the advance width of a UTF8 string should it be added to a text object.



	This uses the same layout algorithms as fz_show_string, and can be used

	to calculate text alignment adjustments.

*/
    fz_matrix fz_measure_string(fz_context*, fz_font*, fz_matrix, const(char)*, int, int, fz_bidi_direction, fz_text_language) @nogc nothrow;

    int* __sys_nerr() @nogc nothrow;
    /**

	Add a UTF8 string to a text object.



	text: Text object to add to.



	font: The font the string should be added in.



	trm: The transform to use.



	s: The utf-8 string to add.



	wmode: 1 for vertical mode, 0 for horizontal.



	bidi_level: The bidirectional level for this glyph.



	markup_dir: The direction of the text as specified in the markup.



	language: The language in use (if known, 0 otherwise)

		(e.g. FZ_LANG_zh_Hans).



	Returns the transform updated with the advance width of the

	string.

*/
    fz_matrix fz_show_string(fz_context*, fz_text*, fz_font*, fz_matrix, const(char)*, int, int, fz_bidi_direction, fz_text_language) @nogc nothrow;

    char** __p__pgmptr() @nogc nothrow;

    ushort** __p__wpgmptr() @nogc nothrow;

    int* __p__fmode() @nogc nothrow;
    /**

	Add a glyph/unicode value to a text object.



	text: Text object to add to.



	font: The font the glyph should be added in.



	trm: The transform to use for the glyph.



	glyph: The glyph id to add.



	unicode: The unicode character for the glyph.



	wmode: 1 for vertical mode, 0 for horizontal.



	bidi_level: The bidirectional level for this glyph.



	markup_dir: The direction of the text as specified in the

	markup.



	language: The language in use (if known, 0 otherwise)

	(e.g. FZ_LANG_zh_Hans).



	Throws exception on failure to allocate.

*/
    void fz_show_glyph(fz_context*, fz_text*, fz_font*, fz_matrix, int, int, int, int, fz_bidi_direction, fz_text_language) @nogc nothrow;
    /**

	Decrement the reference count for the text object. When the

	reference count hits zero, the text object is freed.



	Never throws exceptions.

*/
    void fz_drop_text(fz_context*, const(fz_text)*) @nogc nothrow;
    /**

	Increment the reference count for the text object. The same

	pointer is returned.



	Never throws exceptions.

*/
    fz_text* fz_keep_text(fz_context*, const(fz_text)*) @nogc nothrow;

    int _get_pgmptr(char**) @nogc nothrow;

    int _get_wpgmptr(ushort**) @nogc nothrow;

    int _set_fmode(int) @nogc nothrow;

    int _get_fmode(int*) @nogc nothrow;

    alias div_t = _div_t;

    struct _div_t
    {

        int quot;

        int rem;
    }

    alias ldiv_t = _ldiv_t;

    struct _ldiv_t
    {

        c_long quot;

        c_long rem;
    }

    alias lldiv_t = _lldiv_t;

    struct _lldiv_t
    {

        long quot;

        long rem;
    }

    int abs(int) @nogc nothrow;

    c_long labs(c_long) @nogc nothrow;

    long llabs(long) @nogc nothrow;

    long _abs64(long) @nogc nothrow;

    ushort _byteswap_ushort(ushort) @nogc nothrow;

    c_ulong _byteswap_ulong(c_ulong) @nogc nothrow;

    ulong _byteswap_uint64(ulong) @nogc nothrow;

    _div_t div(int, int) @nogc nothrow;

    _ldiv_t ldiv(c_long, c_long) @nogc nothrow;

    _lldiv_t lldiv(long, long) @nogc nothrow;

    uint _rotl(uint, int) @nogc nothrow;

    c_ulong _lrotl(c_ulong, int) @nogc nothrow;

    ulong _rotl64(ulong, int) @nogc nothrow;

    uint _rotr(uint, int) @nogc nothrow;

    c_ulong _lrotr(c_ulong, int) @nogc nothrow;

    ulong _rotr64(ulong, int) @nogc nothrow;
    /**

	Create a new empty fz_text object.



	Throws exception on failure to allocate.

*/
    fz_text* fz_new_text(fz_context*) @nogc nothrow;

    void srand(uint) @nogc nothrow;

    int rand() @nogc nothrow;

    struct _LDOUBLE
    {

        ubyte[10] ld;
    }

    struct fz_text
    {

        int refs;

        fz_text_span* head;

        fz_text_span* tail;
    }

    struct _CRT_DOUBLE
    {

        double x;
    }

    struct _CRT_FLOAT
    {

        float f;
    }

    struct _LONGDOUBLE
    {

        real x;
    }

    struct _LDBL12
    {

        ubyte[12] ld12;
    }

    double atof(const(char)*) @nogc nothrow;

    int atoi(const(char)*) @nogc nothrow;

    c_long atol(const(char)*) @nogc nothrow;

    long atoll(const(char)*) @nogc nothrow;

    long _atoi64(const(char)*) @nogc nothrow;

    double _atof_l(const(char)*, __crt_locale_pointers*) @nogc nothrow;

    int _atoi_l(const(char)*, __crt_locale_pointers*) @nogc nothrow;

    c_long _atol_l(const(char)*, __crt_locale_pointers*) @nogc nothrow;

    long _atoll_l(const(char)*, __crt_locale_pointers*) @nogc nothrow;

    long _atoi64_l(const(char)*, __crt_locale_pointers*) @nogc nothrow;

    int _atoflt(_CRT_FLOAT*, const(char)*) @nogc nothrow;

    int _atodbl(_CRT_DOUBLE*, char*) @nogc nothrow;

    int _atoldbl(_LDOUBLE*, char*) @nogc nothrow;

    int _atoflt_l(_CRT_FLOAT*, const(char)*, __crt_locale_pointers*) @nogc nothrow;

    int _atodbl_l(_CRT_DOUBLE*, char*, __crt_locale_pointers*) @nogc nothrow;

    int _atoldbl_l(_LDOUBLE*, char*, __crt_locale_pointers*) @nogc nothrow;

    float strtof(const(char)*, char**) @nogc nothrow;

    float _strtof_l(const(char)*, char**, __crt_locale_pointers*) @nogc nothrow;

    double strtod(const(char)*, char**) @nogc nothrow;

    double _strtod_l(const(char)*, char**, __crt_locale_pointers*) @nogc nothrow;

    real strtold(const(char)*, char**) @nogc nothrow;

    real _strtold_l(const(char)*, char**, __crt_locale_pointers*) @nogc nothrow;

    c_long strtol(const(char)*, char**, int) @nogc nothrow;

    c_long _strtol_l(const(char)*, char**, int, __crt_locale_pointers*) @nogc nothrow;

    long strtoll(const(char)*, char**, int) @nogc nothrow;

    long _strtoll_l(const(char)*, char**, int, __crt_locale_pointers*) @nogc nothrow;

    c_ulong strtoul(const(char)*, char**, int) @nogc nothrow;

    c_ulong _strtoul_l(const(char)*, char**, int, __crt_locale_pointers*) @nogc nothrow;

    ulong strtoull(const(char)*, char**, int) @nogc nothrow;

    ulong _strtoull_l(const(char)*, char**, int, __crt_locale_pointers*) @nogc nothrow;

    long _strtoi64(const(char)*, char**, int) @nogc nothrow;

    long _strtoi64_l(const(char)*, char**, int, __crt_locale_pointers*) @nogc nothrow;

    ulong _strtoui64(const(char)*, char**, int) @nogc nothrow;

    ulong _strtoui64_l(const(char)*, char**, int, __crt_locale_pointers*) @nogc nothrow;

    int _itoa_s(int, char*, ulong, int) @nogc nothrow;

    char* _itoa(int, char*, int) @nogc nothrow;

    int _ltoa_s(c_long, char*, ulong, int) @nogc nothrow;

    char* _ltoa(c_long, char*, int) @nogc nothrow;

    int _ultoa_s(c_ulong, char*, ulong, int) @nogc nothrow;

    char* _ultoa(c_ulong, char*, int) @nogc nothrow;

    int _i64toa_s(long, char*, ulong, int) @nogc nothrow;

    char* _i64toa(long, char*, int) @nogc nothrow;

    int _ui64toa_s(ulong, char*, ulong, int) @nogc nothrow;

    char* _ui64toa(ulong, char*, int) @nogc nothrow;

    struct fz_text_span
    {
        import std.bitmanip: bitfields;

        align(4):

        fz_font* font;

        fz_matrix trm;
        mixin(bitfields!(

            uint, "wmode", 1,

            uint, "bidi_level", 7,

            uint, "markup_dir", 2,

            uint, "language", 15,
            uint, "_padding_0", 7
        ));

        int len;

        int cap;

        fz_text_item* items;

        fz_text_span* next;
    }

    int _ecvt_s(char*, ulong, double, int, int*, int*) @nogc nothrow;

    char* _ecvt(double, int, int*, int*) @nogc nothrow;

    int _fcvt_s(char*, ulong, double, int, int*, int*) @nogc nothrow;

    char* _fcvt(double, int, int*, int*) @nogc nothrow;

    int _gcvt_s(char*, ulong, double, int) @nogc nothrow;

    char* _gcvt(double, int, char*) @nogc nothrow;

    int ___mb_cur_max_func() @nogc nothrow;

    int ___mb_cur_max_l_func(__crt_locale_pointers*) @nogc nothrow;

    int mblen(const(char)*, ulong) @nogc nothrow;

    int _mblen_l(const(char)*, ulong, __crt_locale_pointers*) @nogc nothrow;

    ulong _mbstrlen(const(char)*) @nogc nothrow;

    ulong _mbstrlen_l(const(char)*, __crt_locale_pointers*) @nogc nothrow;

    ulong _mbstrnlen(const(char)*, ulong) @nogc nothrow;

    ulong _mbstrnlen_l(const(char)*, ulong, __crt_locale_pointers*) @nogc nothrow;

    int mbtowc(ushort*, const(char)*, ulong) @nogc nothrow;

    int _mbtowc_l(ushort*, const(char)*, ulong, __crt_locale_pointers*) @nogc nothrow;

    int mbstowcs_s(ulong*, ushort*, ulong, const(char)*, ulong) @nogc nothrow;

    ulong mbstowcs(ushort*, const(char)*, ulong) @nogc nothrow;

    int _mbstowcs_s_l(ulong*, ushort*, ulong, const(char)*, ulong, __crt_locale_pointers*) @nogc nothrow;

    ulong _mbstowcs_l(ushort*, const(char)*, ulong, __crt_locale_pointers*) @nogc nothrow;

    int wctomb(char*, ushort) @nogc nothrow;

    int _wctomb_l(char*, ushort, __crt_locale_pointers*) @nogc nothrow;

    int wctomb_s(int*, char*, ulong, ushort) @nogc nothrow;

    int _wctomb_s_l(int*, char*, ulong, ushort, __crt_locale_pointers*) @nogc nothrow;

    int wcstombs_s(ulong*, char*, ulong, const(ushort)*, ulong) @nogc nothrow;

    ulong wcstombs(char*, const(ushort)*, ulong) @nogc nothrow;

    int _wcstombs_s_l(ulong*, char*, ulong, const(ushort)*, ulong, __crt_locale_pointers*) @nogc nothrow;

    ulong _wcstombs_l(char*, const(ushort)*, ulong, __crt_locale_pointers*) @nogc nothrow;

    char* _fullpath(char*, const(char)*, ulong) @nogc nothrow;

    int _makepath_s(char*, ulong, const(char)*, const(char)*, const(char)*, const(char)*) @nogc nothrow;

    void _makepath(char*, const(char)*, const(char)*, const(char)*, const(char)*) @nogc nothrow;

    void _splitpath(const(char)*, char*, char*, char*, char*) @nogc nothrow;

    int _splitpath_s(const(char)*, char*, ulong, char*, ulong, char*, ulong, char*, ulong) @nogc nothrow;

    int getenv_s(ulong*, char*, ulong, const(char)*) @nogc nothrow;

    int* __p___argc() @nogc nothrow;

    char*** __p___argv() @nogc nothrow;

    ushort*** __p___wargv() @nogc nothrow;

    enum _Anonymous_22
    {

        FZ_LANG_UNSET = 0,

        FZ_LANG_ur = 507,

        FZ_LANG_urd = 3423,

        FZ_LANG_ko = 416,

        FZ_LANG_ja = 37,

        FZ_LANG_zh = 242,

        FZ_LANG_zh_Hans = 14093,

        FZ_LANG_zh_Hant = 14822,
    }
    enum FZ_LANG_UNSET = _Anonymous_22.FZ_LANG_UNSET;
    enum FZ_LANG_ur = _Anonymous_22.FZ_LANG_ur;
    enum FZ_LANG_urd = _Anonymous_22.FZ_LANG_urd;
    enum FZ_LANG_ko = _Anonymous_22.FZ_LANG_ko;
    enum FZ_LANG_ja = _Anonymous_22.FZ_LANG_ja;
    enum FZ_LANG_zh = _Anonymous_22.FZ_LANG_zh;
    enum FZ_LANG_zh_Hans = _Anonymous_22.FZ_LANG_zh_Hans;
    enum FZ_LANG_zh_Hant = _Anonymous_22.FZ_LANG_zh_Hant;

    alias fz_text_language = _Anonymous_22;

    char*** __p__environ() @nogc nothrow;

    ushort*** __p__wenviron() @nogc nothrow;
    /**

	Text buffer.



	The trm field contains the a, b, c and d coefficients.

	The e and f coefficients come from the individual elements,

	together they form the transform matrix for the glyph.



	Glyphs are referenced by glyph ID.

	The Unicode text equivalent is kept in a separate array

	with indexes into the glyph array.

*/
    struct fz_text_item
    {

        float x;

        float y;

        int gid;

        int ucs;
    }

    char* getenv(const(char)*) @nogc nothrow;

    int _dupenv_s(char**, ulong*, const(char)*) @nogc nothrow;

    int system(const(char)*) @nogc nothrow;

    int _putenv(const(char)*) @nogc nothrow;

    int _putenv_s(const(char)*, const(char)*) @nogc nothrow;

    int _searchenv_s(const(char)*, const(char)*, char*, ulong) @nogc nothrow;

    void _searchenv(const(char)*, const(char)*, char*) @nogc nothrow;

    void _seterrormode(int) @nogc nothrow;

    void _beep(uint, uint) @nogc nothrow;

    void _sleep(c_ulong) @nogc nothrow;

    char* ecvt(double, int, int*, int*) @nogc nothrow;

    char* fcvt(double, int, int*, int*) @nogc nothrow;

    char* gcvt(double, int, char*) @nogc nothrow;

    char* itoa(int, char*, int) @nogc nothrow;

    char* ltoa(c_long, char*, int) @nogc nothrow;

    void swab(char*, char*, int) @nogc nothrow;

    char* ultoa(c_ulong, char*, int) @nogc nothrow;

    int putenv(const(char)*) @nogc nothrow;

    int function() onexit(int function()) @nogc nothrow;

    alias max_align_t = double;

    long fz_stat_mtime(const(char)*) @nogc nothrow;

    long fz_stat_ctime(const(char)*) @nogc nothrow;

    void fz_free_argv(int, char**) @nogc nothrow;

    char** fz_argv_from_wargv(int, ushort**) @nogc nothrow;

    int fz_remove_utf8(const(char)*) @nogc nothrow;

    void* fz_fopen_utf8(const(char)*, const(char)*) @nogc nothrow;

    ushort* fz_wchar_from_utf8(const(char)*) @nogc nothrow;

    char* fz_utf8_from_wchar(const(ushort)*) @nogc nothrow;

    alias fz_jmp_buf = _SETJMP_FLOAT128[16];

    alias ptrdiff_t = long;

    alias wchar_t = ushort;

    fz_document* fz_open_reflowed_document(fz_context*, fz_document*, const(fz_stext_options)*) @nogc nothrow;
    /**

	Create a device to OCR the text on the page.



	Renders the page internally to a bitmap that is then OCRd. Text

	is then forwarded onto the target device.



	target: The target device to receive the OCRd text.



	ctm: The transform to apply to the mediabox to get the size for

	the rendered page image. Also used to calculate the resolution

	for the page image. In general, this will be the same as the CTM

	that you pass to fz_run_page (or fz_run_display_list) to feed

	this device.



	mediabox: The mediabox (in points). Combined with the CTM to get

	the bounds of the pixmap used internally for the rendered page

	image.



	with_list: If with_list is false, then all non-text operations

	are forwarded instantly to the target device. This results in

	the target device seeing all NON-text operations, followed by

	all the text operations (derived from OCR).



	If with_list is true, then all the marking operations are

	collated into a display list which is then replayed to the

	target device at the end.



	language: NULL (for "eng"), or a pointer to a string to describe

	the languages/scripts that should be used for OCR (e.g.

	"eng,ara").



	datadir: NULL (for ""), or a pointer to a path string otherwise

	provided to Tesseract in the TESSDATA_PREFIX environment variable.



	progress: NULL, or function to be called periodically to indicate

	progress. Return 0 to continue, or 1 to cancel. progress_arg is

	returned as the void *. The int is a value between 0 and 100 to

	indicate progress.



	progress_arg: A void * value to be parrotted back to the progress

	function.

*/
    fz_device* fz_new_ocr_device(fz_context*, fz_device*, fz_matrix, fz_rect, int, const(char)*, const(char)*, int function(fz_context*, void*, int), void*) @nogc nothrow;
    /**

	Create a device to extract the text on a page.



	Gather the text on a page into blocks and lines.



	The reading order is taken from the order the text is drawn in

	the source file, so may not be accurate.



	page: The text page to which content should be added. This will

	usually be a newly created (empty) text page, but it can be one

	containing data already (for example when merging multiple

	pages, or watermarking).



	options: Options to configure the stext device.

*/
    fz_device* fz_new_stext_device(fz_context*, fz_stext_page*, const(fz_stext_options)*) @nogc nothrow;
    /**

	Parse stext device options from a comma separated key-value

	string.

*/
    fz_stext_options* fz_parse_stext_options(fz_context*, fz_stext_options*, const(char)*) @nogc nothrow;
    /**

	Options for creating a pixmap and draw device.

*/
    struct fz_stext_options
    {

        int flags;

        float scale;
    }
    /**

	Return a newly allocated UTF-8 string with the text for a given

	selection rectangle.



	crlf: If true, write "\r\n" style line endings (otherwise "\n"

	only).

*/
    char* fz_copy_rectangle(fz_context*, fz_stext_page*, fz_rect, int) @nogc nothrow;
    /**

	Return a newly allocated UTF-8 string with the text for a given

	selection.



	crlf: If true, write "\r\n" style line endings (otherwise "\n"

	only).

*/
    char* fz_copy_selection(fz_context*, fz_stext_page*, fz_point, fz_point, int) @nogc nothrow;

    fz_quad fz_snap_selection(fz_context*, fz_stext_page*, fz_point*, fz_point*, int) @nogc nothrow;
    /**

	Implementation details: Subject to change.

*/
    struct fz_archive
    {

        int refs;

        fz_stream* file;

        const(char)* format;

        void function(fz_context*, fz_archive*) drop_archive;

        int function(fz_context*, fz_archive*) count_entries;

        const(char)* function(fz_context*, fz_archive*, int) list_entry;

        int function(fz_context*, fz_archive*, const(char)*) has_entry;

        fz_buffer* function(fz_context*, fz_archive*, const(char)*) read_entry;

        fz_stream* function(fz_context*, fz_archive*, const(char)*) open_entry;
    }
    /**

	Open a zip or tar archive



	Open a file and identify its archive type based on the archive

	signature contained inside.



	filename: a path to a file as it would be given to open(2).

*/
    fz_archive* fz_open_archive(fz_context*, const(char)*) @nogc nothrow;
    /**

	Open zip or tar archive stream.



	Open an archive using a seekable stream object rather than

	opening a file or directory on disk.

*/
    fz_archive* fz_open_archive_with_stream(fz_context*, fz_stream*) @nogc nothrow;
    /**

	Open a directory as if it was an archive.



	A special case where a directory is opened as if it was an

	archive.



	Note that for directories it is not possible to retrieve the

	number of entries or list the entries. It is however possible

	to check if the archive has a particular entry.



	path: a path to a directory as it would be given to opendir(3).

*/
    fz_archive* fz_open_directory(fz_context*, const(char)*) @nogc nothrow;
    /**

	Determine if a given path is a directory.

*/
    int fz_is_directory(fz_context*, const(char)*) @nogc nothrow;
    /**

	Drop a reference to an archive.



	When the last reference is dropped, this closes and releases

	any memory or filehandles associated with the archive.

*/
    void fz_drop_archive(fz_context*, fz_archive*) @nogc nothrow;
    /**

	Keep a reference to an archive.

*/
    fz_archive* fz_keep_archive(fz_context*, fz_archive*) @nogc nothrow;
    /**

	Return a pointer to a string describing the format of the

	archive.



	The lifetime of the string is unspecified (in current

	implementations the string will persist until the archive

	is closed, but this is not guaranteed).

*/
    const(char)* fz_archive_format(fz_context*, fz_archive*) @nogc nothrow;
    /**

	Number of entries in archive.



	Will always return a value >= 0.



	May throw an exception if this type of archive cannot count the

	entries (such as a directory).

*/
    int fz_count_archive_entries(fz_context*, fz_archive*) @nogc nothrow;
    /**

	Get listed name of entry position idx.



	idx: Must be a value >= 0 < return value from

	fz_count_archive_entries. If not in range NULL will be

	returned.



	May throw an exception if this type of archive cannot list the

	entries (such as a directory).

*/
    const(char)* fz_list_archive_entry(fz_context*, fz_archive*, int) @nogc nothrow;
    /**

	Check if entry by given name exists.



	If named entry does not exist 0 will be returned, if it does

	exist 1 is returned.



	name: Entry name to look for, this must be an exact match to

	the entry name in the archive.

*/
    int fz_has_archive_entry(fz_context*, fz_archive*, const(char)*) @nogc nothrow;
    /**

	Opens an archive entry as a stream.



	name: Entry name to look for, this must be an exact match to

	the entry name in the archive.



	Throws an exception if a matching entry cannot be found.

*/
    fz_stream* fz_open_archive_entry(fz_context*, fz_archive*, const(char)*) @nogc nothrow;
    /**

	Reads all bytes in an archive entry

	into a buffer.



	name: Entry name to look for, this must be an exact match to

	the entry name in the archive.



	Throws an exception if a matching entry cannot be found.

*/
    fz_buffer* fz_read_archive_entry(fz_context*, fz_archive*, const(char)*) @nogc nothrow;
    /**

	Detect if stream object is a tar achieve.



	Assumes that the stream object is seekable.

*/
    int fz_is_tar_archive(fz_context*, fz_stream*) @nogc nothrow;
    /**

	Open a tar archive file.



	An exception is throw if the file is not a tar archive as

	indicated by the presence of a tar signature.



	filename: a path to a tar archive file as it would be given to

	open(2).

*/
    fz_archive* fz_open_tar_archive(fz_context*, const(char)*) @nogc nothrow;
    /**

	Open a tar archive stream.



	Open an archive using a seekable stream object rather than

	opening a file or directory on disk.



	An exception is throw if the stream is not a tar archive as

	indicated by the presence of a tar signature.



*/
    fz_archive* fz_open_tar_archive_with_stream(fz_context*, fz_stream*) @nogc nothrow;
    /**

	Detect if stream object is a zip archive.



	Assumes that the stream object is seekable.

*/
    int fz_is_zip_archive(fz_context*, fz_stream*) @nogc nothrow;
    /**

	Open a zip archive file.



	An exception is throw if the file is not a zip archive as

	indicated by the presence of a zip signature.



	filename: a path to a zip archive file as it would be given to

	open(2).

*/
    fz_archive* fz_open_zip_archive(fz_context*, const(char)*) @nogc nothrow;
    /**

	Open a zip archive stream.



	Open an archive using a seekable stream object rather than

	opening a file or directory on disk.



	An exception is throw if the stream is not a zip archive as

	indicated by the presence of a zip signature.



*/
    fz_archive* fz_open_zip_archive_with_stream(fz_context*, fz_stream*) @nogc nothrow;
    struct fz_zip_writer;
    /**

	Create a new zip writer that writes to a given file.



	Open an archive using a seekable stream object rather than

	opening a file or directory on disk.

*/
    fz_zip_writer* fz_new_zip_writer(fz_context*, const(char)*) @nogc nothrow;
    /**

	Create a new zip writer that writes to a given output stream.



	Ownership of out passes in immediately upon calling this function.

	The caller should never drop the fz_output, even if this function throws

	an exception.

*/
    fz_zip_writer* fz_new_zip_writer_with_output(fz_context*, fz_output*) @nogc nothrow;
    /**

	Given a buffer of data, (optionally) compress it, and add it to

	the zip file with the given name.

*/
    void fz_write_zip_entry(fz_context*, fz_zip_writer*, const(char)*, fz_buffer*, int) @nogc nothrow;
    /**

	Close the zip file for writing.



	This flushes any pending data to the file. This can throw

	exceptions.

*/
    void fz_close_zip_writer(fz_context*, fz_zip_writer*) @nogc nothrow;
    /**

	Drop the reference to the zipfile.



	In common with other 'drop' methods, this will never throw an

	exception.

*/
    void fz_drop_zip_writer(fz_context*, fz_zip_writer*) @nogc nothrow;
    /**

	Create an archive that holds named buffers.



	tree can either be a preformed tree with fz_buffers as values,

	or it can be NULL for an empty tree.

*/
    fz_archive* fz_new_tree_archive(fz_context*, fz_tree*) @nogc nothrow;
    /**

	Add a named buffer to an existing tree archive.



	The tree will take a new reference to the buffer. Ownership

	is not transferred.

*/
    void fz_tree_archive_add_buffer(fz_context*, fz_archive*, const(char)*, fz_buffer*) @nogc nothrow;
    /**

	Add a named block of data to an existing tree archive.



	The data will be copied into a buffer, and so the caller

	may free it as soon as this returns.

*/
    void fz_tree_archive_add_data(fz_context*, fz_archive*, const(char)*, const(void)*, ulong) @nogc nothrow;
    /**

	Create a new multi archive (initially empty).

*/
    fz_archive* fz_new_multi_archive(fz_context*) @nogc nothrow;
    /**

	Add an archive to the set of archives handled by a multi

	archive.



	If path is NULL, then the archive contents will appear at the

	top level, otherwise, the archives contents will appear prefixed

	by path.

*/
    void fz_mount_multi_archive(fz_context*, fz_archive*, fz_archive*, const(char)*) @nogc nothrow;

    fz_archive* fz_new_archive_of_size(fz_context*, fz_stream*, int) @nogc nothrow;

    enum _Anonymous_23
    {

        FZ_SELECT_CHARS = 0,

        FZ_SELECT_WORDS = 1,

        FZ_SELECT_LINES = 2,
    }
    enum FZ_SELECT_CHARS = _Anonymous_23.FZ_SELECT_CHARS;
    enum FZ_SELECT_WORDS = _Anonymous_23.FZ_SELECT_WORDS;
    enum FZ_SELECT_LINES = _Anonymous_23.FZ_SELECT_LINES;
    /**

	Return a list of quads to highlight lines inside the selection

	points.

*/
    int fz_highlight_selection(fz_context*, fz_stext_page*, fz_point, fz_point, fz_quad*, int) @nogc nothrow;

    struct fz_band_writer
    {

        void function(fz_context*, fz_band_writer*) drop;

        void function(fz_context*, fz_band_writer*) close;

        void function(fz_context*, fz_band_writer*, fz_colorspace*) header;

        void function(fz_context*, fz_band_writer*, int, int, int, const(ubyte)*) band;

        void function(fz_context*, fz_band_writer*) trailer;

        fz_output* out_;

        int w;

        int h;

        int n;

        int s;

        int alpha;

        int xres;

        int yres;

        int pagenum;

        int line;

        fz_separations* seps;
    }
    /**

	Cause a band writer to write the header for

	a banded image with the given properties/dimensions etc. This

	also configures the bandwriter for the format of the data to be

	passed in future calls.



	w, h: Width and Height of the entire page.



	n: Number of components (including spots and alphas).



	alpha: Number of alpha components.



	xres, yres: X and Y resolutions in dpi.



	cs: Colorspace (NULL for bitmaps)



	seps: Separation details (or NULL).

*/
    void fz_write_header(fz_context*, fz_band_writer*, int, int, int, int, int, int, int, fz_colorspace*, fz_separations*) @nogc nothrow;
    /**

	Cause a band writer to write the next band

	of data for an image.



	stride: The byte offset from the first byte of the data

	for a pixel to the first byte of the data for the same pixel

	on the row below.



	band_height: The number of lines in this band.



	samples: Pointer to first byte of the data.

*/
    void fz_write_band(fz_context*, fz_band_writer*, int, int, const(ubyte)*) @nogc nothrow;
    /**

	Finishes up the output and closes the band writer. After this

	call no more headers or bands may be written.

*/
    void fz_close_band_writer(fz_context*, fz_band_writer*) @nogc nothrow;
    /**

	Drop the reference to the band writer, causing it to be

	destroyed.



	Never throws an exception.

*/
    void fz_drop_band_writer(fz_context*, fz_band_writer*) @nogc nothrow;
    alias fz_write_header_fn = void function(fz_context*, fz_band_writer*, fz_colorspace*);
    alias fz_write_band_fn = void function(fz_context*, fz_band_writer*, int, int, int, const(ubyte)*);
    alias fz_write_trailer_fn = void function(fz_context*, fz_band_writer*);
    alias fz_close_band_writer_fn = void function(fz_context*, fz_band_writer*);
    alias fz_drop_band_writer_fn = void function(fz_context*, fz_band_writer*);

    fz_band_writer* fz_new_band_writer_of_size(fz_context*, ulong, fz_output*) @nogc nothrow;
    /**

	Search for occurrence of 'needle' in text page.



	Return the number of hits and store hit quads in the passed in

	array.



	NOTE: This is an experimental interface and subject to change

	without notice.

*/
    int fz_search_stext_page(fz_context*, fz_stext_page*, const(char)*, int*, fz_quad*, int) @nogc nothrow;
    /**

	Output structured text to a file in plain-text UTF-8 format.

*/
    void fz_print_stext_page_as_text(fz_context*, fz_output*, fz_stext_page*) @nogc nothrow;

    alias fz_bidi_direction = _Anonymous_24;

    enum _Anonymous_24
    {

        FZ_BIDI_LTR = 0,

        FZ_BIDI_RTL = 1,

        FZ_BIDI_NEUTRAL = 2,
    }
    enum FZ_BIDI_LTR = _Anonymous_24.FZ_BIDI_LTR;
    enum FZ_BIDI_RTL = _Anonymous_24.FZ_BIDI_RTL;
    enum FZ_BIDI_NEUTRAL = _Anonymous_24.FZ_BIDI_NEUTRAL;

    alias fz_bidi_flags = _Anonymous_25;

    enum _Anonymous_25
    {

        FZ_BIDI_CLASSIFY_WHITE_SPACE = 1,

        FZ_BIDI_REPLACE_TAB = 2,
    }
    enum FZ_BIDI_CLASSIFY_WHITE_SPACE = _Anonymous_25.FZ_BIDI_CLASSIFY_WHITE_SPACE;
    enum FZ_BIDI_REPLACE_TAB = _Anonymous_25.FZ_BIDI_REPLACE_TAB;
    alias fz_bidi_fragment_fn = void function(const(uint)*, ulong, int, int, void*);
    /**

	Partitions the given Unicode sequence into one or more

	unidirectional fragments and invokes the given callback

	function for each fragment.



	For example, if directionality of text is:

			0123456789

			rrlllrrrrr,

	we'll invoke callback with:

			&text[0], length == 2

			&text[2], length == 3

			&text[5], length == 5



	@param[in] text	start of Unicode sequence

	@param[in] textlen   number of Unicodes to analyse

	@param[in] baseDir   direction of paragraph (specify FZ_BIDI_NEUTRAL to force auto-detection)

	@param[in] callback  function to be called for each fragment

	@param[in] arg	data to be passed to the callback function

	@param[in] flags     flags to control operation (see fz_bidi_flags above)

*/
    void fz_bidi_fragment_text(fz_context*, const(uint)*, ulong, fz_bidi_direction*, void function(const(uint)*, ulong, int, int, void*), void*, int) @nogc nothrow;
    /**

	Output structured text to a file in JSON format.

*/
    void fz_print_stext_page_as_json(fz_context*, fz_output*, fz_stext_page*, float) @nogc nothrow;
    /**

	Bitmaps have 1 bit per component. Only used for creating

	halftoned versions of contone buffers, and saving out. Samples

	are stored msb first, akin to pbms.



	The internals of this struct are considered implementation

	details and subject to change. Where possible, accessor

	functions should be used in preference.

*/
    struct fz_bitmap
    {

        int refs;

        int w;

        int h;

        int stride;

        int n;

        int xres;

        int yres;

        ubyte* samples;
    }
    /**

	Take an additional reference to the bitmap. The same pointer

	is returned.



	Never throws exceptions.

*/
    fz_bitmap* fz_keep_bitmap(fz_context*, fz_bitmap*) @nogc nothrow;
    /**

	Drop a reference to the bitmap. When the reference count reaches

	zero, the bitmap will be destroyed.



	Never throws exceptions.

*/
    void fz_drop_bitmap(fz_context*, fz_bitmap*) @nogc nothrow;
    struct fz_halftone;
    /**

	Make a bitmap from a pixmap and a halftone.



	pix: The pixmap to generate from. Currently must be a single

	color component with no alpha.



	ht: The halftone to use. NULL implies the default halftone.



	Returns the resultant bitmap. Throws exceptions in the case of

	failure to allocate.

*/
    fz_bitmap* fz_new_bitmap_from_pixmap(fz_context*, fz_pixmap*, fz_halftone*) @nogc nothrow;
    /**

	Make a bitmap from a pixmap and a

	halftone, allowing for the position of the pixmap within an

	overall banded rendering.



	pix: The pixmap to generate from. Currently must be a single

	color component with no alpha.



	ht: The halftone to use. NULL implies the default halftone.



	band_start: Vertical offset within the overall banded rendering

	(in pixels)



	Returns the resultant bitmap. Throws exceptions in the case of

	failure to allocate.

*/
    fz_bitmap* fz_new_bitmap_from_pixmap_band(fz_context*, fz_pixmap*, fz_halftone*, int) @nogc nothrow;
    /**

	Create a new bitmap.



	w, h: Width and Height for the bitmap



	n: Number of color components (assumed to be a divisor of 8)



	xres, yres: X and Y resolutions (in pixels per inch).



	Returns pointer to created bitmap structure. The bitmap

	data is uninitialised.

*/
    fz_bitmap* fz_new_bitmap(fz_context*, int, int, int, int, int) @nogc nothrow;
    /**

	Retrieve details of a given bitmap.



	bitmap: The bitmap to query.



	w: Pointer to storage to retrieve width (or NULL).



	h: Pointer to storage to retrieve height (or NULL).



	n: Pointer to storage to retrieve number of color components (or

	NULL).



	stride: Pointer to storage to retrieve bitmap stride (or NULL).

*/
    void fz_bitmap_details(fz_bitmap*, int*, int*, int*, int*) @nogc nothrow;
    /**

	Set the entire bitmap to 0.



	Never throws exceptions.

*/
    void fz_clear_bitmap(fz_context*, fz_bitmap*) @nogc nothrow;
    /**

	Create a 'default' halftone structure

	for the given number of components.



	num_comps: The number of components to use.



	Returns a simple default halftone. The default halftone uses

	the same halftone tile for each plane, which may not be ideal

	for all purposes.

*/
    fz_halftone* fz_default_halftone(fz_context*, int) @nogc nothrow;
    /**

	Take an additional reference to the halftone. The same pointer

	is returned.



	Never throws exceptions.

*/
    fz_halftone* fz_keep_halftone(fz_context*, fz_halftone*) @nogc nothrow;
    /**

	Drop a reference to the halftone. When the reference count

	reaches zero, the halftone is destroyed.



	Never throws exceptions.

*/
    void fz_drop_halftone(fz_context*, fz_halftone*) @nogc nothrow;
    /**

	Output structured text to a file in XML format.

*/
    void fz_print_stext_page_as_xml(fz_context*, fz_output*, fz_stext_page*, int) @nogc nothrow;
    /**

	fz_buffer is a wrapper around a dynamically allocated array of

	bytes.



	Buffers have a capacity (the number of bytes storage immediately

	available) and a current size.



	The contents of the structure are considered implementation

	details and are subject to change. Users should use the accessor

	functions in preference.

*/
    struct fz_buffer
    {

        int refs;

        ubyte* data;

        ulong cap;

        ulong len;

        int unused_bits;

        int shared_;
    }
    /**

	Take an additional reference to the buffer. The same pointer

	is returned.



	Never throws exceptions.

*/
    fz_buffer* fz_keep_buffer(fz_context*, fz_buffer*) @nogc nothrow;
    /**

	Drop a reference to the buffer. When the reference count reaches

	zero, the buffer is destroyed.



	Never throws exceptions.

*/
    void fz_drop_buffer(fz_context*, fz_buffer*) @nogc nothrow;
    /**

	Retrieve internal memory of buffer.



	datap: Output parameter that will be pointed to the data.



	Returns the current size of the data in bytes.

*/
    ulong fz_buffer_storage(fz_context*, fz_buffer*, ubyte**) @nogc nothrow;
    /**

	Ensure that a buffer's data ends in a

	0 byte, and return a pointer to it.

*/
    const(char)* fz_string_from_buffer(fz_context*, fz_buffer*) @nogc nothrow;

    fz_buffer* fz_new_buffer(fz_context*, ulong) @nogc nothrow;
    /**

	Create a new buffer with existing data.



	data: Pointer to existing data.

	size: Size of existing data.



	Takes ownership of data. Does not make a copy. Calls fz_free on

	the data when the buffer is deallocated. Do not use 'data' after

	passing to this function.



	Returns pointer to new buffer. Throws exception on allocation

	failure.

*/
    fz_buffer* fz_new_buffer_from_data(fz_context*, ubyte*, ulong) @nogc nothrow;
    /**

	Like fz_new_buffer, but does not take ownership.

*/
    fz_buffer* fz_new_buffer_from_shared_data(fz_context*, const(ubyte)*, ulong) @nogc nothrow;
    /**

	Create a new buffer containing a copy of the passed data.

*/
    fz_buffer* fz_new_buffer_from_copied_data(fz_context*, const(ubyte)*, ulong) @nogc nothrow;
    /**

	Create a new buffer with data decoded from a base64 input string.

*/
    fz_buffer* fz_new_buffer_from_base64(fz_context*, const(char)*, ulong) @nogc nothrow;
    /**

	Ensure that a buffer has a given capacity,

	truncating data if required.



	capacity: The desired capacity for the buffer. If the current

	size of the buffer contents is smaller than capacity, it is

	truncated.

*/
    void fz_resize_buffer(fz_context*, fz_buffer*, ulong) @nogc nothrow;
    /**

	Make some space within a buffer (i.e. ensure that

	capacity > size).

*/
    void fz_grow_buffer(fz_context*, fz_buffer*) @nogc nothrow;
    /**

	Trim wasted capacity from a buffer by resizing internal memory.

*/
    void fz_trim_buffer(fz_context*, fz_buffer*) @nogc nothrow;
    /**

	Empties the buffer. Storage is not freed, but is held ready

	to be reused as the buffer is refilled.



	Never throws exceptions.

*/
    void fz_clear_buffer(fz_context*, fz_buffer*) @nogc nothrow;
    /**

	Append the contents of the source buffer onto the end of the

	destination buffer, extending automatically as required.



	Ownership of buffers does not change.

*/
    void fz_append_buffer(fz_context*, fz_buffer*, fz_buffer*) @nogc nothrow;
    /**

	Write a base64 encoded data block, optionally with periodic newlines.

*/
    void fz_append_base64(fz_context*, fz_buffer*, const(ubyte)*, ulong, int) @nogc nothrow;
    /**

	Append a base64 encoded fz_buffer, optionally with periodic newlines.

*/
    void fz_append_base64_buffer(fz_context*, fz_buffer*, fz_buffer*, int) @nogc nothrow;
    /**

	fz_append_*: Append data to a buffer.



	The buffer will automatically grow as required.

*/
    void fz_append_data(fz_context*, fz_buffer*, const(void)*, ulong) @nogc nothrow;

    void fz_append_string(fz_context*, fz_buffer*, const(char)*) @nogc nothrow;

    void fz_append_byte(fz_context*, fz_buffer*, int) @nogc nothrow;

    void fz_append_rune(fz_context*, fz_buffer*, int) @nogc nothrow;

    void fz_append_int32_le(fz_context*, fz_buffer*, int) @nogc nothrow;

    void fz_append_int16_le(fz_context*, fz_buffer*, int) @nogc nothrow;

    void fz_append_int32_be(fz_context*, fz_buffer*, int) @nogc nothrow;

    void fz_append_int16_be(fz_context*, fz_buffer*, int) @nogc nothrow;

    void fz_append_bits(fz_context*, fz_buffer*, int, int) @nogc nothrow;

    void fz_append_bits_pad(fz_context*, fz_buffer*) @nogc nothrow;
    /**

	fz_append_pdf_string: Append a string with PDF syntax quotes and

	escapes.



	The buffer will automatically grow as required.

*/
    void fz_append_pdf_string(fz_context*, fz_buffer*, const(char)*) @nogc nothrow;
    /**

	fz_append_printf: Format and append data to buffer using

	printf-like formatting (see fz_vsnprintf).



	The buffer will automatically grow as required.

*/
    void fz_append_printf(fz_context*, fz_buffer*, const(char)*, ...) @nogc nothrow;
    /**

	fz_append_vprintf: Format and append data to buffer using

	printf-like formatting with varargs (see fz_vsnprintf).

*/
    void fz_append_vprintf(fz_context*, fz_buffer*, const(char)*, char*) @nogc nothrow;
    /**

	Zero-terminate buffer in order to use as a C string.



	This byte is invisible and does not affect the length of the

	buffer as returned by fz_buffer_storage. The zero byte is

	written *after* the data, and subsequent writes will overwrite

	the terminating byte.



	Subsequent changes to the size of the buffer (such as by

	fz_buffer_trim, fz_buffer_grow, fz_resize_buffer, etc) may

	invalidate this.

*/
    void fz_terminate_buffer(fz_context*, fz_buffer*) @nogc nothrow;
    /**

	Create an MD5 digest from buffer contents.



	Never throws exceptions.

*/
    void fz_md5_buffer(fz_context*, fz_buffer*, ubyte*) @nogc nothrow;
    /**

	Take ownership of buffer contents.



	Performs the same task as fz_buffer_storage, but ownership of

	the data buffer returns with this call. The buffer is left

	empty.



	Note: Bad things may happen if this is called on a buffer with

	multiple references that is being used from multiple threads.



	data: Pointer to place to retrieve data pointer.



	Returns length of stream.

*/
    ulong fz_buffer_extract(fz_context*, fz_buffer*, ubyte**) @nogc nothrow;

    void fz_print_stext_trailer_as_xhtml(fz_context*, fz_output*) @nogc nothrow;
    struct fz_icc_profile;

    struct fz_colorspace
    {

        fz_key_storable key_storable;

        fz_colorspace_type type;

        int flags;

        int n;

        char* name;

        static union _Anonymous_26
        {

            static struct _Anonymous_27
            {

                fz_buffer* buffer;

                ubyte[16] md5;

                fz_icc_profile* profile;
            }

            _Anonymous_27 icc;

            static struct _Anonymous_28
            {

                fz_colorspace* base;

                int high;

                ubyte* lookup;
            }

            _Anonymous_28 indexed;

            static struct _Anonymous_29
            {

                fz_colorspace* base;

                void function(fz_context*, void*, const(float)*, int, float*, int) eval;

                void function(fz_context*, void*) drop;

                void* tint;

                char*[32] colorant;
            }

            _Anonymous_29 separation;
        }

        _Anonymous_26 u;
    }
    /**

	Pixmaps represent a set of pixels for a 2 dimensional region of

	a plane. Each pixel has n components per pixel. The components

	are in the order process-components, spot-colors, alpha, where

	there can be 0 of any of those types. The data is in

	premultiplied alpha when rendering, but non-premultiplied for

	colorspace conversions and rescaling.



	x, y: The minimum x and y coord of the region in pixels.



	w, h: The width and height of the region in pixels.



	n: The number of color components in the image.

		n = num composite colors + num spots + num alphas



	s: The number of spot channels in the image.



	alpha: 0 for no alpha, 1 for alpha present.



	flags: flag bits.

		Bit 0: If set, draw the image with linear interpolation.

		Bit 1: If set, free the samples buffer when the pixmap

		is destroyed.



	stride: The byte offset from the data for any given pixel

	to the data for the same pixel on the row below.



	seps: NULL, or a pointer to a separations structure. If NULL,

	s should be 0.



	xres, yres: Image resolution in dpi. Default is 96 dpi.



	colorspace: Pointer to a colorspace object describing the

	colorspace the pixmap is in. If NULL, the image is a mask.



	samples: Pointer to the first byte of the pixmap sample data.

	This is typically a simple block of memory w * h * n bytes of

	memory in which the components are stored linearly, but with the

	use of appropriate stride values, scanlines can be stored in

	different orders, and have different amounts of padding. The

	first n bytes are components 0 to n-1 for the pixel at (x,y).

	Each successive n bytes gives another pixel in scanline order

	as we move across the line. The start of each scanline is offset

	the start of the previous one by stride bytes.

*/
    struct fz_pixmap
    {

        fz_storable storable;

        int x;

        int y;

        int w;

        int h;

        ubyte n;

        ubyte s;

        ubyte alpha;

        ubyte flags;

        long stride;

        fz_separations* seps;

        int xres;

        int yres;

        fz_colorspace* colorspace;

        ubyte* samples;

        fz_pixmap* underlying;
    }

    enum _Anonymous_30
    {

        FZ_RI_PERCEPTUAL = 0,

        FZ_RI_RELATIVE_COLORIMETRIC = 1,

        FZ_RI_SATURATION = 2,

        FZ_RI_ABSOLUTE_COLORIMETRIC = 3,
    }
    enum FZ_RI_PERCEPTUAL = _Anonymous_30.FZ_RI_PERCEPTUAL;
    enum FZ_RI_RELATIVE_COLORIMETRIC = _Anonymous_30.FZ_RI_RELATIVE_COLORIMETRIC;
    enum FZ_RI_SATURATION = _Anonymous_30.FZ_RI_SATURATION;
    enum FZ_RI_ABSOLUTE_COLORIMETRIC = _Anonymous_30.FZ_RI_ABSOLUTE_COLORIMETRIC;

    struct fz_color_params
    {

        ubyte ri;

        ubyte bp;

        ubyte op;

        ubyte opm;
    }

    extern __gshared const(fz_color_params) fz_default_color_params;
    /**

	Map from (case sensitive) rendering intent string to enumeration

	value.

*/
    int fz_lookup_rendering_intent(const(char)*) @nogc nothrow;
    /**

	Map from enumerated rendering intent to string.



	The returned string is static and therefore must not be freed.

*/
    const(char)* fz_rendering_intent_name(int) @nogc nothrow;
    /**

	The maximum number of colorants available in any given

	color/colorspace (not including alpha).



	Changing this value will alter the amount of memory being used

	(both stack and heap space), but not hugely. Speed should

	(largely) be determined by the number of colors actually used.

*/
    enum _Anonymous_31
    {

        FZ_MAX_COLORS = 32,
    }
    enum FZ_MAX_COLORS = _Anonymous_31.FZ_MAX_COLORS;

    enum fz_colorspace_type
    {

        FZ_COLORSPACE_NONE = 0,

        FZ_COLORSPACE_GRAY = 1,

        FZ_COLORSPACE_RGB = 2,

        FZ_COLORSPACE_BGR = 3,

        FZ_COLORSPACE_CMYK = 4,

        FZ_COLORSPACE_LAB = 5,

        FZ_COLORSPACE_INDEXED = 6,

        FZ_COLORSPACE_SEPARATION = 7,
    }
    enum FZ_COLORSPACE_NONE = fz_colorspace_type.FZ_COLORSPACE_NONE;
    enum FZ_COLORSPACE_GRAY = fz_colorspace_type.FZ_COLORSPACE_GRAY;
    enum FZ_COLORSPACE_RGB = fz_colorspace_type.FZ_COLORSPACE_RGB;
    enum FZ_COLORSPACE_BGR = fz_colorspace_type.FZ_COLORSPACE_BGR;
    enum FZ_COLORSPACE_CMYK = fz_colorspace_type.FZ_COLORSPACE_CMYK;
    enum FZ_COLORSPACE_LAB = fz_colorspace_type.FZ_COLORSPACE_LAB;
    enum FZ_COLORSPACE_INDEXED = fz_colorspace_type.FZ_COLORSPACE_INDEXED;
    enum FZ_COLORSPACE_SEPARATION = fz_colorspace_type.FZ_COLORSPACE_SEPARATION;

    enum _Anonymous_32
    {

        FZ_COLORSPACE_IS_DEVICE = 1,

        FZ_COLORSPACE_IS_ICC = 2,

        FZ_COLORSPACE_HAS_CMYK = 4,

        FZ_COLORSPACE_HAS_SPOTS = 8,

        FZ_COLORSPACE_HAS_CMYK_AND_SPOTS = 12,
    }
    enum FZ_COLORSPACE_IS_DEVICE = _Anonymous_32.FZ_COLORSPACE_IS_DEVICE;
    enum FZ_COLORSPACE_IS_ICC = _Anonymous_32.FZ_COLORSPACE_IS_ICC;
    enum FZ_COLORSPACE_HAS_CMYK = _Anonymous_32.FZ_COLORSPACE_HAS_CMYK;
    enum FZ_COLORSPACE_HAS_SPOTS = _Anonymous_32.FZ_COLORSPACE_HAS_SPOTS;
    enum FZ_COLORSPACE_HAS_CMYK_AND_SPOTS = _Anonymous_32.FZ_COLORSPACE_HAS_CMYK_AND_SPOTS;
    /**

	Creates a new colorspace instance and returns a reference.



	No internal checking is done that the colorspace type (e.g.

	CMYK) matches with the flags (e.g. FZ_COLORSPACE_HAS_CMYK) or

	colorant count (n) or name.



	The reference should be dropped when it is finished with.



	Colorspaces are immutable once created (with the exception of

	setting up colorant names for separation spaces).

*/
    fz_colorspace* fz_new_colorspace(fz_context*, fz_colorspace_type, int, int, const(char)*) @nogc nothrow;
    /**

	Increment the reference count for the colorspace.



	Returns the same pointer. Never throws an exception.

*/
    fz_colorspace* fz_keep_colorspace(fz_context*, fz_colorspace*) @nogc nothrow;
    /**

	Drops a reference to the colorspace.



	When the reference count reaches zero, the colorspace is

	destroyed.

*/
    void fz_drop_colorspace(fz_context*, fz_colorspace*) @nogc nothrow;
    /**

	Create an indexed colorspace.



	The supplied lookup table is high palette entries long. Each

	entry is n bytes long, where n is given by the number of

	colorants in the base colorspace, one byte per colorant.



	Ownership of lookup is passed it; it will be freed on

	destruction, so must be heap allocated.



	The colorspace will keep an additional reference to the base

	colorspace that will be dropped on destruction.



	The returned reference should be dropped when it is finished

	with.



	Colorspaces are immutable once created.

*/
    fz_colorspace* fz_new_indexed_colorspace(fz_context*, fz_colorspace*, int, ubyte*) @nogc nothrow;
    /**

	Create a colorspace from an ICC profile supplied in buf.



	Limited checking is done to ensure that the colorspace type is

	appropriate for the supplied ICC profile.



	An additional reference is taken to buf, which will be dropped

	on destruction. Ownership is NOT passed in.



	The returned reference should be dropped when it is finished

	with.



	Colorspaces are immutable once created.

*/
    fz_colorspace* fz_new_icc_colorspace(fz_context*, fz_colorspace_type, int, const(char)*, fz_buffer*) @nogc nothrow;
    /**

	Create a calibrated gray colorspace.



	The returned reference should be dropped when it is finished

	with.



	Colorspaces are immutable once created.

*/
    fz_colorspace* fz_new_cal_gray_colorspace(fz_context*, float*, float*, float) @nogc nothrow;
    /**

	Create a calibrated rgb colorspace.



	The returned reference should be dropped when it is finished

	with.



	Colorspaces are immutable once created.

*/
    fz_colorspace* fz_new_cal_rgb_colorspace(fz_context*, float*, float*, float*, float*) @nogc nothrow;
    /**

	Query the type of colorspace.

*/
    pragma(mangle, "fz_colorspace_type") fz_colorspace_type fz_colorspace_type_(fz_context*, fz_colorspace*) @nogc nothrow;
    /**

	Query the name of a colorspace.



	The returned string has the same lifespan as the colorspace

	does. Caller should not free it.

*/
    const(char)* fz_colorspace_name(fz_context*, fz_colorspace*) @nogc nothrow;
    /**

	Query the number of colorants in a colorspace.

*/
    int fz_colorspace_n(fz_context*, fz_colorspace*) @nogc nothrow;
    /**

	True for CMYK, Separation and DeviceN colorspaces.

*/
    int fz_colorspace_is_subtractive(fz_context*, fz_colorspace*) @nogc nothrow;
    /**

	True if DeviceN color space has only colorants from the CMYK set.

*/
    int fz_colorspace_device_n_has_only_cmyk(fz_context*, fz_colorspace*) @nogc nothrow;
    /**

	True if DeviceN color space has cyan magenta yellow or black as

	one of its colorants.

*/
    int fz_colorspace_device_n_has_cmyk(fz_context*, fz_colorspace*) @nogc nothrow;
    /**

	Tests for particular types of colorspaces

*/
    int fz_colorspace_is_gray(fz_context*, fz_colorspace*) @nogc nothrow;

    int fz_colorspace_is_rgb(fz_context*, fz_colorspace*) @nogc nothrow;

    int fz_colorspace_is_cmyk(fz_context*, fz_colorspace*) @nogc nothrow;

    int fz_colorspace_is_lab(fz_context*, fz_colorspace*) @nogc nothrow;

    int fz_colorspace_is_indexed(fz_context*, fz_colorspace*) @nogc nothrow;

    int fz_colorspace_is_device_n(fz_context*, fz_colorspace*) @nogc nothrow;

    int fz_colorspace_is_device(fz_context*, fz_colorspace*) @nogc nothrow;

    int fz_colorspace_is_device_gray(fz_context*, fz_colorspace*) @nogc nothrow;

    int fz_colorspace_is_device_cmyk(fz_context*, fz_colorspace*) @nogc nothrow;

    int fz_colorspace_is_lab_icc(fz_context*, fz_colorspace*) @nogc nothrow;
    /**

	Check to see that a colorspace is appropriate to be used as

	a blending space (i.e. only grey, rgb or cmyk).

*/
    int fz_is_valid_blend_colorspace(fz_context*, fz_colorspace*) @nogc nothrow;
    /**

	Retrieve global default colorspaces.



	These return borrowed references that should not be dropped,

	unless they are kept first.

*/
    fz_colorspace* fz_device_gray(fz_context*) @nogc nothrow;

    fz_colorspace* fz_device_rgb(fz_context*) @nogc nothrow;

    fz_colorspace* fz_device_bgr(fz_context*) @nogc nothrow;

    fz_colorspace* fz_device_cmyk(fz_context*) @nogc nothrow;

    fz_colorspace* fz_device_lab(fz_context*) @nogc nothrow;
    /**

	Assign a name for a given colorant in a colorspace.



	Used while initially setting up a colorspace. The string is

	copied into local storage, so need not be retained by the

	caller.

*/
    void fz_colorspace_name_colorant(fz_context*, fz_colorspace*, int, const(char)*) @nogc nothrow;
    /**

	Retrieve a the name for a colorant.



	Returns a pointer with the same lifespan as the colorspace.

*/
    const(char)* fz_colorspace_colorant(fz_context*, fz_colorspace*, int) @nogc nothrow;
    /**

	Clamp the samples in a color to the correct ranges for a

	given colorspace.

*/
    void fz_clamp_color(fz_context*, fz_colorspace*, const(float)*, float*) @nogc nothrow;
    /**

	Convert color values sv from colorspace ss into colorvalues dv

	for colorspace ds, via an optional intervening space is,

	respecting the given color_params.

*/
    void fz_convert_color(fz_context*, fz_colorspace*, const(float)*, fz_colorspace*, float*, fz_colorspace*, fz_color_params) @nogc nothrow;
    /**

	Structure to hold default colorspaces.

*/
    struct fz_default_colorspaces
    {

        int refs;

        fz_colorspace* gray;

        fz_colorspace* rgb;

        fz_colorspace* cmyk;

        fz_colorspace* oi;
    }
    /**

	Create a new default colorspace structure with values inherited

	from the context, and return a reference to it.



	These can be overridden using fz_set_default_xxxx.



	These should not be overridden while more than one caller has

	the reference for fear of race conditions.



	The caller should drop this reference once finished with it.

*/
    fz_default_colorspaces* fz_new_default_colorspaces(fz_context*) @nogc nothrow;
    /**

	Keep an additional reference to the default colorspaces

	structure.



	Never throws exceptions.

*/
    fz_default_colorspaces* fz_keep_default_colorspaces(fz_context*, fz_default_colorspaces*) @nogc nothrow;
    /**

	Drop a reference to the default colorspaces structure. When the

	reference count reaches 0, the references it holds internally

	to the underlying colorspaces will be dropped, and the structure

	will be destroyed.



	Never throws exceptions.

*/
    void fz_drop_default_colorspaces(fz_context*, fz_default_colorspaces*) @nogc nothrow;
    /**

	Returns a reference to a newly cloned default colorspaces

	structure.



	The new clone may safely be altered without fear of race

	conditions as the caller is the only reference holder.

*/
    fz_default_colorspaces* fz_clone_default_colorspaces(fz_context*, fz_default_colorspaces*) @nogc nothrow;
    /**

	Retrieve default colorspaces (typically page local).



	If default_cs is non NULL, the default is retrieved from there,

	otherwise the global default is retrieved.



	These return borrowed references that should not be dropped,

	unless they are kept first.

*/
    fz_colorspace* fz_default_gray(fz_context*, const(fz_default_colorspaces)*) @nogc nothrow;

    fz_colorspace* fz_default_rgb(fz_context*, const(fz_default_colorspaces)*) @nogc nothrow;

    fz_colorspace* fz_default_cmyk(fz_context*, const(fz_default_colorspaces)*) @nogc nothrow;

    fz_colorspace* fz_default_output_intent(fz_context*, const(fz_default_colorspaces)*) @nogc nothrow;
    /**

	Set new defaults within the default colorspace structure.



	New references are taken to the new default, and references to

	the old defaults dropped.



	Never throws exceptions.

*/
    void fz_set_default_gray(fz_context*, fz_default_colorspaces*, fz_colorspace*) @nogc nothrow;

    void fz_set_default_rgb(fz_context*, fz_default_colorspaces*, fz_colorspace*) @nogc nothrow;

    void fz_set_default_cmyk(fz_context*, fz_default_colorspaces*, fz_colorspace*) @nogc nothrow;

    void fz_set_default_output_intent(fz_context*, fz_default_colorspaces*, fz_colorspace*) @nogc nothrow;

    void fz_drop_colorspace_imp(fz_context*, fz_storable*) @nogc nothrow;

    void fz_print_stext_header_as_xhtml(fz_context*, fz_output*) @nogc nothrow;

    alias fz_deflate_level = _Anonymous_33;

    enum _Anonymous_33
    {

        FZ_DEFLATE_NONE = 0,

        FZ_DEFLATE_BEST_SPEED = 1,

        FZ_DEFLATE_BEST = 9,

        FZ_DEFLATE_DEFAULT = -1,
    }
    enum FZ_DEFLATE_NONE = _Anonymous_33.FZ_DEFLATE_NONE;
    enum FZ_DEFLATE_BEST_SPEED = _Anonymous_33.FZ_DEFLATE_BEST_SPEED;
    enum FZ_DEFLATE_BEST = _Anonymous_33.FZ_DEFLATE_BEST;
    enum FZ_DEFLATE_DEFAULT = _Anonymous_33.FZ_DEFLATE_DEFAULT;
    /**

	Returns the upper bound on the

	size of flated data of length size.

 */
    ulong fz_deflate_bound(fz_context*, ulong) @nogc nothrow;
    /**

	Compress source_length bytes of data starting

	at source, into a buffer of length *destLen, starting at dest.

	*compressed_length will be updated on exit to contain the size

	actually used.

 */
    void fz_deflate(fz_context*, ubyte*, ulong*, const(ubyte)*, ulong, fz_deflate_level) @nogc nothrow;
    /**

	Compress source_length bytes of data starting

	at source, into a new memory block malloced for that purpose.

	*compressed_length is updated on exit to contain the size used.

	Ownership of the block is returned from this function, and the

	caller is therefore responsible for freeing it. The block may be

	considerably larger than is actually required. The caller is

	free to fz_realloc it down if it wants to.

*/
    ubyte* fz_new_deflated_data(fz_context*, ulong*, const(ubyte)*, ulong, fz_deflate_level) @nogc nothrow;
    /**

	Compress the contents of a fz_buffer into a

	new block malloced for that purpose. *compressed_length is

	updated on exit to contain the size used. Ownership of the block

	is returned from this function, and the caller is therefore

	responsible for freeing it. The block may be considerably larger

	than is actually required. The caller is free to fz_realloc it

	down if it wants to.

*/
    ubyte* fz_new_deflated_data_from_buffer(fz_context*, ulong*, fz_buffer*, fz_deflate_level) @nogc nothrow;
    /**

	Compress bitmap data as CCITT Group 3 1D fax image.

	Creates a stream assuming the default PDF parameters,

	except the number of columns.

*/
    fz_buffer* fz_compress_ccitt_fax_g3(fz_context*, const(ubyte)*, int, int) @nogc nothrow;
    /**

	Compress bitmap data as CCITT Group 4 2D fax image.

	Creates a stream assuming the default PDF parameters, except

	K=-1 and the number of columns.

*/
    fz_buffer* fz_compress_ccitt_fax_g4(fz_context*, const(ubyte)*, int, int) @nogc nothrow;
    /**

	Output structured text to a file in XHTML (semantic) format.

*/
    void fz_print_stext_page_as_xhtml(fz_context*, fz_output*, fz_stext_page*, int) @nogc nothrow;
    /**

	Compression parameters used for buffers of compressed data;

	typically for the source data for images.

*/
    struct fz_compression_params
    {

        int type;

        static union _Anonymous_34
        {

            static struct _Anonymous_35
            {

                int color_transform;
            }

            _Anonymous_35 jpeg;

            static struct _Anonymous_36
            {

                int smask_in_data;
            }

            _Anonymous_36 jpx;

            static struct _Anonymous_37
            {

                fz_jbig2_globals* globals;

                int embedded;
            }

            _Anonymous_37 jbig2;

            static struct _Anonymous_38
            {

                int columns;

                int rows;

                int k;

                int end_of_line;

                int encoded_byte_align;

                int end_of_block;

                int black_is_1;

                int damaged_rows_before_error;
            }

            _Anonymous_38 fax;

            static struct _Anonymous_39
            {

                int columns;

                int colors;

                int predictor;

                int bpc;
            }

            _Anonymous_39 flate;

            static struct _Anonymous_40
            {

                int columns;

                int colors;

                int predictor;

                int bpc;

                int early_change;
            }

            _Anonymous_40 lzw;
        }

        _Anonymous_34 u;
    }
    /**

	Buffers of compressed data; typically for the source data

	for images.

*/
    struct fz_compressed_buffer
    {

        fz_compression_params params;

        fz_buffer* buffer;
    }
    /**

	Return the storage size used for a buffer and its data.

	Used in implementing store handling.



	Never throws exceptions.

*/
    ulong fz_compressed_buffer_size(fz_compressed_buffer*) @nogc nothrow;
    /**

	Open a stream to read the decompressed version of a buffer.

*/
    fz_stream* fz_open_compressed_buffer(fz_context*, fz_compressed_buffer*) @nogc nothrow;
    /**

	Open a stream to read the decompressed version of a buffer,

	with optional log2 subsampling.



	l2factor = NULL for no subsampling, or a pointer to an integer

	containing the maximum log2 subsample factor acceptable (0 =

	none, 1 = halve dimensions, 2 = quarter dimensions etc). If

	non-NULL, then *l2factor will be updated on exit with the actual

	log2 subsample factor achieved.

*/
    fz_stream* fz_open_image_decomp_stream_from_buffer(fz_context*, fz_compressed_buffer*, int*) @nogc nothrow;
    /**

	Open a stream to read the decompressed version of another stream

	with optional log2 subsampling.

*/
    fz_stream* fz_open_image_decomp_stream(fz_context*, fz_stream*, fz_compression_params*, int*) @nogc nothrow;
    /**

	Recognise image format strings in the first 8 bytes from image

	data.

*/
    int fz_recognize_image_format(fz_context*, ubyte*) @nogc nothrow;

    enum _Anonymous_41
    {

        FZ_IMAGE_UNKNOWN = 0,

        FZ_IMAGE_RAW = 1,

        FZ_IMAGE_FAX = 2,

        FZ_IMAGE_FLATE = 3,

        FZ_IMAGE_LZW = 4,

        FZ_IMAGE_RLD = 5,

        FZ_IMAGE_BMP = 6,

        FZ_IMAGE_GIF = 7,

        FZ_IMAGE_JBIG2 = 8,

        FZ_IMAGE_JPEG = 9,

        FZ_IMAGE_JPX = 10,

        FZ_IMAGE_JXR = 11,

        FZ_IMAGE_PNG = 12,

        FZ_IMAGE_PNM = 13,

        FZ_IMAGE_TIFF = 14,
    }
    enum FZ_IMAGE_UNKNOWN = _Anonymous_41.FZ_IMAGE_UNKNOWN;
    enum FZ_IMAGE_RAW = _Anonymous_41.FZ_IMAGE_RAW;
    enum FZ_IMAGE_FAX = _Anonymous_41.FZ_IMAGE_FAX;
    enum FZ_IMAGE_FLATE = _Anonymous_41.FZ_IMAGE_FLATE;
    enum FZ_IMAGE_LZW = _Anonymous_41.FZ_IMAGE_LZW;
    enum FZ_IMAGE_RLD = _Anonymous_41.FZ_IMAGE_RLD;
    enum FZ_IMAGE_BMP = _Anonymous_41.FZ_IMAGE_BMP;
    enum FZ_IMAGE_GIF = _Anonymous_41.FZ_IMAGE_GIF;
    enum FZ_IMAGE_JBIG2 = _Anonymous_41.FZ_IMAGE_JBIG2;
    enum FZ_IMAGE_JPEG = _Anonymous_41.FZ_IMAGE_JPEG;
    enum FZ_IMAGE_JPX = _Anonymous_41.FZ_IMAGE_JPX;
    enum FZ_IMAGE_JXR = _Anonymous_41.FZ_IMAGE_JXR;
    enum FZ_IMAGE_PNG = _Anonymous_41.FZ_IMAGE_PNG;
    enum FZ_IMAGE_PNM = _Anonymous_41.FZ_IMAGE_PNM;
    enum FZ_IMAGE_TIFF = _Anonymous_41.FZ_IMAGE_TIFF;
    /**

	Drop a reference to a compressed buffer. Destroys the buffer

	and frees any storage/other references held by it.



	Never throws exceptions.

*/
    void fz_drop_compressed_buffer(fz_context*, fz_compressed_buffer*) @nogc nothrow;

    void fz_print_stext_trailer_as_html(fz_context*, fz_output*) @nogc nothrow;

    void fz_print_stext_header_as_html(fz_context*, fz_output*) @nogc nothrow;
    /**

	Output structured text to a file in HTML (visual) format.

*/
    void fz_print_stext_page_as_html(fz_context*, fz_output*, fz_stext_page*, int) @nogc nothrow;

    void fz_drop_stext_page(fz_context*, fz_stext_page*) @nogc nothrow;
    /**

	Create an empty text page.



	The text page is filled out by the text device to contain the

	blocks and lines of text on the page.



	mediabox: optional mediabox information.

*/
    fz_stext_page* fz_new_stext_page(fz_context*, fz_rect) @nogc nothrow;

    extern __gshared const(char)* fz_stext_options_usage;

    enum _Anonymous_42
    {

        FZ_STEXT_BLOCK_TEXT = 0,

        FZ_STEXT_BLOCK_IMAGE = 1,
    }
    enum FZ_STEXT_BLOCK_TEXT = _Anonymous_42.FZ_STEXT_BLOCK_TEXT;
    enum FZ_STEXT_BLOCK_IMAGE = _Anonymous_42.FZ_STEXT_BLOCK_IMAGE;
    /**

	A text page is a list of blocks, together with an overall

	bounding box.

*/
    struct fz_stext_page
    {

        fz_pool* pool;

        fz_rect mediabox;

        fz_stext_block* first_block;

        fz_stext_block* last_block;
    }
    /**

	FZ_STEXT_PRESERVE_LIGATURES: If this option is activated

	ligatures are passed through to the application in their

	original form. If this option is deactivated ligatures are

	expanded into their constituent parts, e.g. the ligature ffi is

	expanded into three separate characters f, f and i.



	FZ_STEXT_PRESERVE_WHITESPACE: If this option is activated

	whitespace is passed through to the application in its original

	form. If this option is deactivated any type of horizontal

	whitespace (including horizontal tabs) will be replaced with

	space characters of variable width.



	FZ_STEXT_PRESERVE_IMAGES: If this option is set, then images

	will be stored in the structured text structure. The default is

	to ignore all images.



	FZ_STEXT_INHIBIT_SPACES: If this option is set, we will not try

	to add missing space characters where there are large gaps

	between characters.



	FZ_STEXT_DEHYPHENATE: If this option is set, hyphens at the

	end of a line will be removed and the lines will be merged.



	FZ_STEXT_PRESERVE_SPANS: If this option is set, spans on the same line

	will not be merged. Each line will thus be a span of text with the same

	font, colour, and size.



	FZ_STEXT_MEDIABOX_CLIP: If this option is set, characters entirely

	outside each page's mediabox will be ignored.

*/
    enum _Anonymous_43
    {

        FZ_STEXT_PRESERVE_LIGATURES = 1,

        FZ_STEXT_PRESERVE_WHITESPACE = 2,

        FZ_STEXT_PRESERVE_IMAGES = 4,

        FZ_STEXT_INHIBIT_SPACES = 8,

        FZ_STEXT_DEHYPHENATE = 16,

        FZ_STEXT_PRESERVE_SPANS = 32,

        FZ_STEXT_MEDIABOX_CLIP = 64,
    }
    enum FZ_STEXT_PRESERVE_LIGATURES = _Anonymous_43.FZ_STEXT_PRESERVE_LIGATURES;
    enum FZ_STEXT_PRESERVE_WHITESPACE = _Anonymous_43.FZ_STEXT_PRESERVE_WHITESPACE;
    enum FZ_STEXT_PRESERVE_IMAGES = _Anonymous_43.FZ_STEXT_PRESERVE_IMAGES;
    enum FZ_STEXT_INHIBIT_SPACES = _Anonymous_43.FZ_STEXT_INHIBIT_SPACES;
    enum FZ_STEXT_DEHYPHENATE = _Anonymous_43.FZ_STEXT_DEHYPHENATE;
    enum FZ_STEXT_PRESERVE_SPANS = _Anonymous_43.FZ_STEXT_PRESERVE_SPANS;
    enum FZ_STEXT_MEDIABOX_CLIP = _Anonymous_43.FZ_STEXT_MEDIABOX_CLIP;
    /**

	A text block is a list of lines of text (typically a paragraph),

	or an image.

*/
    struct fz_stext_block
    {

        int type;

        fz_rect bbox;

        static union _Anonymous_44
        {

            static struct _Anonymous_45
            {

                fz_stext_line* first_line;

                fz_stext_line* last_line;
            }

            _Anonymous_45 t;

            static struct _Anonymous_46
            {

                fz_matrix transform;

                fz_image* image;
            }

            _Anonymous_46 i;
        }

        _Anonymous_44 u;

        fz_stext_block* prev;

        fz_stext_block* next;
    }
    /**

	A text line is a list of characters that share a common baseline.

*/
    struct fz_stext_line
    {

        int wmode;

        fz_point dir;

        fz_rect bbox;

        fz_stext_char* first_char;

        fz_stext_char* last_char;

        fz_stext_line* prev;

        fz_stext_line* next;
    }
    /**

	A text char is a unicode character, the style in which is

	appears, and the point at which it is positioned.

*/
    struct fz_stext_char
    {

        int c;

        int color;

        fz_point origin;

        fz_quad quad;

        float size;

        fz_font* font;

        fz_stext_char* next;
    }
    /**

	Add a new char to the line at the end of the layout block.

*/
    void fz_add_layout_char(fz_context*, fz_layout_block*, float, float, const(char)*) @nogc nothrow;
    /**

	Add a new line to the end of the layout block.

*/
    void fz_add_layout_line(fz_context*, fz_layout_block*, float, float, float, const(char)*) @nogc nothrow;
    /**

	Drop layout block. Free the pool, and linked blocks.



	Never throws exceptions.

*/
    void fz_drop_layout(fz_context*, fz_layout_block*) @nogc nothrow;
    /**

	Create a new layout block, with new allocation pool, zero

	matrices, and initialise linked pointers.

*/
    fz_layout_block* fz_new_layout(fz_context*) @nogc nothrow;
    struct fz_font_context;
    struct fz_colorspace_context;
    struct fz_style_context;
    struct fz_tuning_context;
    struct fz_store;
    struct fz_glyph_cache;
    struct fz_document_handler_context;

    struct fz_output
    {

        void* state;

        void function(fz_context*, void*, const(void)*, ulong) write;

        void function(fz_context*, void*, long, int) seek;

        long function(fz_context*, void*) tell;

        void function(fz_context*, void*) close;

        void function(fz_context*, void*) drop;

        fz_stream* function(fz_context*, void*) as_stream;

        void function(fz_context*, void*) truncate;

        char* bp;

        char* wp;

        char* ep;

        int buffered;

        int bits;
    }

    struct fz_context
    {

        void* user;

        fz_alloc_context alloc;

        fz_locks_context locks;

        fz_error_context error;

        fz_warn_context warn;

        fz_aa_context aa;

        ushort[7] seed48;

        int icc_enabled;

        int throw_on_repair;

        fz_document_handler_context* handler;

        fz_style_context* style;

        fz_tuning_context* tuning;

        fz_output* stddbg;

        fz_font_context* font;

        fz_colorspace_context* colorspace;

        fz_store* store;

        fz_glyph_cache* glyph_cache;
    }
    /**

	Allocator structure; holds callbacks and private data pointer.

*/
    struct fz_alloc_context
    {

        void* user;

        void* function(void*, ulong) malloc;

        void* function(void*, void*, ulong) realloc;

        void function(void*, void*) free;
    }

    struct fz_layout_block
    {

        fz_pool* pool;

        fz_matrix matrix;

        fz_matrix inv_matrix;

        fz_layout_line* head;

        fz_layout_line** tailp;

        fz_layout_char** text_tailp;
    }

    struct fz_layout_line
    {

        float x;

        float y;

        float font_size;

        const(char)* p;

        fz_layout_char* text;

        fz_layout_line* next;
    }

    void fz_vthrow(fz_context*, int, const(char)*, char*) @nogc nothrow;

    void fz_throw(fz_context*, int, const(char)*) @nogc nothrow;

    void fz_rethrow(fz_context*) @nogc nothrow;

    void fz_vwarn(fz_context*, const(char)*, char*) @nogc nothrow;

    void fz_warn(fz_context*, const(char)*, ...) @nogc nothrow;

    const(char)* fz_caught_message(fz_context*) @nogc nothrow;

    int fz_caught(fz_context*) @nogc nothrow;

    void fz_rethrow_if(fz_context*, int) @nogc nothrow;

    void fz_start_throw_on_repair(fz_context*) @nogc nothrow;

    void fz_end_throw_on_repair(fz_context*) @nogc nothrow;

    enum _Anonymous_47
    {

        FZ_ERROR_NONE = 0,

        FZ_ERROR_MEMORY = 1,

        FZ_ERROR_GENERIC = 2,

        FZ_ERROR_SYNTAX = 3,

        FZ_ERROR_MINOR = 4,

        FZ_ERROR_TRYLATER = 5,

        FZ_ERROR_ABORT = 6,

        FZ_ERROR_REPAIRED = 7,

        FZ_ERROR_COUNT = 8,
    }
    enum FZ_ERROR_NONE = _Anonymous_47.FZ_ERROR_NONE;
    enum FZ_ERROR_MEMORY = _Anonymous_47.FZ_ERROR_MEMORY;
    enum FZ_ERROR_GENERIC = _Anonymous_47.FZ_ERROR_GENERIC;
    enum FZ_ERROR_SYNTAX = _Anonymous_47.FZ_ERROR_SYNTAX;
    enum FZ_ERROR_MINOR = _Anonymous_47.FZ_ERROR_MINOR;
    enum FZ_ERROR_TRYLATER = _Anonymous_47.FZ_ERROR_TRYLATER;
    enum FZ_ERROR_ABORT = _Anonymous_47.FZ_ERROR_ABORT;
    enum FZ_ERROR_REPAIRED = _Anonymous_47.FZ_ERROR_REPAIRED;
    enum FZ_ERROR_COUNT = _Anonymous_47.FZ_ERROR_COUNT;
    /**

	Flush any repeated warnings.



	Repeated warnings are buffered, counted and eventually printed

	along with the number of repetitions. Call fz_flush_warnings

	to force printing of the latest buffered warning and the

	number of repetitions, for example to make sure that all

	warnings are printed before exiting an application.

*/
    void fz_flush_warnings(fz_context*) @nogc nothrow;
    /**

	Locking functions



	MuPDF is kept deliberately free of any knowledge of particular

	threading systems. As such, in order for safe multi-threaded

	operation, we rely on callbacks to client provided functions.



	A client is expected to provide FZ_LOCK_MAX number of mutexes,

	and a function to lock/unlock each of them. These may be

	recursive mutexes, but do not have to be.



	If a client does not intend to use multiple threads, then it

	may pass NULL instead of a lock structure.



	In order to avoid deadlocks, we have one simple rule

	internally as to how we use locks: We can never take lock n

	when we already hold any lock i, where 0 <= i <= n. In order

	to verify this, we have some debugging code, that can be

	enabled by defining FITZ_DEBUG_LOCKING.

*/
    struct fz_locks_context
    {

        void* user;

        void function(void*, int) lock;

        void function(void*, int) unlock;
    }

    enum _Anonymous_48
    {

        FZ_LOCK_ALLOC = 0,

        FZ_LOCK_FREETYPE = 1,

        FZ_LOCK_GLYPHCACHE = 2,

        FZ_LOCK_MAX = 3,
    }
    enum FZ_LOCK_ALLOC = _Anonymous_48.FZ_LOCK_ALLOC;
    enum FZ_LOCK_FREETYPE = _Anonymous_48.FZ_LOCK_FREETYPE;
    enum FZ_LOCK_GLYPHCACHE = _Anonymous_48.FZ_LOCK_GLYPHCACHE;
    enum FZ_LOCK_MAX = _Anonymous_48.FZ_LOCK_MAX;
    /**

	Simple text layout (for use with annotation editing primarily).

*/
    struct fz_layout_char
    {

        float x;

        float advance;

        const(char)* p;

        fz_layout_char* next;
    }

    void fz_assert_lock_held(fz_context*, int) @nogc nothrow;

    void fz_assert_lock_not_held(fz_context*, int) @nogc nothrow;

    void fz_lock_debug_lock(fz_context*, int) @nogc nothrow;

    void fz_lock_debug_unlock(fz_context*, int) @nogc nothrow;
    /**

	Specifies the maximum size in bytes of the resource store in

	fz_context. Given as argument to fz_new_context.



	FZ_STORE_UNLIMITED: Let resource store grow unbounded.



	FZ_STORE_DEFAULT: A reasonable upper bound on the size, for

	devices that are not memory constrained.

*/
    enum _Anonymous_49
    {

        FZ_STORE_UNLIMITED = 0,

        FZ_STORE_DEFAULT = 268435456,
    }
    enum FZ_STORE_UNLIMITED = _Anonymous_49.FZ_STORE_UNLIMITED;
    enum FZ_STORE_DEFAULT = _Anonymous_49.FZ_STORE_DEFAULT;
    /**

	Make a clone of an existing context.



	This function is meant to be used in multi-threaded

	applications where each thread requires its own context, yet

	parts of the global state, for example caching, are shared.



	ctx: Context obtained from fz_new_context to make a copy of.

	ctx must have had locks and lock/functions setup when created.

	The two contexts will share the memory allocator, resource

	store, locks and lock/unlock functions. They will each have

	their own exception stacks though.



	May return NULL.

*/
    fz_context* fz_clone_context(fz_context*) @nogc nothrow;
    /**

	Free a context and its global state.



	The context and all of its global state is freed, and any

	buffered warnings are flushed (see fz_flush_warnings). If NULL

	is passed in nothing will happen.



	Must not be called for a context that is being used in an active

	fz_try(), fz_always() or fz_catch() block.

*/
    void fz_drop_context(fz_context*) @nogc nothrow;
    /**

	Set the user field in the context.



	NULL initially, this field can be set to any opaque value

	required by the user. It is copied on clones.

*/
    void fz_set_user_context(fz_context*, void*) @nogc nothrow;
    /**

	Read the user field from the context.

*/
    void* fz_user_context(fz_context*) @nogc nothrow;
    /**

	FIXME: Better not to expose fz_default_error_callback, and

	fz_default_warning callback and to allow 'NULL' to be used

	int fz_set_xxxx_callback to mean "defaults".



	FIXME: Do we need/want functions like

	fz_error_callback(ctx, message) to allow callers to inject

	stuff into the error/warning streams?

*/
/**

	The default error callback. Declared publicly just so that the

	error callback can be set back to this after it has been

	overridden.

*/
    void fz_default_error_callback(void*, const(char)*) @nogc nothrow;
    /**

	The default warning callback. Declared publicly just so that

	the warning callback can be set back to this after it has been

	overridden.

*/
    void fz_default_warning_callback(void*, const(char)*) @nogc nothrow;
    alias fz_error_cb = void function(void*, const(char)*);
    alias fz_warning_cb = void function(void*, const(char)*);
    /**

	Set the error callback. This will be called as part of the

	exception handling.



	The callback must not throw exceptions!

*/
    void fz_set_error_callback(fz_context*, void function(void*, const(char)*), void*) @nogc nothrow;
    /**

	Retrieve the currently set error callback, or NULL if none

	has been set. Optionally, if user is non-NULL, the user pointer

	given when the warning callback was set is also passed back to

	the caller.

*/
    void function(void*, const(char)*) fz_error_callback(fz_context*, void**) @nogc nothrow;
    /**

	Set the warning callback. This will be called as part of the

	exception handling.



	The callback must not throw exceptions!

*/
    void fz_set_warning_callback(fz_context*, void function(void*, const(char)*), void*) @nogc nothrow;
    /**

	Retrieve the currently set warning callback, or NULL if none

	has been set. Optionally, if user is non-NULL, the user pointer

	given when the warning callback was set is also passed back to

	the caller.

*/
    void function(void*, const(char)*) fz_warning_callback(fz_context*, void**) @nogc nothrow;
    alias fz_tune_image_decode_fn = void function(void*, int, int, int, fz_irect*);
    alias fz_tune_image_scale_fn = int function(void*, int, int, int, int);
    /**

	Set the tuning function to use for

	image decode.



	image_decode: Function to use.



	arg: Opaque argument to be passed to tuning function.

*/
    void fz_tune_image_decode(fz_context*, void function(void*, int, int, int, fz_irect*), void*) @nogc nothrow;
    /**

	Set the tuning function to use for

	image scaling.



	image_scale: Function to use.



	arg: Opaque argument to be passed to tuning function.

*/
    void fz_tune_image_scale(fz_context*, int function(void*, int, int, int, int), void*) @nogc nothrow;
    /**

	Get the number of bits of antialiasing we are

	using (for graphics). Between 0 and 8.

*/
    int fz_aa_level(fz_context*) @nogc nothrow;
    /**

	Set the number of bits of antialiasing we should

	use (for both text and graphics).



	bits: The number of bits of antialiasing to use (values are

	clamped to within the 0 to 8 range).

*/
    void fz_set_aa_level(fz_context*, int) @nogc nothrow;
    /**

	Get the number of bits of antialiasing we are

	using for text. Between 0 and 8.

*/
    int fz_text_aa_level(fz_context*) @nogc nothrow;
    /**

	Set the number of bits of antialiasing we

	should use for text.



	bits: The number of bits of antialiasing to use (values are

	clamped to within the 0 to 8 range).

*/
    void fz_set_text_aa_level(fz_context*, int) @nogc nothrow;
    /**

	Get the number of bits of antialiasing we are

	using for graphics. Between 0 and 8.

*/
    int fz_graphics_aa_level(fz_context*) @nogc nothrow;
    /**

	Set the number of bits of antialiasing we

	should use for graphics.



	bits: The number of bits of antialiasing to use (values are

	clamped to within the 0 to 8 range).

*/
    void fz_set_graphics_aa_level(fz_context*, int) @nogc nothrow;
    /**

	Get the minimum line width to be

	used for stroked lines.



	min_line_width: The minimum line width to use (in pixels).

*/
    float fz_graphics_min_line_width(fz_context*) @nogc nothrow;
    /**

	Set the minimum line width to be

	used for stroked lines.



	min_line_width: The minimum line width to use (in pixels).

*/
    void fz_set_graphics_min_line_width(fz_context*, float) @nogc nothrow;
    /**

	Get the user stylesheet source text.

*/
    const(char)* fz_user_css(fz_context*) @nogc nothrow;
    /**

	Set the user stylesheet source text for use with HTML and EPUB.

*/
    void fz_set_user_css(fz_context*, const(char)*) @nogc nothrow;
    /**

	Return whether to respect document styles in HTML and EPUB.

*/
    int fz_use_document_css(fz_context*) @nogc nothrow;
    /**

	Toggle whether to respect document styles in HTML and EPUB.

*/
    void fz_set_use_document_css(fz_context*, int) @nogc nothrow;
    /**

	Enable icc profile based operation.

*/
    void fz_enable_icc(fz_context*) @nogc nothrow;
    /**

	Disable icc profile based operation.

*/
    void fz_disable_icc(fz_context*) @nogc nothrow;
    /**

	Allocate uninitialized memory of a given size.

	Does NOT clear the memory!



	May return NULL for size = 0.



	Throws exception in the event of failure to allocate.

*/
    void* fz_malloc(fz_context*, ulong) @nogc nothrow;
    /**

	Allocate array of memory of count entries of size bytes.

	Clears the memory to zero.



	Throws exception in the event of failure to allocate.

*/
    void* fz_calloc(fz_context*, ulong, ulong) @nogc nothrow;
    /**

	Reallocates a block of memory to given size. Existing contents

	up to min(old_size,new_size) are maintained. The rest of the

	block is uninitialised.



	fz_realloc(ctx, NULL, size) behaves like fz_malloc(ctx, size).



	fz_realloc(ctx, p, 0); behaves like fz_free(ctx, p).



	Throws exception in the event of failure to allocate.

*/
    void* fz_realloc(fz_context*, void*, ulong) @nogc nothrow;
    /**

	Free a previously allocated block of memory.



	fz_free(ctx, NULL) does nothing.



	Never throws exceptions.

*/
    void fz_free(fz_context*, void*) @nogc nothrow;
    /**

	fz_malloc equivalent that returns NULL rather than throwing

	exceptions.

*/
    void* fz_malloc_no_throw(fz_context*, ulong) @nogc nothrow;
    /**

	fz_calloc equivalent that returns NULL rather than throwing

	exceptions.

*/
    void* fz_calloc_no_throw(fz_context*, ulong, ulong) @nogc nothrow;
    /**

	fz_realloc equivalent that returns NULL rather than throwing

	exceptions.

*/
    void* fz_realloc_no_throw(fz_context*, void*, ulong) @nogc nothrow;
    /**

	Portable strdup implementation, using fz allocators.

*/
    char* fz_strdup(fz_context*, const(char)*) @nogc nothrow;
    /**

	Fill block with len bytes of pseudo-randomness.

*/
    void fz_memrnd(fz_context*, ubyte*, int) @nogc nothrow;

    void fz_var_imp(void*) @nogc nothrow;

    _SETJMP_FLOAT128** fz_push_try(fz_context*) @nogc nothrow;

    int fz_do_try(fz_context*) @nogc nothrow;

    int fz_do_always(fz_context*) @nogc nothrow;

    int fz_do_catch(fz_context*) @nogc nothrow;

    struct fz_error_stack_slot
    {

        _SETJMP_FLOAT128[16] buffer;

        int state;

        int code;

        char[24] padding;
    }

    struct fz_error_context
    {

        fz_error_stack_slot* top;

        fz_error_stack_slot[256] stack;

        fz_error_stack_slot padding;

        fz_error_stack_slot* stack_base;

        int errcode;

        void* print_user;

        void function(void*, const(char)*) print;

        char[256] message;
    }

    struct fz_warn_context
    {

        void* print_user;

        void function(void*, const(char)*) print;

        int count;

        char[256] message;
    }

    struct fz_aa_context
    {

        int hscale;

        int vscale;

        int scale;

        int bits;

        int text_bits;

        float min_line_width;
    }

    fz_context* fz_new_context_imp(const(fz_alloc_context)*, const(fz_locks_context)*, ulong, const(char)*) @nogc nothrow;
    /**

	Structure definition is public to enable stack

	based allocation. Do not access the members directly.

*/
    struct fz_md5
    {

        uint lo;

        uint hi;

        uint a;

        uint b;

        uint c;

        uint d;

        ubyte[64] buffer;
    }
    /**

	MD5 initialization. Begins an MD5 operation, writing a new

	context.



	Never throws an exception.

*/
    void fz_md5_init(fz_md5*) @nogc nothrow;
    /**

	MD5 block update operation. Continues an MD5 message-digest

	operation, processing another message block, and updating the

	context.



	Never throws an exception.

*/
    void fz_md5_update(fz_md5*, const(ubyte)*, ulong) @nogc nothrow;
    /**

	MD5 block update operation. Continues an MD5 message-digest

	operation, processing an int64, and updating the context.



	Never throws an exception.

*/
    void fz_md5_update_int64(fz_md5*, long) @nogc nothrow;
    /**

	MD5 finalization. Ends an MD5 message-digest operation, writing

	the message digest and zeroizing the context.



	Never throws an exception.

*/
    void fz_md5_final(fz_md5*, ubyte*) @nogc nothrow;
    /**

	Structure definition is public to enable stack

	based allocation. Do not access the members directly.

*/
    struct fz_sha256
    {

        uint[8] state;

        uint[2] count;

        static union _Anonymous_50
        {

            ubyte[64] u8;

            uint[16] u32;
        }

        _Anonymous_50 buffer;
    }
    /**

	SHA256 initialization. Begins an SHA256 operation, initialising

	the supplied context.



	Never throws an exception.

*/
    void fz_sha256_init(fz_sha256*) @nogc nothrow;
    /**

	SHA256 block update operation. Continues an SHA256 message-

	digest operation, processing another message block, and updating

	the context.



	Never throws an exception.

*/
    void fz_sha256_update(fz_sha256*, const(ubyte)*, ulong) @nogc nothrow;
    /**

	MD5 finalization. Ends an MD5 message-digest operation, writing

	the message digest and zeroizing the context.



	Never throws an exception.

*/
    void fz_sha256_final(fz_sha256*, ubyte*) @nogc nothrow;
    /**

	Structure definition is public to enable stack

	based allocation. Do not access the members directly.

*/
    struct fz_sha512
    {

        ulong[8] state;

        uint[2] count;

        static union _Anonymous_51
        {

            ubyte[128] u8;

            ulong[16] u64;
        }

        _Anonymous_51 buffer;
    }
    /**

	SHA512 initialization. Begins an SHA512 operation, initialising

	the supplied context.



	Never throws an exception.

*/
    void fz_sha512_init(fz_sha512*) @nogc nothrow;
    /**

	SHA512 block update operation. Continues an SHA512 message-

	digest operation, processing another message block, and updating

	the context.



	Never throws an exception.

*/
    void fz_sha512_update(fz_sha512*, const(ubyte)*, ulong) @nogc nothrow;
    /**

	SHA512 finalization. Ends an SHA512 message-digest operation,

	writing the message digest and zeroizing the context.



	Never throws an exception.

*/
    void fz_sha512_final(fz_sha512*, ubyte*) @nogc nothrow;

    alias fz_sha384 = fz_sha512;
    /**

	SHA384 initialization. Begins an SHA384 operation, initialising

	the supplied context.



	Never throws an exception.

*/
    void fz_sha384_init(fz_sha512*) @nogc nothrow;
    /**

	SHA384 block update operation. Continues an SHA384 message-

	digest operation, processing another message block, and updating

	the context.



	Never throws an exception.

*/
    void fz_sha384_update(fz_sha512*, const(ubyte)*, ulong) @nogc nothrow;
    /**

	SHA384 finalization. Ends an SHA384 message-digest operation,

	writing the message digest and zeroizing the context.



	Never throws an exception.

*/
    void fz_sha384_final(fz_sha512*, ubyte*) @nogc nothrow;
    /**

	Structure definition is public to enable stack

	based allocation. Do not access the members directly.

*/
    struct fz_arc4
    {

        uint x;

        uint y;

        ubyte[256] state;
    }
    /**

	RC4 initialization. Begins an RC4 operation, writing a new

	context.



	Never throws an exception.

*/
    void fz_arc4_init(fz_arc4*, const(ubyte)*, ulong) @nogc nothrow;
    /**

	RC4 block encrypt operation; encrypt src into dst (both of

	length len) updating the RC4 state as we go.



	Never throws an exception.

*/
    void fz_arc4_encrypt(fz_arc4*, ubyte*, const(ubyte)*, ulong) @nogc nothrow;
    /**

	RC4 finalization. Zero the context.



	Never throws an exception.

*/
    void fz_arc4_final(fz_arc4*) @nogc nothrow;
    /**

	Structure definitions are public to enable stack

	based allocation. Do not access the members directly.

*/
    struct fz_aes
    {

        int nr;

        uint* rk;

        uint[68] buf;
    }
    /**

	AES encryption intialisation. Fills in the supplied context

	and prepares for encryption using the given key.



	Returns non-zero for error (key size other than 128/192/256).



	Never throws an exception.

*/
    int fz_aes_setkey_enc(fz_aes*, const(ubyte)*, int) @nogc nothrow;
    /**

	AES decryption intialisation. Fills in the supplied context

	and prepares for decryption using the given key.



	Returns non-zero for error (key size other than 128/192/256).



	Never throws an exception.

*/
    int fz_aes_setkey_dec(fz_aes*, const(ubyte)*, int) @nogc nothrow;
    /**

	AES block processing. Encrypts or Decrypts (according to mode,

	which must match what was initially set up) length bytes (which

	must be a multiple of 16), using (and modifying) the insertion

	vector iv, reading from input, and writing to output.



	Never throws an exception.

*/
    void fz_aes_crypt_cbc(fz_aes*, int, ulong, ubyte*, const(ubyte)*, ubyte*) @nogc nothrow;

    enum _Anonymous_52
    {

        FZ_DEVFLAG_MASK = 1,

        FZ_DEVFLAG_COLOR = 2,

        FZ_DEVFLAG_UNCACHEABLE = 4,

        FZ_DEVFLAG_FILLCOLOR_UNDEFINED = 8,

        FZ_DEVFLAG_STROKECOLOR_UNDEFINED = 16,

        FZ_DEVFLAG_STARTCAP_UNDEFINED = 32,

        FZ_DEVFLAG_DASHCAP_UNDEFINED = 64,

        FZ_DEVFLAG_ENDCAP_UNDEFINED = 128,

        FZ_DEVFLAG_LINEJOIN_UNDEFINED = 256,

        FZ_DEVFLAG_MITERLIMIT_UNDEFINED = 512,

        FZ_DEVFLAG_LINEWIDTH_UNDEFINED = 1024,

        FZ_DEVFLAG_BBOX_DEFINED = 2048,

        FZ_DEVFLAG_GRIDFIT_AS_TILED = 4096,
    }
    enum FZ_DEVFLAG_MASK = _Anonymous_52.FZ_DEVFLAG_MASK;
    enum FZ_DEVFLAG_COLOR = _Anonymous_52.FZ_DEVFLAG_COLOR;
    enum FZ_DEVFLAG_UNCACHEABLE = _Anonymous_52.FZ_DEVFLAG_UNCACHEABLE;
    enum FZ_DEVFLAG_FILLCOLOR_UNDEFINED = _Anonymous_52.FZ_DEVFLAG_FILLCOLOR_UNDEFINED;
    enum FZ_DEVFLAG_STROKECOLOR_UNDEFINED = _Anonymous_52.FZ_DEVFLAG_STROKECOLOR_UNDEFINED;
    enum FZ_DEVFLAG_STARTCAP_UNDEFINED = _Anonymous_52.FZ_DEVFLAG_STARTCAP_UNDEFINED;
    enum FZ_DEVFLAG_DASHCAP_UNDEFINED = _Anonymous_52.FZ_DEVFLAG_DASHCAP_UNDEFINED;
    enum FZ_DEVFLAG_ENDCAP_UNDEFINED = _Anonymous_52.FZ_DEVFLAG_ENDCAP_UNDEFINED;
    enum FZ_DEVFLAG_LINEJOIN_UNDEFINED = _Anonymous_52.FZ_DEVFLAG_LINEJOIN_UNDEFINED;
    enum FZ_DEVFLAG_MITERLIMIT_UNDEFINED = _Anonymous_52.FZ_DEVFLAG_MITERLIMIT_UNDEFINED;
    enum FZ_DEVFLAG_LINEWIDTH_UNDEFINED = _Anonymous_52.FZ_DEVFLAG_LINEWIDTH_UNDEFINED;
    enum FZ_DEVFLAG_BBOX_DEFINED = _Anonymous_52.FZ_DEVFLAG_BBOX_DEFINED;
    enum FZ_DEVFLAG_GRIDFIT_AS_TILED = _Anonymous_52.FZ_DEVFLAG_GRIDFIT_AS_TILED;

    enum _Anonymous_53
    {

        FZ_BLEND_NORMAL = 0,

        FZ_BLEND_MULTIPLY = 1,

        FZ_BLEND_SCREEN = 2,

        FZ_BLEND_OVERLAY = 3,

        FZ_BLEND_DARKEN = 4,

        FZ_BLEND_LIGHTEN = 5,

        FZ_BLEND_COLOR_DODGE = 6,

        FZ_BLEND_COLOR_BURN = 7,

        FZ_BLEND_HARD_LIGHT = 8,

        FZ_BLEND_SOFT_LIGHT = 9,

        FZ_BLEND_DIFFERENCE = 10,

        FZ_BLEND_EXCLUSION = 11,

        FZ_BLEND_HUE = 12,

        FZ_BLEND_SATURATION = 13,

        FZ_BLEND_COLOR = 14,

        FZ_BLEND_LUMINOSITY = 15,

        FZ_BLEND_MODEMASK = 15,

        FZ_BLEND_ISOLATED = 16,

        FZ_BLEND_KNOCKOUT = 32,
    }
    enum FZ_BLEND_NORMAL = _Anonymous_53.FZ_BLEND_NORMAL;
    enum FZ_BLEND_MULTIPLY = _Anonymous_53.FZ_BLEND_MULTIPLY;
    enum FZ_BLEND_SCREEN = _Anonymous_53.FZ_BLEND_SCREEN;
    enum FZ_BLEND_OVERLAY = _Anonymous_53.FZ_BLEND_OVERLAY;
    enum FZ_BLEND_DARKEN = _Anonymous_53.FZ_BLEND_DARKEN;
    enum FZ_BLEND_LIGHTEN = _Anonymous_53.FZ_BLEND_LIGHTEN;
    enum FZ_BLEND_COLOR_DODGE = _Anonymous_53.FZ_BLEND_COLOR_DODGE;
    enum FZ_BLEND_COLOR_BURN = _Anonymous_53.FZ_BLEND_COLOR_BURN;
    enum FZ_BLEND_HARD_LIGHT = _Anonymous_53.FZ_BLEND_HARD_LIGHT;
    enum FZ_BLEND_SOFT_LIGHT = _Anonymous_53.FZ_BLEND_SOFT_LIGHT;
    enum FZ_BLEND_DIFFERENCE = _Anonymous_53.FZ_BLEND_DIFFERENCE;
    enum FZ_BLEND_EXCLUSION = _Anonymous_53.FZ_BLEND_EXCLUSION;
    enum FZ_BLEND_HUE = _Anonymous_53.FZ_BLEND_HUE;
    enum FZ_BLEND_SATURATION = _Anonymous_53.FZ_BLEND_SATURATION;
    enum FZ_BLEND_COLOR = _Anonymous_53.FZ_BLEND_COLOR;
    enum FZ_BLEND_LUMINOSITY = _Anonymous_53.FZ_BLEND_LUMINOSITY;
    enum FZ_BLEND_MODEMASK = _Anonymous_53.FZ_BLEND_MODEMASK;
    enum FZ_BLEND_ISOLATED = _Anonymous_53.FZ_BLEND_ISOLATED;
    enum FZ_BLEND_KNOCKOUT = _Anonymous_53.FZ_BLEND_KNOCKOUT;
    /**

	Map from (case sensitive) blend mode string to enumeration.

*/
    int fz_lookup_blendmode(const(char)*) @nogc nothrow;
    /**

	Map from enumeration to blend mode string.



	The string is static, with arbitrary lifespan.

*/
    const(char)* fz_blendmode_name(int) @nogc nothrow;
    /**

	Devices can keep track of containers (clips/masks/groups/tiles)

	as they go to save callers having to do it.

*/
    struct fz_device_container_stack
    {

        fz_rect scissor;

        int type;

        int user;
    }

    enum _Anonymous_54
    {

        fz_device_container_stack_is_clip = 0,

        fz_device_container_stack_is_mask = 1,

        fz_device_container_stack_is_group = 2,

        fz_device_container_stack_is_tile = 3,
    }
    enum fz_device_container_stack_is_clip = _Anonymous_54.fz_device_container_stack_is_clip;
    enum fz_device_container_stack_is_mask = _Anonymous_54.fz_device_container_stack_is_mask;
    enum fz_device_container_stack_is_group = _Anonymous_54.fz_device_container_stack_is_group;
    enum fz_device_container_stack_is_tile = _Anonymous_54.fz_device_container_stack_is_tile;
    /**

	Device calls; graphics primitives and containers.

*/
    void fz_fill_path(fz_context*, fz_device*, const(fz_path)*, int, fz_matrix, fz_colorspace*, const(float)*, float, fz_color_params) @nogc nothrow;

    void fz_stroke_path(fz_context*, fz_device*, const(fz_path)*, const(fz_stroke_state)*, fz_matrix, fz_colorspace*, const(float)*, float, fz_color_params) @nogc nothrow;

    void fz_clip_path(fz_context*, fz_device*, const(fz_path)*, int, fz_matrix, fz_rect) @nogc nothrow;

    void fz_clip_stroke_path(fz_context*, fz_device*, const(fz_path)*, const(fz_stroke_state)*, fz_matrix, fz_rect) @nogc nothrow;

    void fz_fill_text(fz_context*, fz_device*, const(fz_text)*, fz_matrix, fz_colorspace*, const(float)*, float, fz_color_params) @nogc nothrow;

    void fz_stroke_text(fz_context*, fz_device*, const(fz_text)*, const(fz_stroke_state)*, fz_matrix, fz_colorspace*, const(float)*, float, fz_color_params) @nogc nothrow;

    void fz_clip_text(fz_context*, fz_device*, const(fz_text)*, fz_matrix, fz_rect) @nogc nothrow;

    void fz_clip_stroke_text(fz_context*, fz_device*, const(fz_text)*, const(fz_stroke_state)*, fz_matrix, fz_rect) @nogc nothrow;

    void fz_ignore_text(fz_context*, fz_device*, const(fz_text)*, fz_matrix) @nogc nothrow;

    void fz_pop_clip(fz_context*, fz_device*) @nogc nothrow;

    void fz_fill_shade(fz_context*, fz_device*, fz_shade*, fz_matrix, float, fz_color_params) @nogc nothrow;

    void fz_fill_image(fz_context*, fz_device*, fz_image*, fz_matrix, float, fz_color_params) @nogc nothrow;

    void fz_fill_image_mask(fz_context*, fz_device*, fz_image*, fz_matrix, fz_colorspace*, const(float)*, float, fz_color_params) @nogc nothrow;

    void fz_clip_image_mask(fz_context*, fz_device*, fz_image*, fz_matrix, fz_rect) @nogc nothrow;

    void fz_begin_mask(fz_context*, fz_device*, fz_rect, int, fz_colorspace*, const(float)*, fz_color_params) @nogc nothrow;

    void fz_end_mask(fz_context*, fz_device*) @nogc nothrow;

    void fz_begin_group(fz_context*, fz_device*, fz_rect, fz_colorspace*, int, int, int, float) @nogc nothrow;

    void fz_end_group(fz_context*, fz_device*) @nogc nothrow;

    void fz_begin_tile(fz_context*, fz_device*, fz_rect, fz_rect, float, float, fz_matrix) @nogc nothrow;

    int fz_begin_tile_id(fz_context*, fz_device*, fz_rect, fz_rect, float, float, fz_matrix, int) @nogc nothrow;

    void fz_end_tile(fz_context*, fz_device*) @nogc nothrow;

    void fz_render_flags(fz_context*, fz_device*, int, int) @nogc nothrow;

    void fz_set_default_colorspaces(fz_context*, fz_device*, fz_default_colorspaces*) @nogc nothrow;

    void fz_begin_layer(fz_context*, fz_device*, const(char)*) @nogc nothrow;

    void fz_end_layer(fz_context*, fz_device*) @nogc nothrow;
    /**

	Devices are created by calls to device implementations, for

	instance: foo_new_device(). These will be implemented by calling

	fz_new_derived_device(ctx, foo_device) where foo_device is a

	structure "derived from" fz_device, for instance

	typedef struct { fz_device base;  ...extras...} foo_device;

*/
    fz_device* fz_new_device_of_size(fz_context*, int) @nogc nothrow;

    int fz_toupper(int) @nogc nothrow;
    /**

	Signal the end of input, and flush any buffered output.

	This is NOT called implicitly on fz_drop_device. This

	may throw exceptions.

*/
    void fz_close_device(fz_context*, fz_device*) @nogc nothrow;
    /**

	Reduce the reference count on a device. When the reference count

	reaches zero, the device and its resources will be freed.

	Don't forget to call fz_close_device before dropping the device,

	or you may get incomplete output!



	Never throws exceptions.

*/
    void fz_drop_device(fz_context*, fz_device*) @nogc nothrow;
    /**

	Increment the reference count for a device. Returns the same

	pointer.



	Never throws exceptions.

*/
    fz_device* fz_keep_device(fz_context*, fz_device*) @nogc nothrow;
    /**

	Enable (set) hint bits within the hint bitfield for a device.

*/
    void fz_enable_device_hints(fz_context*, fz_device*, int) @nogc nothrow;
    /**

	Disable (clear) hint bits within the hint bitfield for a device.

*/
    void fz_disable_device_hints(fz_context*, fz_device*, int) @nogc nothrow;
    /**

	Find current scissor region as tracked by the device.

*/
    fz_rect fz_device_current_scissor(fz_context*, fz_device*) @nogc nothrow;

    enum _Anonymous_55
    {

        FZ_DONT_INTERPOLATE_IMAGES = 1,

        FZ_NO_CACHE = 2,
    }
    enum FZ_DONT_INTERPOLATE_IMAGES = _Anonymous_55.FZ_DONT_INTERPOLATE_IMAGES;
    enum FZ_NO_CACHE = _Anonymous_55.FZ_NO_CACHE;
    /**

	Provide two-way communication between application and library.

	Intended for multi-threaded applications where one thread is

	rendering pages and another thread wants to read progress

	feedback or abort a job that takes a long time to finish. The

	communication is unsynchronized without locking.



	abort: The application should set this field to 0 before

	calling fz_run_page to render a page. At any point when the

	page is being rendered the application my set this field to 1

	which will cause the rendering to finish soon. This field is

	checked periodically when the page is rendered, but exactly

	when is not known, therefore there is no upper bound on

	exactly when the rendering will abort. If the application

	did not provide a set of locks to fz_new_context, it must also

	await the completion of fz_run_page before issuing another

	call to fz_run_page. Note that once the application has set

	this field to 1 after it called fz_run_page it may not change

	the value again.



	progress: Communicates rendering progress back to the

	application and is read only. Increments as a page is being

	rendered. The value starts out at 0 and is limited to less

	than or equal to progress_max, unless progress_max is -1.



	progress_max: Communicates the known upper bound of rendering

	back to the application and is read only. The maximum value

	that the progress field may take. If there is no known upper

	bound on how long the rendering may take this value is -1 and

	progress is not limited. Note that the value of progress_max

	may change from -1 to a positive value once an upper bound is

	known, so take this into consideration when comparing the

	value of progress to that of progress_max.



	errors: count of errors during current rendering.



	incomplete: Initially should be set to 0. Will be set to

	non-zero if a TRYLATER error is thrown during rendering.

*/
    struct fz_cookie
    {

        int abort;

        int progress;

        ulong progress_max;

        int errors;

        int incomplete;
    }
    /**

	Create a device to print a debug trace of all device calls.

*/
    fz_device* fz_new_trace_device(fz_context*, fz_output*) @nogc nothrow;
    /**

	Create a device to output raw information.

*/
    fz_device* fz_new_xmltext_device(fz_context*, fz_output*) @nogc nothrow;
    /**

	Create a device to compute the bounding

	box of all marks on a page.



	The returned bounding box will be the union of all bounding

	boxes of all objects on a page.

*/
    fz_device* fz_new_bbox_device(fz_context*, fz_rect*) @nogc nothrow;
    /**

	Create a device to test for features.



	Currently only tests for the presence of non-grayscale colors.



	is_color: Possible values returned:

		0: Definitely greyscale

		1: Probably color (all colors were grey, but there

		were images or shadings in a non grey colorspace).

		2: Definitely color



	threshold: The difference from grayscale that will be tolerated.

	Typical values to use are either 0 (be exact) and 0.02 (allow an

	imperceptible amount of slop).



	options: A set of bitfield options, from the FZ_TEST_OPT set.



	passthrough: A device to pass all calls through to, or NULL.

	If set, then the test device can both test and pass through to

	an underlying device (like, say, the display list device). This

	means that a display list can be created and at the end we'll

	know if it's colored or not.



	In the absence of a passthrough device, the device will throw

	an exception to stop page interpretation when color is found.

*/
    fz_device* fz_new_test_device(fz_context*, int*, float, int, fz_device*) @nogc nothrow;

    enum _Anonymous_56
    {

        FZ_TEST_OPT_IMAGES = 1,

        FZ_TEST_OPT_SHADINGS = 2,
    }
    enum FZ_TEST_OPT_IMAGES = _Anonymous_56.FZ_TEST_OPT_IMAGES;
    enum FZ_TEST_OPT_SHADINGS = _Anonymous_56.FZ_TEST_OPT_SHADINGS;
    /**

	Create a device to draw on a pixmap.



	dest: Target pixmap for the draw device. See fz_new_pixmap*

	for how to obtain a pixmap. The pixmap is not cleared by the

	draw device, see fz_clear_pixmap* for how to clear it prior to

	calling fz_new_draw_device. Free the device by calling

	fz_drop_device.



	transform: Transform from user space in points to device space

	in pixels.

*/
    fz_device* fz_new_draw_device(fz_context*, fz_matrix, fz_pixmap*) @nogc nothrow;
    /**

	Create a device to draw on a pixmap.



	dest: Target pixmap for the draw device. See fz_new_pixmap*

	for how to obtain a pixmap. The pixmap is not cleared by the

	draw device, see fz_clear_pixmap* for how to clear it prior to

	calling fz_new_draw_device. Free the device by calling

	fz_drop_device.



	transform: Transform from user space in points to device space

	in pixels.



	clip: Bounding box to restrict any marking operations of the

	draw device.

*/
    fz_device* fz_new_draw_device_with_bbox(fz_context*, fz_matrix, fz_pixmap*, const(fz_irect)*) @nogc nothrow;
    /**

	Create a device to draw on a pixmap.



	dest: Target pixmap for the draw device. See fz_new_pixmap*

	for how to obtain a pixmap. The pixmap is not cleared by the

	draw device, see fz_clear_pixmap* for how to clear it prior to

	calling fz_new_draw_device. Free the device by calling

	fz_drop_device.



	transform: Transform from user space in points to device space

	in pixels.



	proof_cs: Intermediate color space to map though when mapping to

	color space defined by pixmap.

*/
    fz_device* fz_new_draw_device_with_proof(fz_context*, fz_matrix, fz_pixmap*, fz_colorspace*) @nogc nothrow;
    /**

	Create a device to draw on a pixmap.



	dest: Target pixmap for the draw device. See fz_new_pixmap*

	for how to obtain a pixmap. The pixmap is not cleared by the

	draw device, see fz_clear_pixmap* for how to clear it prior to

	calling fz_new_draw_device. Free the device by calling

	fz_drop_device.



	transform: Transform from user space in points to device space

	in pixels.



	clip: Bounding box to restrict any marking operations of the

	draw device.



	proof_cs: Color space to render to prior to mapping to color

	space defined by pixmap.

*/
    fz_device* fz_new_draw_device_with_bbox_proof(fz_context*, fz_matrix, fz_pixmap*, const(fz_irect)*, fz_colorspace*) @nogc nothrow;

    fz_device* fz_new_draw_device_type3(fz_context*, fz_matrix, fz_pixmap*) @nogc nothrow;
    /**

	struct fz_draw_options: Options for creating a pixmap and draw

	device.

*/
    struct fz_draw_options
    {

        int rotate;

        int x_resolution;

        int y_resolution;

        int width;

        int height;

        fz_colorspace* colorspace;

        int alpha;

        int graphics;

        int text;
    }

    extern __gshared const(char)* fz_draw_options_usage;
    /**

	Parse draw device options from a comma separated key-value string.

*/
    fz_draw_options* fz_parse_draw_options(fz_context*, fz_draw_options*, const(char)*) @nogc nothrow;
    /**

	Create a new pixmap and draw device, using the specified options.



	options: Options to configure the draw device, and choose the

	resolution and colorspace.



	mediabox: The bounds of the page in points.



	pixmap: An out parameter containing the newly created pixmap.

*/
    fz_device* fz_new_draw_device_with_options(fz_context*, const(fz_draw_options)*, fz_rect, fz_pixmap**) @nogc nothrow;
    /**

	Unicode aware tolower and toupper functions.

*/
    int fz_tolower(int) @nogc nothrow;
    /**

	Create an empty display list.



	A display list contains drawing commands (text, images, etc.).

	Use fz_new_list_device for populating the list.



	mediabox: Bounds of the page (in points) represented by the

	display list.

*/
    fz_display_list* fz_new_display_list(fz_context*, fz_rect) @nogc nothrow;
    /**

	Create a rendering device for a display list.



	When the device is rendering a page it will populate the

	display list with drawing commands (text, images, etc.). The

	display list can later be reused to render a page many times

	without having to re-interpret the page from the document file

	for each rendering. Once the device is no longer needed, free

	it with fz_drop_device.



	list: A display list that the list device takes a reference to.

*/
    fz_device* fz_new_list_device(fz_context*, fz_display_list*) @nogc nothrow;
    /**

	(Re)-run a display list through a device.



	list: A display list, created by fz_new_display_list and

	populated with objects from a page by running fz_run_page on a

	device obtained from fz_new_list_device.



	ctm: Transform to apply to display list contents. May include

	for example scaling and rotation, see fz_scale, fz_rotate and

	fz_concat. Set to fz_identity if no transformation is desired.



	scissor: Only the part of the contents of the display list

	visible within this area will be considered when the list is

	run through the device. This does not imply for tile objects

	contained in the display list.



	cookie: Communication mechanism between caller and library

	running the page. Intended for multi-threaded applications,

	while single-threaded applications set cookie to NULL. The

	caller may abort an ongoing page run. Cookie also communicates

	progress information back to the caller. The fields inside

	cookie are continually updated while the page is being run.

*/
    void fz_run_display_list(fz_context*, fz_display_list*, fz_device*, fz_matrix, fz_rect, fz_cookie*) @nogc nothrow;
    /**

	Increment the reference count for a display list. Returns the

	same pointer.



	Never throws exceptions.

*/
    fz_display_list* fz_keep_display_list(fz_context*, fz_display_list*) @nogc nothrow;
    /**

	Decrement the reference count for a display list. When the

	reference count reaches zero, all the references in the display

	list itself are dropped, and the display list is freed.



	Never throws exceptions.

*/
    void fz_drop_display_list(fz_context*, fz_display_list*) @nogc nothrow;
    /**

	Return the bounding box of the page recorded in a display list.

*/
    fz_rect fz_bound_display_list(fz_context*, fz_display_list*) @nogc nothrow;
    /**

	Create a new image from a display list.



	w, h: The conceptual width/height of the image.



	transform: The matrix that needs to be applied to the given

	list to make it render to the unit square.



	list: The display list.

*/
    fz_image* fz_new_image_from_display_list(fz_context*, float, float, fz_display_list*) @nogc nothrow;
    /**

	Check for a display list being empty



	list: The list to check.



	Returns true if empty, false otherwise.

*/
    int fz_display_list_is_empty(fz_context*, const(fz_display_list)*) @nogc nothrow;

    const(char)* fz_parse_page_range(fz_context*, const(char)*, int*, int*, int) @nogc nothrow;

    struct fz_document_handler
    {

        int function(fz_context*, const(char)*) recognize;

        fz_document* function(fz_context*, const(char)*) open;

        fz_document* function(fz_context*, fz_stream*) open_with_stream;

        const(char)** extensions;

        const(char)** mimetypes;

        fz_document* function(fz_context*, const(char)*, const(char)*) open_accel;

        fz_document* function(fz_context*, fz_stream*, fz_stream*) open_accel_with_stream;
    }
    /**

	Structure definition is public so other classes can

	derive from it. Do not access the members directly.

*/
    struct fz_page
    {

        int refs;

        fz_document* doc;

        int chapter;

        int number;

        int incomplete;

        void function(fz_context*, fz_page*) drop_page;

        fz_rect function(fz_context*, fz_page*) bound_page;

        void function(fz_context*, fz_page*, fz_device*, fz_matrix, fz_cookie*) run_page_contents;

        void function(fz_context*, fz_page*, fz_device*, fz_matrix, fz_cookie*) run_page_annots;

        void function(fz_context*, fz_page*, fz_device*, fz_matrix, fz_cookie*) run_page_widgets;

        fz_link* function(fz_context*, fz_page*) load_links;

        fz_transition* function(fz_context*, fz_page*, fz_transition*, float*) page_presentation;

        void function(fz_context*, fz_page*, int, int) control_separation;

        int function(fz_context*, fz_page*, int) separation_disabled;

        fz_separations* function(fz_context*, fz_page*) separations;

        int function(fz_context*, fz_page*) overprint;

        fz_link* function(fz_context*, fz_page*, fz_rect, const(char)*) create_link;

        void function(fz_context*, fz_page*, fz_link*) delete_link;

        fz_page** prev;

        fz_page* next;
    }

    alias fz_bookmark = long;

    enum _Anonymous_57
    {

        FZ_LAYOUT_KINDLE_W = 260,

        FZ_LAYOUT_KINDLE_H = 346,

        FZ_LAYOUT_KINDLE_EM = 9,

        FZ_LAYOUT_US_POCKET_W = 306,

        FZ_LAYOUT_US_POCKET_H = 495,

        FZ_LAYOUT_US_POCKET_EM = 10,

        FZ_LAYOUT_US_TRADE_W = 396,

        FZ_LAYOUT_US_TRADE_H = 612,

        FZ_LAYOUT_US_TRADE_EM = 11,

        FZ_LAYOUT_UK_A_FORMAT_W = 312,

        FZ_LAYOUT_UK_A_FORMAT_H = 504,

        FZ_LAYOUT_UK_A_FORMAT_EM = 10,

        FZ_LAYOUT_UK_B_FORMAT_W = 366,

        FZ_LAYOUT_UK_B_FORMAT_H = 561,

        FZ_LAYOUT_UK_B_FORMAT_EM = 10,

        FZ_LAYOUT_UK_C_FORMAT_W = 382,

        FZ_LAYOUT_UK_C_FORMAT_H = 612,

        FZ_LAYOUT_UK_C_FORMAT_EM = 11,

        FZ_LAYOUT_A5_W = 420,

        FZ_LAYOUT_A5_H = 595,

        FZ_LAYOUT_A5_EM = 11,

        FZ_DEFAULT_LAYOUT_W = 420,

        FZ_DEFAULT_LAYOUT_H = 595,

        FZ_DEFAULT_LAYOUT_EM = 11,
    }
    enum FZ_LAYOUT_KINDLE_W = _Anonymous_57.FZ_LAYOUT_KINDLE_W;
    enum FZ_LAYOUT_KINDLE_H = _Anonymous_57.FZ_LAYOUT_KINDLE_H;
    enum FZ_LAYOUT_KINDLE_EM = _Anonymous_57.FZ_LAYOUT_KINDLE_EM;
    enum FZ_LAYOUT_US_POCKET_W = _Anonymous_57.FZ_LAYOUT_US_POCKET_W;
    enum FZ_LAYOUT_US_POCKET_H = _Anonymous_57.FZ_LAYOUT_US_POCKET_H;
    enum FZ_LAYOUT_US_POCKET_EM = _Anonymous_57.FZ_LAYOUT_US_POCKET_EM;
    enum FZ_LAYOUT_US_TRADE_W = _Anonymous_57.FZ_LAYOUT_US_TRADE_W;
    enum FZ_LAYOUT_US_TRADE_H = _Anonymous_57.FZ_LAYOUT_US_TRADE_H;
    enum FZ_LAYOUT_US_TRADE_EM = _Anonymous_57.FZ_LAYOUT_US_TRADE_EM;
    enum FZ_LAYOUT_UK_A_FORMAT_W = _Anonymous_57.FZ_LAYOUT_UK_A_FORMAT_W;
    enum FZ_LAYOUT_UK_A_FORMAT_H = _Anonymous_57.FZ_LAYOUT_UK_A_FORMAT_H;
    enum FZ_LAYOUT_UK_A_FORMAT_EM = _Anonymous_57.FZ_LAYOUT_UK_A_FORMAT_EM;
    enum FZ_LAYOUT_UK_B_FORMAT_W = _Anonymous_57.FZ_LAYOUT_UK_B_FORMAT_W;
    enum FZ_LAYOUT_UK_B_FORMAT_H = _Anonymous_57.FZ_LAYOUT_UK_B_FORMAT_H;
    enum FZ_LAYOUT_UK_B_FORMAT_EM = _Anonymous_57.FZ_LAYOUT_UK_B_FORMAT_EM;
    enum FZ_LAYOUT_UK_C_FORMAT_W = _Anonymous_57.FZ_LAYOUT_UK_C_FORMAT_W;
    enum FZ_LAYOUT_UK_C_FORMAT_H = _Anonymous_57.FZ_LAYOUT_UK_C_FORMAT_H;
    enum FZ_LAYOUT_UK_C_FORMAT_EM = _Anonymous_57.FZ_LAYOUT_UK_C_FORMAT_EM;
    enum FZ_LAYOUT_A5_W = _Anonymous_57.FZ_LAYOUT_A5_W;
    enum FZ_LAYOUT_A5_H = _Anonymous_57.FZ_LAYOUT_A5_H;
    enum FZ_LAYOUT_A5_EM = _Anonymous_57.FZ_LAYOUT_A5_EM;
    enum FZ_DEFAULT_LAYOUT_W = _Anonymous_57.FZ_DEFAULT_LAYOUT_W;
    enum FZ_DEFAULT_LAYOUT_H = _Anonymous_57.FZ_DEFAULT_LAYOUT_H;
    enum FZ_DEFAULT_LAYOUT_EM = _Anonymous_57.FZ_DEFAULT_LAYOUT_EM;

    alias fz_permission = _Anonymous_58;

    enum _Anonymous_58
    {

        FZ_PERMISSION_PRINT = 112,

        FZ_PERMISSION_COPY = 99,

        FZ_PERMISSION_EDIT = 101,

        FZ_PERMISSION_ANNOTATE = 110,
    }
    enum FZ_PERMISSION_PRINT = _Anonymous_58.FZ_PERMISSION_PRINT;
    enum FZ_PERMISSION_COPY = _Anonymous_58.FZ_PERMISSION_COPY;
    enum FZ_PERMISSION_EDIT = _Anonymous_58.FZ_PERMISSION_EDIT;
    enum FZ_PERMISSION_ANNOTATE = _Anonymous_58.FZ_PERMISSION_ANNOTATE;
    alias fz_document_drop_fn = void function(fz_context*, fz_document*);
    alias fz_document_needs_password_fn = int function(fz_context*, fz_document*);
    alias fz_document_authenticate_password_fn = int function(fz_context*, fz_document*, const(char)*);
    alias fz_document_has_permission_fn = int function(fz_context*, fz_document*, fz_permission);
    alias fz_document_load_outline_fn = fz_outline* function(fz_context*, fz_document*);
    alias fz_document_outline_iterator_fn = fz_outline_iterator* function(fz_context*, fz_document*);
    alias fz_document_layout_fn = void function(fz_context*, fz_document*, float, float, float);
    alias fz_document_resolve_link_dest_fn = fz_link_dest function(fz_context*, fz_document*, const(char)*);
    alias fz_document_format_link_uri_fn = char* function(fz_context*, fz_document*, fz_link_dest);
    alias fz_document_count_chapters_fn = int function(fz_context*, fz_document*);
    alias fz_document_count_pages_fn = int function(fz_context*, fz_document*, int);
    alias fz_document_load_page_fn = fz_page* function(fz_context*, fz_document*, int, int);
    alias fz_document_lookup_metadata_fn = int function(fz_context*, fz_document*, const(char)*, char*, int);
    alias fz_document_set_metadata_fn = int function(fz_context*, fz_document*, const(char)*, const(char)*);
    alias fz_document_output_intent_fn = fz_colorspace* function(fz_context*, fz_document*);
    alias fz_document_output_accelerator_fn = void function(fz_context*, fz_document*, fz_output*);
    alias fz_document_make_bookmark_fn = long function(fz_context*, fz_document*, fz_location);
    alias fz_document_lookup_bookmark_fn = fz_location function(fz_context*, fz_document*, long);
    alias fz_page_drop_page_fn = void function(fz_context*, fz_page*);
    alias fz_page_bound_page_fn = fz_rect function(fz_context*, fz_page*);
    alias fz_page_run_page_fn = void function(fz_context*, fz_page*, fz_device*, fz_matrix, fz_cookie*);
    alias fz_page_load_links_fn = fz_link* function(fz_context*, fz_page*);
    alias fz_page_page_presentation_fn = fz_transition* function(fz_context*, fz_page*, fz_transition*, float*);
    alias fz_page_control_separation_fn = void function(fz_context*, fz_page*, int, int);
    alias fz_page_separation_disabled_fn = int function(fz_context*, fz_page*, int);
    alias fz_page_separations_fn = fz_separations* function(fz_context*, fz_page*);
    alias fz_page_uses_overprint_fn = int function(fz_context*, fz_page*);
    alias fz_page_create_link_fn = fz_link* function(fz_context*, fz_page*, fz_rect, const(char)*);
    alias fz_page_delete_link_fn = void function(fz_context*, fz_page*, fz_link*);
    alias fz_document_open_fn = fz_document* function(fz_context*, const(char)*);
    alias fz_document_open_with_stream_fn = fz_document* function(fz_context*, fz_stream*);
    alias fz_document_open_accel_fn = fz_document* function(fz_context*, const(char)*, const(char)*);
    alias fz_document_open_accel_with_stream_fn = fz_document* function(fz_context*, fz_stream*, fz_stream*);
    alias fz_document_recognize_fn = int function(fz_context*, const(char)*);
    alias fz_process_opened_page_fn = void* function(fz_context*, fz_page*, void*);
    /**

	Register a handler for a document type.



	handler: The handler to register.

*/
    void fz_register_document_handler(fz_context*, const(fz_document_handler)*) @nogc nothrow;
    /**

	Register handlers

	for all the standard document types supported in

	this build.

*/
    void fz_register_document_handlers(fz_context*) @nogc nothrow;
    /**

	Given a magic find a document handler that can handle a

	document of this type.



	magic: Can be a filename extension (including initial period) or

	a mimetype.

*/
    const(fz_document_handler)* fz_recognize_document(fz_context*, const(char)*) @nogc nothrow;
    /**

	Open a document file and read its basic structure so pages and

	objects can be located. MuPDF will try to repair broken

	documents (without actually changing the file contents).



	The returned fz_document is used when calling most other

	document related functions.



	filename: a path to a file as it would be given to open(2).

*/
    fz_document* fz_open_document(fz_context*, const(char)*) @nogc nothrow;
    /**

	Open a document file and read its basic structure so pages and

	objects can be located. MuPDF will try to repair broken

	documents (without actually changing the file contents).



	The returned fz_document is used when calling most other

	document related functions.



	filename: a path to a file as it would be given to open(2).

*/
    fz_document* fz_open_accelerated_document(fz_context*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Open a document using the specified stream object rather than

	opening a file on disk.



	magic: a string used to detect document type; either a file name

	or mime-type.

*/
    fz_document* fz_open_document_with_stream(fz_context*, const(char)*, fz_stream*) @nogc nothrow;
    /**

	Open a document using the specified stream object rather than

	opening a file on disk.



	magic: a string used to detect document type; either a file name

	or mime-type.

*/
    fz_document* fz_open_accelerated_document_with_stream(fz_context*, const(char)*, fz_stream*, fz_stream*) @nogc nothrow;
    /**

	Query if the document supports the saving of accelerator data.

*/
    int fz_document_supports_accelerator(fz_context*, fz_document*) @nogc nothrow;
    /**

	Save accelerator data for the document to a given file.

*/
    void fz_save_accelerator(fz_context*, fz_document*, const(char)*) @nogc nothrow;
    /**

	Output accelerator data for the document to a given output

	stream.

*/
    void fz_output_accelerator(fz_context*, fz_document*, fz_output*) @nogc nothrow;
    /**

	New documents are typically created by calls like

	foo_new_document(fz_context *ctx, ...). These work by

	deriving a new document type from fz_document, for instance:

	typedef struct { fz_document base; ...extras... } foo_document;

	These are allocated by calling

	fz_new_derived_document(ctx, foo_document)

*/
    void* fz_new_document_of_size(fz_context*, int) @nogc nothrow;
    /**

	Check and parse string into page ranges:

		/,?(-?\d+|N)(-(-?\d+|N))?/

*/
    int fz_is_page_range(fz_context*, const(char)*) @nogc nothrow;
    /**

	Increment the document reference count. The same pointer is

	returned.



	Never throws exceptions.

*/
    fz_document* fz_keep_document(fz_context*, fz_document*) @nogc nothrow;
    /**

	Decrement the document reference count. When the reference

	count reaches 0, the document and all it's references are

	freed.



	Never throws exceptions.

*/
    void fz_drop_document(fz_context*, fz_document*) @nogc nothrow;
    /**

	Check if a document is encrypted with a

	non-blank password.

*/
    int fz_needs_password(fz_context*, fz_document*) @nogc nothrow;
    /**

	Test if the given password can decrypt the document.



	password: The password string to be checked. Some document

	specifications do not specify any particular text encoding, so

	neither do we.



	Returns 0 for failure to authenticate, non-zero for success.



	For PDF documents, further information can be given by examining

	the bits in the return code.



		Bit 0 => No password required

		Bit 1 => User password authenticated

		Bit 2 => Owner password authenticated

*/
    int fz_authenticate_password(fz_context*, fz_document*, const(char)*) @nogc nothrow;
    /**

	Load the hierarchical document outline.



	Should be freed by fz_drop_outline.

*/
    fz_outline* fz_load_outline(fz_context*, fz_document*) @nogc nothrow;
    /**

	Get an iterator for the document outline.



	Should be freed by fz_drop_outline_iterator.

*/
    fz_outline_iterator* fz_new_outline_iterator(fz_context*, fz_document*) @nogc nothrow;
    /**

	Is the document reflowable.



	Returns 1 to indicate reflowable documents, otherwise 0.

*/
    int fz_is_document_reflowable(fz_context*, fz_document*) @nogc nothrow;
    /**

	Layout reflowable document types.



	w, h: Page size in points.

	em: Default font size in points.

*/
    void fz_layout_document(fz_context*, fz_document*, float, float, float) @nogc nothrow;
    /**

	Create a bookmark for the given page, which can be used to find

	the same location after the document has been laid out with

	different parameters.

*/
    long fz_make_bookmark(fz_context*, fz_document*, fz_location) @nogc nothrow;
    /**

	Find a bookmark and return its page number.

*/
    fz_location fz_lookup_bookmark(fz_context*, fz_document*, long) @nogc nothrow;
    /**

	Return the number of pages in document



	May return 0 for documents with no pages.

*/
    int fz_count_pages(fz_context*, fz_document*) @nogc nothrow;
    /**

	Resolve an internal link to a page number, location, and possible viewing parameters.



	Returns location (-1,-1) if the URI cannot be resolved.

*/
    fz_link_dest fz_resolve_link_dest(fz_context*, fz_document*, const(char)*) @nogc nothrow;
    /**

	Format an internal link to a page number, location, and possible viewing parameters,

	suitable for use with fz_create_link.



	Returns a newly allocated string that the caller must free.

*/
    char* fz_format_link_uri(fz_context*, fz_document*, fz_link_dest) @nogc nothrow;
    /**

	Resolve an internal link to a page number.



	xp, yp: Pointer to store coordinate of destination on the page.



	Returns (-1,-1) if the URI cannot be resolved.

*/
    fz_location fz_resolve_link(fz_context*, fz_document*, const(char)*, float*, float*) @nogc nothrow;
    /**

	Function to get the location for the last page in the document.

	Using this can be far more efficient in some cases than calling

	fz_count_pages and using the page number.

*/
    fz_location fz_last_page(fz_context*, fz_document*) @nogc nothrow;
    /**

	Function to get the location of the next page (allowing for the

	end of chapters etc). If at the end of the document, returns the

	current location.

*/
    fz_location fz_next_page(fz_context*, fz_document*, fz_location) @nogc nothrow;
    /**

	Function to get the location of the previous page (allowing for

	the end of chapters etc). If already at the start of the

	document, returns the current page.

*/
    fz_location fz_previous_page(fz_context*, fz_document*, fz_location) @nogc nothrow;
    /**

	Clamps a location into valid chapter/page range. (First clamps

	the chapter into range, then the page into range).

*/
    fz_location fz_clamp_location(fz_context*, fz_document*, fz_location) @nogc nothrow;
    /**

	Converts from page number to chapter+page. This may cause many

	chapters to be laid out in order to calculate the number of

	pages within those chapters.

*/
    fz_location fz_location_from_page_number(fz_context*, fz_document*, int) @nogc nothrow;
    /**

	Converts from chapter+page to page number. This may cause many

	chapters to be laid out in order to calculate the number of

	pages within those chapters.

*/
    int fz_page_number_from_location(fz_context*, fz_document*, fz_location) @nogc nothrow;
    /**

	Load a given page number from a document. This may be much less

	efficient than loading by location (chapter+page) for some

	document types.

*/
    fz_page* fz_load_page(fz_context*, fz_document*, int) @nogc nothrow;
    /**

	Return the number of chapters in the document.

	At least 1.

*/
    int fz_count_chapters(fz_context*, fz_document*) @nogc nothrow;
    /**

	Return the number of pages in a chapter.

	May return 0.

*/
    int fz_count_chapter_pages(fz_context*, fz_document*, int) @nogc nothrow;
    /**

	Load a page.



	After fz_load_page is it possible to retrieve the size of the

	page using fz_bound_page, or to render the page using

	fz_run_page_*. Free the page by calling fz_drop_page.



	chapter: chapter number, 0 is the first chapter of the document.

	number: page number, 0 is the first page of the chapter.

*/
    fz_page* fz_load_chapter_page(fz_context*, fz_document*, int, int) @nogc nothrow;
    /**

	Load the list of links for a page.



	Returns a linked list of all the links on the page, each with

	its clickable region and link destination. Each link is

	reference counted so drop and free the list of links by

	calling fz_drop_link on the pointer return from fz_load_links.



	page: Page obtained from fz_load_page.

*/
    fz_link* fz_load_links(fz_context*, fz_page*) @nogc nothrow;
    /**

	Different document types will be implemented by deriving from

	fz_page. This macro allocates such derived structures, and

	initialises the base sections.

*/
    fz_page* fz_new_page_of_size(fz_context*, int, fz_document*) @nogc nothrow;

    int fz_grisu(float, char*, int*) @nogc nothrow;
    /**

	Determine the size of a page at 72 dpi.

*/
    fz_rect fz_bound_page(fz_context*, fz_page*) @nogc nothrow;
    /**

	Run a page through a device.



	page: Page obtained from fz_load_page.



	dev: Device obtained from fz_new_*_device.



	transform: Transform to apply to page. May include for example

	scaling and rotation, see fz_scale, fz_rotate and fz_concat.

	Set to fz_identity if no transformation is desired.



	cookie: Communication mechanism between caller and library

	rendering the page. Intended for multi-threaded applications,

	while single-threaded applications set cookie to NULL. The

	caller may abort an ongoing rendering of a page. Cookie also

	communicates progress information back to the caller. The

	fields inside cookie are continually updated while the page is

	rendering.

*/
    void fz_run_page(fz_context*, fz_page*, fz_device*, fz_matrix, fz_cookie*) @nogc nothrow;
    /**

	Run a page through a device. Just the main

	page content, without the annotations, if any.



	page: Page obtained from fz_load_page.



	dev: Device obtained from fz_new_*_device.



	transform: Transform to apply to page. May include for example

	scaling and rotation, see fz_scale, fz_rotate and fz_concat.

	Set to fz_identity if no transformation is desired.



	cookie: Communication mechanism between caller and library

	rendering the page. Intended for multi-threaded applications,

	while single-threaded applications set cookie to NULL. The

	caller may abort an ongoing rendering of a page. Cookie also

	communicates progress information back to the caller. The

	fields inside cookie are continually updated while the page is

	rendering.

*/
    void fz_run_page_contents(fz_context*, fz_page*, fz_device*, fz_matrix, fz_cookie*) @nogc nothrow;
    /**

	Run the annotations on a page through a device.

*/
    void fz_run_page_annots(fz_context*, fz_page*, fz_device*, fz_matrix, fz_cookie*) @nogc nothrow;
    /**

	Run the widgets on a page through a device.

*/
    void fz_run_page_widgets(fz_context*, fz_page*, fz_device*, fz_matrix, fz_cookie*) @nogc nothrow;
    /**

	Increment the reference count for the page. Returns the same

	pointer.



	Never throws exceptions.

*/
    fz_page* fz_keep_page(fz_context*, fz_page*) @nogc nothrow;
    /**

	Increment the reference count for the page. Returns the same

	pointer. Must only be used when the alloc lock is already taken.



	Never throws exceptions.

*/
    fz_page* fz_keep_page_locked(fz_context*, fz_page*) @nogc nothrow;
    /**

	Decrements the reference count for the page. When the reference

	count hits 0, the page and its references are freed.



	Never throws exceptions.

*/
    void fz_drop_page(fz_context*, fz_page*) @nogc nothrow;
    /**

	Get the presentation details for a given page.



	transition: A pointer to a transition struct to fill out.



	duration: A pointer to a place to set the page duration in

	seconds. Will be set to 0 if no transition is specified for the

	page.



	Returns: a pointer to the transition structure, or NULL if there

	is no transition specified for the page.

*/
    fz_transition* fz_page_presentation(fz_context*, fz_page*, fz_transition*, float*) @nogc nothrow;
    /**

	Check permission flags on document.

*/
    int fz_has_permission(fz_context*, fz_document*, fz_permission) @nogc nothrow;
    /**

	Retrieve document meta data strings.



	doc: The document to query.



	key: Which meta data key to retrieve...



	Basic information:

		'format'	-- Document format and version.

		'encryption'	-- Description of the encryption used.



	From the document information dictionary:

		'info:Title'

		'info:Author'

		'info:Subject'

		'info:Keywords'

		'info:Creator'

		'info:Producer'

		'info:CreationDate'

		'info:ModDate'



	buf: The buffer to hold the results (a nul-terminated UTF-8

	string).



	size: Size of 'buf'.



	Returns the number of bytes need to store the string plus terminator

	(will be larger than 'size' if the output was truncated), or -1 if the

	key is not recognized or found.

*/
    int fz_lookup_metadata(fz_context*, fz_document*, const(char)*, char*, int) @nogc nothrow;
    /**

	Locale-independent decimal to binary conversion. On overflow

	return (-)INFINITY and set errno to ERANGE. On underflow return

	0 and set errno to ERANGE. Special inputs (case insensitive):

	"NAN", "INF" or "INFINITY".

*/
    float fz_strtof(const(char)*, char**) @nogc nothrow;
    /**

	Count how many runes the UTF-8 encoded string

	consists of.



	s: The UTF-8 encoded, NUL-terminated text string.



	Returns the number of runes in the string.

*/
    int fz_utflen(const(char)*) @nogc nothrow;
    /**

	Obtain a pointer to the char representing the rune

	at a given index.



	str: Pointer to beginning of a string.



	idx: Index of a rune to return a char pointer to.



	Returns a pointer to the char where the desired rune starts,

	or NULL if the string ends before the index is reached.

*/
    const(char)* fz_runeptr(const(char)*, int) @nogc nothrow;
    /**

	Compute the index of a rune in a string.



	str: Pointer to beginning of a string.



	p: Pointer to a char in str.



	Returns the index of the rune pointed to by p in str.

*/
    int fz_runeidx(const(char)*, const(char)*) @nogc nothrow;
    /**

	Count how many chars are required to represent a rune.



	rune: The rune to encode.



	Returns the number of bytes required to represent this run in

	UTF8.

*/
    int fz_runelen(int) @nogc nothrow;
    /**

	UTF8 encode a rune to a sequence of chars.



	str: Pointer to a place to put the UTF8 encoded character.



	rune: Pointer to a 'rune'.



	Returns the number of bytes the rune took to output.

*/
    int fz_runetochar(char*, int) @nogc nothrow;
    /**

	UTF8 decode a single rune from a sequence of chars.



	rune: Pointer to an int to assign the decoded 'rune' to.



	str: Pointer to a UTF8 encoded string.



	Returns the number of bytes consumed.

*/
    int fz_chartorune(int*, const(char)*) @nogc nothrow;
    /**

	FZ_UTFMAX: Maximum number of bytes in a decoded rune (maximum

	length returned by fz_chartorune).

*/
    enum _Anonymous_59
    {

        FZ_UTFMAX = 4,
    }
    enum FZ_UTFMAX = _Anonymous_59.FZ_UTFMAX;

    int fz_strncasecmp(const(char)*, const(char)*, ulong) @nogc nothrow;
    /**

	Case insensitive (ASCII only) string comparison.

*/
    int fz_strcasecmp(const(char)*, const(char)*) @nogc nothrow;
    /**

	Resolve a path to an absolute file name.

	The resolved path buffer must be of at least PATH_MAX size.

*/
    char* fz_realpath(const(char)*, char*) @nogc nothrow;

    void fz_set_metadata(fz_context*, fz_document*, const(char)*, const(char)*) @nogc nothrow;
    /**

	Find the output intent colorspace if the document has defined

	one.



	Returns a borrowed reference that should not be dropped, unless

	it is kept first.

*/
    fz_colorspace* fz_document_output_intent(fz_context*, fz_document*) @nogc nothrow;
    /**

	Get the separations details for a page.

	This will be NULL, unless the format specifically supports

	separations (such as PDF files). May be NULL even

	so, if there are no separations on a page.



	Returns a reference that must be dropped.

*/
    fz_separations* fz_page_separations(fz_context*, fz_page*) @nogc nothrow;
    /**

	Query if a given page requires overprint.

*/
    int fz_page_uses_overprint(fz_context*, fz_page*) @nogc nothrow;
    /**

	Create a new link on a page.

*/
    fz_link* fz_create_link(fz_context*, fz_page*, fz_rect, const(char)*) @nogc nothrow;
    /**

	Delete an existing link on a page.

*/
    void fz_delete_link(fz_context*, fz_page*, fz_link*) @nogc nothrow;
    /**

	Iterates over all opened pages of the document, calling the

	provided callback for each page for processing. If the callback

	returns non-NULL then the iteration stops and that value is returned

	to the called of fz_process_opened_pages().



	The state pointer provided to fz_process_opened_pages() is

	passed on to the callback but is owned by the caller.



	Returns the first non-NULL value returned by the callback,

	or NULL if the callback returned NULL for all opened pages.

*/
    void* fz_process_opened_pages(fz_context*, fz_document*, void* function(fz_context*, fz_page*, void*), void*) @nogc nothrow;
    /**

	rewrite path to the shortest string that names the same path.



	Eliminates multiple and trailing slashes, interprets "." and

	"..". Overwrites the string in place.

*/
    char* fz_cleanname(char*) @nogc nothrow;
    /**

	create output file name using a template.



	If the path contains %[0-9]*d, the first such pattern will be

	replaced with the page number. If the template does not contain

	such a pattern, the page number will be inserted before the

	filename extension. If the template does not have a filename

	extension, the page number will be added to the end.

*/
    void fz_format_output_path(fz_context*, char*, ulong, const(char)*, int) @nogc nothrow;
    /**

	decode url escapes.

*/
    char* fz_urldecode(char*) @nogc nothrow;
    /**

	Find the filename component in a path.

*/
    const(char)* fz_basename(const(char)*) @nogc nothrow;
    struct fz_jbig2_globals;

    struct fz_range
    {

        long offset;

        ulong length;
    }
    /**

	The null filter reads a specified amount of data from the

	substream.

*/
    fz_stream* fz_open_null_filter(fz_context*, fz_stream*, ulong, long) @nogc nothrow;
    /**

	The range filter copies data from specified ranges of the

	chained stream.

*/
    fz_stream* fz_open_range_filter(fz_context*, fz_stream*, fz_range*, int) @nogc nothrow;
    /**

	The endstream filter reads a PDF substream, and starts to look

	for an 'endstream' token after the specified length.

*/
    fz_stream* fz_open_endstream_filter(fz_context*, fz_stream*, ulong, long) @nogc nothrow;
    /**

	Concat filter concatenates several streams into one.

*/
    fz_stream* fz_open_concat(fz_context*, int, int) @nogc nothrow;
    /**

	Add a chained stream to the end of the concatenate filter.



	Ownership of chain is passed in.

*/
    void fz_concat_push_drop(fz_context*, fz_stream*, fz_stream*) @nogc nothrow;
    /**

	arc4 filter performs RC4 decoding of data read from the chained

	filter using the supplied key.

*/
    fz_stream* fz_open_arc4(fz_context*, fz_stream*, ubyte*, uint) @nogc nothrow;
    /**

	aesd filter performs AES decoding of data read from the chained

	filter using the supplied key.

*/
    fz_stream* fz_open_aesd(fz_context*, fz_stream*, ubyte*, uint) @nogc nothrow;
    /**

	a85d filter performs ASCII 85 Decoding of data read

	from the chained filter.

*/
    fz_stream* fz_open_a85d(fz_context*, fz_stream*) @nogc nothrow;
    /**

	ahxd filter performs ASCII Hex decoding of data read

	from the chained filter.

*/
    fz_stream* fz_open_ahxd(fz_context*, fz_stream*) @nogc nothrow;
    /**

	rld filter performs Run Length Decoding of data read

	from the chained filter.

*/
    fz_stream* fz_open_rld(fz_context*, fz_stream*) @nogc nothrow;
    /**

	dctd filter performs DCT (JPEG) decoding of data read

	from the chained filter.



	color_transform implements the PDF color_transform option;

	use -1 (unset) as a default.



	For subsampling on decode, set l2factor to the log2 of the

	reduction required (therefore 0 = full size decode).



	jpegtables is an optional stream from which the JPEG tables

	can be read. Use NULL if not required.

*/
    fz_stream* fz_open_dctd(fz_context*, fz_stream*, int, int, fz_stream*) @nogc nothrow;
    /**

	faxd filter performs FAX decoding of data read from

	the chained filter.



	k: see fax specification (fax default is 0).



	end_of_line: whether we expect end of line markers (fax default

	is 0).



	encoded_byte_align: whether we align to bytes after each line

	(fax default is 0).



	columns: how many columns in the image (fax default is 1728).



	rows: 0 for unspecified or the number of rows of data to expect.



	end_of_block: whether we expect end of block markers (fax

	default is 1).



	black_is_1: determines the polarity of the image (fax default is

	0).

*/
    fz_stream* fz_open_faxd(fz_context*, fz_stream*, int, int, int, int, int, int, int) @nogc nothrow;
    /**

	flated filter performs LZ77 decoding (inflating) of data read

	from the chained filter.



	window_bits: How large a decompression window to use. Typically

	15. A negative number, -n, means to use n bits, but to expect

	raw data with no header.

*/
    fz_stream* fz_open_flated(fz_context*, fz_stream*, int) @nogc nothrow;
    /**

	lzwd filter performs LZW decoding of data read from the chained

	filter.



	early_change: (Default 1) specifies whether to change codes 1

	bit early.



	min_bits: (Default 9) specifies the minimum number of bits to

	use.



	reverse_bits: (Default 0) allows for compatibility with gif and

	old style tiffs (1).



	old_tiff: (Default 0) allows for different handling of the clear

	code, as found in old style tiffs.

*/
    fz_stream* fz_open_lzwd(fz_context*, fz_stream*, int, int, int, int) @nogc nothrow;
    /**

	predict filter performs pixel prediction on data read from

	the chained filter.



	predictor: 1 = copy, 2 = tiff, other = inline PNG predictor



	columns: width of image in pixels



	colors: number of components.



	bpc: bits per component (typically 8)

*/
    fz_stream* fz_open_predict(fz_context*, fz_stream*, int, int, int, int) @nogc nothrow;
    /**

	Open a filter that performs jbig2 decompression on the chained

	stream, using the optional globals record.

*/
    fz_stream* fz_open_jbig2d(fz_context*, fz_stream*, fz_jbig2_globals*, int) @nogc nothrow;
    /**

	Create a jbig2 globals record from a buffer.



	Immutable once created.

*/
    fz_jbig2_globals* fz_load_jbig2_globals(fz_context*, fz_buffer*) @nogc nothrow;
    /**

	Increment the reference count for a jbig2 globals record.



	Never throws an exception.

*/
    fz_jbig2_globals* fz_keep_jbig2_globals(fz_context*, fz_jbig2_globals*) @nogc nothrow;
    /**

	Decrement the reference count for a jbig2 globals record.

	When the reference count hits zero, the record is freed.



	Never throws an exception.

*/
    void fz_drop_jbig2_globals(fz_context*, fz_jbig2_globals*) @nogc nothrow;
    /**

	Special jbig2 globals drop function for use in implementing

	store support.

*/
    void fz_drop_jbig2_globals_imp(fz_context*, fz_storable*) @nogc nothrow;
    /**

	Return buffer containing jbig2 globals data stream.

*/
    fz_buffer* fz_jbig2_globals_data(fz_context*, fz_jbig2_globals*) @nogc nothrow;
    /**

	SGI Log 16bit (greyscale) decode from the chained filter.

	Decodes lines of w pixels to 8bpp greyscale.

*/
    fz_stream* fz_open_sgilog16(fz_context*, fz_stream*, int) @nogc nothrow;
    /**

	SGI Log 24bit (LUV) decode from the chained filter.

	Decodes lines of w pixels to 8bpc rgb.

*/
    fz_stream* fz_open_sgilog24(fz_context*, fz_stream*, int) @nogc nothrow;
    /**

	SGI Log 32bit (LUV) decode from the chained filter.

	Decodes lines of w pixels to 8bpc rgb.

*/
    fz_stream* fz_open_sgilog32(fz_context*, fz_stream*, int) @nogc nothrow;
    /**

	4bit greyscale Thunderscan decoding from the chained filter.

	Decodes lines of w pixels to 8bpp greyscale.

*/
    fz_stream* fz_open_thunder(fz_context*, fz_stream*, int) @nogc nothrow;
    /**

	extract the directory component from a path.

*/
    void fz_dirname(char*, const(char)*, ulong) @nogc nothrow;

    struct fz_device
    {

        int refs;

        int hints;

        int flags;

        void function(fz_context*, fz_device*) close_device;

        void function(fz_context*, fz_device*) drop_device;

        void function(fz_context*, fz_device*, const(fz_path)*, int, fz_matrix, fz_colorspace*, const(float)*, float, fz_color_params) fill_path;

        void function(fz_context*, fz_device*, const(fz_path)*, const(fz_stroke_state)*, fz_matrix, fz_colorspace*, const(float)*, float, fz_color_params) stroke_path;

        void function(fz_context*, fz_device*, const(fz_path)*, int, fz_matrix, fz_rect) clip_path;

        void function(fz_context*, fz_device*, const(fz_path)*, const(fz_stroke_state)*, fz_matrix, fz_rect) clip_stroke_path;

        void function(fz_context*, fz_device*, const(fz_text)*, fz_matrix, fz_colorspace*, const(float)*, float, fz_color_params) fill_text;

        void function(fz_context*, fz_device*, const(fz_text)*, const(fz_stroke_state)*, fz_matrix, fz_colorspace*, const(float)*, float, fz_color_params) stroke_text;

        void function(fz_context*, fz_device*, const(fz_text)*, fz_matrix, fz_rect) clip_text;

        void function(fz_context*, fz_device*, const(fz_text)*, const(fz_stroke_state)*, fz_matrix, fz_rect) clip_stroke_text;

        void function(fz_context*, fz_device*, const(fz_text)*, fz_matrix) ignore_text;

        void function(fz_context*, fz_device*, fz_shade*, fz_matrix, float, fz_color_params) fill_shade;

        void function(fz_context*, fz_device*, fz_image*, fz_matrix, float, fz_color_params) fill_image;

        void function(fz_context*, fz_device*, fz_image*, fz_matrix, fz_colorspace*, const(float)*, float, fz_color_params) fill_image_mask;

        void function(fz_context*, fz_device*, fz_image*, fz_matrix, fz_rect) clip_image_mask;

        void function(fz_context*, fz_device*) pop_clip;

        void function(fz_context*, fz_device*, fz_rect, int, fz_colorspace*, const(float)*, fz_color_params) begin_mask;

        void function(fz_context*, fz_device*) end_mask;

        void function(fz_context*, fz_device*, fz_rect, fz_colorspace*, int, int, int, float) begin_group;

        void function(fz_context*, fz_device*) end_group;

        int function(fz_context*, fz_device*, fz_rect, fz_rect, float, float, fz_matrix, int) begin_tile;

        void function(fz_context*, fz_device*) end_tile;

        void function(fz_context*, fz_device*, int, int) render_flags;

        void function(fz_context*, fz_device*, fz_default_colorspaces*) set_default_colorspaces;

        void function(fz_context*, fz_device*, const(char)*) begin_layer;

        void function(fz_context*, fz_device*) end_layer;

        fz_rect d1_rect;

        int container_len;

        int container_cap;

        fz_device_container_stack* container;
    }

    extern __gshared const(char)*[256] fz_glyph_name_from_adobe_standard;

    extern __gshared const(char)*[256] fz_glyph_name_from_iso8859_7;

    extern __gshared const(char)*[256] fz_glyph_name_from_koi8u;

    extern __gshared const(char)*[256] fz_glyph_name_from_mac_expert;

    extern __gshared const(char)*[256] fz_glyph_name_from_mac_roman;

    extern __gshared const(char)*[256] fz_glyph_name_from_win_ansi;

    extern __gshared const(char)*[256] fz_glyph_name_from_windows_1252;

    extern __gshared const(ushort)[256] fz_unicode_from_iso8859_1;

    extern __gshared const(ushort)[256] fz_unicode_from_iso8859_7;

    extern __gshared const(ushort)[256] fz_unicode_from_koi8u;

    extern __gshared const(ushort)[256] fz_unicode_from_pdf_doc_encoding;

    extern __gshared const(ushort)[256] fz_unicode_from_windows_1250;

    extern __gshared const(ushort)[256] fz_unicode_from_windows_1251;

    extern __gshared const(ushort)[256] fz_unicode_from_windows_1252;

    int fz_iso8859_1_from_unicode(int) @nogc nothrow;

    int fz_iso8859_7_from_unicode(int) @nogc nothrow;

    int fz_koi8u_from_unicode(int) @nogc nothrow;

    int fz_windows_1250_from_unicode(int) @nogc nothrow;

    int fz_windows_1251_from_unicode(int) @nogc nothrow;

    int fz_windows_1252_from_unicode(int) @nogc nothrow;

    int fz_unicode_from_glyph_name(const(char)*) @nogc nothrow;

    int fz_unicode_from_glyph_name_strict(const(char)*) @nogc nothrow;

    const(char)** fz_duplicate_glyph_names_from_unicode(int) @nogc nothrow;

    const(char)* fz_glyph_name_from_unicode_sc(int) @nogc nothrow;

    struct fz_font
    {

        int refs;

        char[32] name;

        fz_buffer* buffer;

        fz_font_flags_t flags;

        void* ft_face;

        fz_shaper_data_t shaper_data;

        fz_matrix t3matrix;

        void* t3resources;

        fz_buffer** t3procs;

        fz_display_list** t3lists;

        float* t3widths;

        ushort* t3flags;

        void* t3doc;

        void function(fz_context*, void*, void*, fz_buffer*, fz_device*, fz_matrix, void*, fz_default_colorspaces*) t3run;

        void function(fz_context*, void*, void*) t3freeres;

        fz_rect bbox;

        int glyph_count;

        fz_rect** bbox_table;

        int use_glyph_bbox;

        int width_count;

        short width_default;

        short* width_table;

        float** advance_cache;

        ushort*[256] encoding_cache;

        int has_digest;

        ubyte[16] digest;
    }
    /**

	Retrieve the FT_Face handle

	for the font.



	font: The font to query



	Returns the FT_Face handle for the font, or NULL

	if not a freetype handled font. (Cast to void *

	to avoid nasty header exposure).

*/
    void* fz_font_ft_face(fz_context*, fz_font*) @nogc nothrow;
    /**

	Retrieve the Type3 procs

	for a font.



	font: The font to query



	Returns the t3_procs pointer. Will be NULL for a

	non type-3 font.

*/
    fz_buffer** fz_font_t3_procs(fz_context*, fz_font*) @nogc nothrow;

    enum _Anonymous_60
    {

        FZ_ADOBE_CNS = 0,

        FZ_ADOBE_GB = 1,

        FZ_ADOBE_JAPAN = 2,

        FZ_ADOBE_KOREA = 3,
    }
    enum FZ_ADOBE_CNS = _Anonymous_60.FZ_ADOBE_CNS;
    enum FZ_ADOBE_GB = _Anonymous_60.FZ_ADOBE_GB;
    enum FZ_ADOBE_JAPAN = _Anonymous_60.FZ_ADOBE_JAPAN;
    enum FZ_ADOBE_KOREA = _Anonymous_60.FZ_ADOBE_KOREA;
    /**

	Every fz_font carries a set of flags

	within it, in a fz_font_flags_t structure.

*/
    struct fz_font_flags_t
    {
        import std.bitmanip: bitfields;

        align(4):
        mixin(bitfields!(

            uint, "is_mono", 1,

            uint, "is_serif", 1,

            uint, "is_bold", 1,

            uint, "is_italic", 1,

            uint, "ft_substitute", 1,

            uint, "ft_stretch", 1,

            uint, "fake_bold", 1,

            uint, "fake_italic", 1,

            uint, "has_opentype", 1,

            uint, "invalid_bbox", 1,

            uint, "cjk", 1,

            uint, "cjk_lang", 2,
            uint, "_padding_0", 3
        ));
    }
    /**

	Retrieve a pointer to the font flags

	for a given font. These can then be updated as required.



	font: The font to query



	Returns a pointer to the flags structure (or NULL, if

	the font is NULL).

*/
    fz_font_flags_t* fz_font_flags(fz_font*) @nogc nothrow;
    /**

	In order to shape a given font, we need to

	declare it to a shaper library (harfbuzz, by default, but others

	are possible). To avoid redeclaring it every time we need to

	shape, we hold a shaper handle and the destructor for it within

	the font itself. The handle is initialised by the caller when

	first required and the destructor is called when the fz_font is

	destroyed.

*/
    struct fz_shaper_data_t
    {

        void* shaper_handle;

        void function(fz_context*, void*) destroy;
    }
    /**

	Retrieve a pointer to the shaper data

	structure for the given font.



	font: The font to query.



	Returns a pointer to the shaper data structure (or NULL if

	font is NULL).

*/
    fz_shaper_data_t* fz_font_shaper_data(fz_context*, fz_font*) @nogc nothrow;
    /**

	Retrieve a pointer to the name of the font.



	font: The font to query.



	Returns a pointer to an internal copy of the font name.

	Will never be NULL, but may be the empty string.

*/
    const(char)* fz_font_name(fz_context*, fz_font*) @nogc nothrow;
    /**

	Query whether the font flags say that this font is bold.

*/
    int fz_font_is_bold(fz_context*, fz_font*) @nogc nothrow;
    /**

	Query whether the font flags say that this font is italic.

*/
    int fz_font_is_italic(fz_context*, fz_font*) @nogc nothrow;
    /**

	Query whether the font flags say that this font is serif.

*/
    int fz_font_is_serif(fz_context*, fz_font*) @nogc nothrow;
    /**

	Query whether the font flags say that this font is monospaced.

*/
    int fz_font_is_monospaced(fz_context*, fz_font*) @nogc nothrow;
    /**

	Retrieve the font bbox.



	font: The font to query.



	Returns the font bbox by value; it is valid only if

	fz_font_flags(font)->invalid_bbox is zero.

*/
    fz_rect fz_font_bbox(fz_context*, fz_font*) @nogc nothrow;
    alias fz_load_system_font_fn = fz_font* function(fz_context*, const(char)*, int, int, int);
    alias fz_load_system_cjk_font_fn = fz_font* function(fz_context*, const(char)*, int, int);
    alias fz_load_system_fallback_font_fn = fz_font* function(fz_context*, int, int, int, int, int);
    /**

	Install functions to allow MuPDF to request fonts from the

	system.



	Only one set of hooks can be in use at a time.

*/
    void fz_install_load_system_font_funcs(fz_context*, fz_font* function(fz_context*, const(char)*, int, int, int), fz_font* function(fz_context*, const(char)*, int, int), fz_font* function(fz_context*, int, int, int, int, int)) @nogc nothrow;
    /**

	Attempt to load a given font from the system.



	name: The name of the desired font.



	bold: 1 if bold desired, 0 otherwise.



	italic: 1 if italic desired, 0 otherwise.



	needs_exact_metrics: 1 if an exact metrical match is required,

	0 otherwise.



	Returns a new font handle, or NULL if no matching font was found

	(or on error).

*/
    fz_font* fz_load_system_font(fz_context*, const(char)*, int, int, int) @nogc nothrow;
    /**

	Attempt to load a given font from

	the system.



	name: The name of the desired font.



	ordering: The ordering to load the font from (e.g. FZ_ADOBE_KOREA)



	serif: 1 if serif desired, 0 otherwise.



	Returns a new font handle, or NULL if no matching font was found

	(or on error).

*/
    fz_font* fz_load_system_cjk_font(fz_context*, const(char)*, int, int) @nogc nothrow;
    /**

	Search the builtin fonts for a match.

	Whether a given font is present or not will depend on the

	configuration in which MuPDF is built.



	name: The name of the font desired.



	bold: 1 if bold desired, 0 otherwise.



	italic: 1 if italic desired, 0 otherwise.



	len: Pointer to a place to receive the length of the discovered

	font buffer.



	Returns a pointer to the font file data, or NULL if not present.

*/
    const(ubyte)* fz_lookup_builtin_font(fz_context*, const(char)*, int, int, int*) @nogc nothrow;
    /**

	Search the builtin base14 fonts for a match.

	Whether a given font is present or not will depend on the

	configuration in which MuPDF is built.



	name: The name of the font desired.



	len: Pointer to a place to receive the length of the discovered

	font buffer.



	Returns a pointer to the font file data, or NULL if not present.

*/
    const(ubyte)* fz_lookup_base14_font(fz_context*, const(char)*, int*) @nogc nothrow;
    /**

	Search the builtin cjk fonts for a match.

	Whether a font is present or not will depend on the

	configuration in which MuPDF is built.



	ordering: The desired ordering of the font (e.g. FZ_ADOBE_KOREA).



	len: Pointer to a place to receive the length of the discovered

	font buffer.



	Returns a pointer to the font file data, or NULL if not present.

*/
    const(ubyte)* fz_lookup_cjk_font(fz_context*, int, int*, int*) @nogc nothrow;
    /**

	Search the builtin cjk fonts for a match for a given language.

	Whether a font is present or not will depend on the

	configuration in which MuPDF is built.



	lang: Pointer to a (case sensitive) language string (e.g.

	"ja", "ko", "zh-Hant" etc).



	len: Pointer to a place to receive the length of the discovered

	font buffer.



	subfont: Pointer to a place to store the subfont index of the

	discovered font.



	Returns a pointer to the font file data, or NULL if not present.

*/
    const(ubyte)* fz_lookup_cjk_font_by_language(fz_context*, const(char)*, int*, int*) @nogc nothrow;
    /**

	Return the matching FZ_ADOBE_* ordering

	for the given language tag, such as "zh-Hant", "zh-Hans", "ja", or "ko".

*/
    int fz_lookup_cjk_ordering_by_language(const(char)*) @nogc nothrow;
    /**

	Search the builtin noto fonts for a match.

	Whether a font is present or not will depend on the

	configuration in which MuPDF is built.



	script: The script desired (e.g. UCDN_SCRIPT_KATAKANA).



	lang: The language desired (e.g. FZ_LANG_ja).



	len: Pointer to a place to receive the length of the discovered

	font buffer.



	Returns a pointer to the font file data, or NULL if not present.

*/
    const(ubyte)* fz_lookup_noto_font(fz_context*, int, int, int*, int*) @nogc nothrow;
    /**

	Search the builtin noto fonts specific symbol fonts.

	Whether a font is present or not will depend on the

	configuration in which MuPDF is built.

*/
    const(ubyte)* fz_lookup_noto_math_font(fz_context*, int*) @nogc nothrow;

    const(ubyte)* fz_lookup_noto_music_font(fz_context*, int*) @nogc nothrow;

    const(ubyte)* fz_lookup_noto_symbol1_font(fz_context*, int*) @nogc nothrow;

    const(ubyte)* fz_lookup_noto_symbol2_font(fz_context*, int*) @nogc nothrow;

    const(ubyte)* fz_lookup_noto_emoji_font(fz_context*, int*) @nogc nothrow;
    /**

	Try to load a fallback font for the

	given combination of font attributes. Whether a font is

	present or not will depend on the configuration in which

	MuPDF is built.



	script: The script desired (e.g. UCDN_SCRIPT_KATAKANA).



	language: The language desired (e.g. FZ_LANG_ja).



	serif: 1 if serif desired, 0 otherwise.



	bold: 1 if bold desired, 0 otherwise.



	italic: 1 if italic desired, 0 otherwise.



	Returns a new font handle, or NULL if not available.

*/
    fz_font* fz_load_fallback_font(fz_context*, int, int, int, int, int) @nogc nothrow;
    /**

	Create a new (empty) type3 font.



	name: Name of font (or NULL).



	matrix: Font matrix.



	Returns a new font handle, or throws exception on

	allocation failure.

*/
    fz_font* fz_new_type3_font(fz_context*, const(char)*, fz_matrix) @nogc nothrow;
    /**

	Create a new font from a font

	file in memory.



	name: Name of font (leave NULL to use name from font).



	data: Pointer to the font file data.



	len: Length of the font file data.



	index: Which font from the file to load (0 for default).



	use_glyph_box: 1 if we should use the glyph bbox, 0 otherwise.



	Returns new font handle, or throws exception on error.

*/
    fz_font* fz_new_font_from_memory(fz_context*, const(char)*, const(ubyte)*, int, int, int) @nogc nothrow;
    /**

	Create a new font from a font file in a fz_buffer.



	name: Name of font (leave NULL to use name from font).



	buffer: Buffer to load from.



	index: Which font from the file to load (0 for default).



	use_glyph_box: 1 if we should use the glyph bbox, 0 otherwise.



	Returns new font handle, or throws exception on error.

*/
    fz_font* fz_new_font_from_buffer(fz_context*, const(char)*, fz_buffer*, int, int) @nogc nothrow;
    /**

	Create a new font from a font file.



	name: Name of font (leave NULL to use name from font).



	path: File path to load from.



	index: Which font from the file to load (0 for default).



	use_glyph_box: 1 if we should use the glyph bbox, 0 otherwise.



	Returns new font handle, or throws exception on error.

*/
    fz_font* fz_new_font_from_file(fz_context*, const(char)*, const(char)*, int, int) @nogc nothrow;
    /**

	Create a new font from one of the built-in fonts.

*/
    fz_font* fz_new_base14_font(fz_context*, const(char)*) @nogc nothrow;

    fz_font* fz_new_cjk_font(fz_context*, int) @nogc nothrow;

    fz_font* fz_new_builtin_font(fz_context*, const(char)*, int, int) @nogc nothrow;
    /**

	Add a reference to an existing fz_font.



	font: The font to add a reference to.



	Returns the same font.

*/
    fz_font* fz_keep_font(fz_context*, fz_font*) @nogc nothrow;
    /**

	Drop a reference to a fz_font, destroying the

	font when the last reference is dropped.



	font: The font to drop a reference to.

*/
    void fz_drop_font(fz_context*, fz_font*) @nogc nothrow;
    /**

	Set the font bbox.



	font: The font to set the bbox for.



	xmin, ymin, xmax, ymax: The bounding box.

*/
    void fz_set_font_bbox(fz_context*, fz_font*, float, float, float, float) @nogc nothrow;
    /**

	Return a bbox for a given glyph in a font.



	font: The font to look for the glyph in.



	gid: The glyph to bound.



	trm: The matrix to apply to the glyph before bounding.



	Returns rectangle by value containing the bounds of the given

	glyph.

*/
    fz_rect fz_bound_glyph(fz_context*, fz_font*, int, fz_matrix) @nogc nothrow;
    /**

	Determine if a given glyph in a font

	is cacheable. Certain glyphs in a type 3 font cannot safely

	be cached, as their appearance depends on the enclosing

	graphic state.



	font: The font to look for the glyph in.



	gif: The glyph to query.



	Returns non-zero if cacheable, 0 if not.

*/
    int fz_glyph_cacheable(fz_context*, fz_font*, int) @nogc nothrow;
    /**

	Run a glyph from a Type3 font to

	a given device.



	font: The font to find the glyph in.



	gid: The glyph to run.



	trm: The transform to apply.



	dev: The device to render onto.

*/
    void fz_run_t3_glyph(fz_context*, fz_font*, int, fz_matrix, fz_device*) @nogc nothrow;
    /**

	Return the advance for a given glyph.



	font: The font to look for the glyph in.



	glyph: The glyph to find the advance for.



	wmode: 1 for vertical mode, 0 for horizontal.



	Returns the advance for the glyph.

*/
    float fz_advance_glyph(fz_context*, fz_font*, int, int) @nogc nothrow;
    /**

	Find the glyph id for a given unicode

	character within a font.



	font: The font to look for the unicode character in.



	unicode: The unicode character to encode.



	Returns the glyph id for the given unicode value, or 0 if

	unknown.

*/
    int fz_encode_character(fz_context*, fz_font*, int) @nogc nothrow;
    /**

	Encode character, preferring small-caps variant if available.



	font: The font to look for the unicode character in.



	unicode: The unicode character to encode.



	Returns the glyph id for the given unicode value, or 0 if

	unknown.

*/
    int fz_encode_character_sc(fz_context*, fz_font*, int) @nogc nothrow;
    /**

	Encode character.



	Either by direct lookup of glyphname within a font, or, failing

	that, by mapping glyphname to unicode and thence to the glyph

	index within the given font.



	Returns zero for type3 fonts.

*/
    int fz_encode_character_by_glyph_name(fz_context*, fz_font*, const(char)*) @nogc nothrow;
    /**

	Find the glyph id for

	a given unicode character within a font, falling back to

	an alternative if not found.



	font: The font to look for the unicode character in.



	unicode: The unicode character to encode.



	script: The script in use.



	language: The language in use.



	out_font: The font handle in which the given glyph represents

	the requested unicode character. The caller does not own the

	reference it is passed, so should call fz_keep_font if it is

	not simply to be used immediately.



	Returns the glyph id for the given unicode value in the supplied

	font (and sets *out_font to font) if it is present. Otherwise

	an alternative fallback font (based on script/language) is

	searched for. If the glyph is found therein, *out_font is set

	to this reference, and the glyph reference is returned. If it

	cannot be found anywhere, the function returns 0.

*/
    int fz_encode_character_with_fallback(fz_context*, fz_font*, int, int, int, fz_font**) @nogc nothrow;
    /**

	Find the name of a glyph



	font: The font to look for the glyph in.



	glyph: The glyph id to look for.



	buf: Pointer to a buffer for the name to be inserted into.



	size: The size of the buffer.



	If a font contains a name table, then the name of the glyph

	will be returned in the supplied buffer. Otherwise a name

	is synthesised. The name will be truncated to fit in

	the buffer.

*/
    void fz_get_glyph_name(fz_context*, fz_font*, int, char*, int) @nogc nothrow;
    /**

	Retrieve font ascender in ems.

*/
    float fz_font_ascender(fz_context*, fz_font*) @nogc nothrow;
    /**

	Retrieve font descender in ems.

*/
    float fz_font_descender(fz_context*, fz_font*) @nogc nothrow;
    /**

	Retrieve the MD5 digest for the font's data.

*/
    void fz_font_digest(fz_context*, fz_font*, ubyte*) @nogc nothrow;

    void fz_decouple_type3_font(fz_context*, fz_font*, void*) @nogc nothrow;
    /**

	map an FT error number to a

	static string.



	err: The error number to lookup.



	Returns a pointer to a static textual representation

	of a freetype error.

*/
    const(char)* ft_error_string(int) @nogc nothrow;

    int ft_char_index(void*, int) @nogc nothrow;

    int ft_name_index(void*, const(char)*) @nogc nothrow;
    /**

	Lock against Harfbuzz being called

	simultaneously in several threads. This reuses

	FZ_LOCK_FREETYPE.

*/
    void fz_hb_lock(fz_context*) @nogc nothrow;
    /**

	Unlock after a Harfbuzz call. This reuses

	FZ_LOCK_FREETYPE.

*/
    void fz_hb_unlock(fz_context*) @nogc nothrow;
    /**

	Find the start of the first occurrence of the substring needle in haystack.

*/
    void* fz_memmem(const(void)*, ulong, const(void)*, ulong) @nogc nothrow;
    /**

	Concatenate 2 strings, with a maximum length.



	dst: pointer to first string in a buffer of n bytes.



	src: pointer to string to concatenate.



	n: Size (in bytes) of buffer that dst is in.



	Returns the real length that a concatenated dst + src would have

	been (not including terminator).

*/
    ulong fz_strlcat(char*, const(char)*, ulong) @nogc nothrow;
    /**

	Copy at most n-1 chars of a string into a destination

	buffer with null termination, returning the real length of the

	initial string (excluding terminator).



	dst: Destination buffer, at least n bytes long.



	src: C string (non-NULL).



	n: Size of dst buffer in bytes.



	Returns the length (excluding terminator) of src.

*/
    ulong fz_strlcpy(char*, const(char)*, ulong) @nogc nothrow;
    /**

	Given a pointer to a C string (or a pointer to NULL) break

	it at the first occurrence of a delimiter char (from a given

	set).



	stringp: Pointer to a C string pointer (or NULL). Updated on

	exit to point to the first char of the string after the

	delimiter that was found. The string pointed to by stringp will

	be corrupted by this call (as the found delimiter will be

	overwritten by 0).



	delim: A C string of acceptable delimiter characters.



	Returns a pointer to a C string containing the chars of stringp

	up to the first delimiter char (or the end of the string), or

	NULL.

*/
    char* fz_strsep(char**, const(char)*) @nogc nothrow;
    /**

	Return strlen(s), if that is less than maxlen, or maxlen if

	there is no null byte ('\0') among the first maxlen bytes.

*/
    ulong fz_strnlen(const(char)*, ulong) @nogc nothrow;
    /**

	Range checking atof

*/
    float fz_atof(const(char)*) @nogc nothrow;
    /**

	atoi that copes with NULL

*/
    int fz_atoi(const(char)*) @nogc nothrow;
    /**

	64bit atoi that copes with NULL

*/
    long fz_atoi64(const(char)*) @nogc nothrow;
    /**

	fz_point is a point in a two-dimensional space.

*/
    struct fz_point
    {

        float x;

        float y;
    }
    /**

	Create a stream from a FILE * that will not be closed

	when the stream is dropped.

*/
    fz_stream* fz_open_file_ptr_no_close(fz_context*, _iobuf*) @nogc nothrow;

    struct fz_rect
    {

        float x0;

        float y0;

        float x1;

        float y1;
    }
    /**

	fz_irect is a rectangle using integers instead of floats.



	It's used in the draw device and for pixmap dimensions.

*/
    struct fz_irect
    {

        int x0;

        int y0;

        int x1;

        int y1;
    }
    /**

	A rectangle with sides of length one.



	The bottom left corner is at (0, 0) and the top right corner

	is at (1, 1).

*/
    extern __gshared const(fz_rect) fz_unit_rect;
    /**

	An empty rectangle with an area equal to zero.

*/
    extern __gshared const(fz_rect) fz_empty_rect;

    extern __gshared const(fz_irect) fz_empty_irect;
    /**

	An infinite rectangle.

*/
    extern __gshared const(fz_rect) fz_infinite_rect;

    extern __gshared const(fz_irect) fz_infinite_irect;
    /**

	fz_matrix is a row-major 3x3 matrix used for representing

	transformations of coordinates throughout MuPDF.



	Since all points reside in a two-dimensional space, one vector

	is always a constant unit vector; hence only some elements may

	vary in a matrix. Below is how the elements map between

	different representations.



	/ a b 0 \

	| c d 0 | normally represented as [ a b c d e f ].

	\ e f 1 /

*/
    struct fz_matrix
    {

        float a;

        float b;

        float c;

        float d;

        float e;

        float f;
    }
    /**

	Identity transform matrix.

*/
    extern __gshared const(fz_matrix) fz_identity;
    /**

	Multiply two matrices.



	The order of the two matrices are important since matrix

	multiplication is not commutative.



	Returns result.

*/
    fz_matrix fz_concat(fz_matrix, fz_matrix) @nogc nothrow;
    /**

	Create a scaling matrix.



	The returned matrix is of the form [ sx 0 0 sy 0 0 ].



	m: Pointer to the matrix to populate



	sx, sy: Scaling factors along the X- and Y-axes. A scaling

	factor of 1.0 will not cause any scaling along the relevant

	axis.



	Returns m.

*/
    fz_matrix fz_scale(float, float) @nogc nothrow;
    /**

	Scale a matrix by premultiplication.



	m: Pointer to the matrix to scale



	sx, sy: Scaling factors along the X- and Y-axes. A scaling

	factor of 1.0 will not cause any scaling along the relevant

	axis.



	Returns m (updated).

*/
    fz_matrix fz_pre_scale(fz_matrix, float, float) @nogc nothrow;
    /**

	Scale a matrix by postmultiplication.



	m: Pointer to the matrix to scale



	sx, sy: Scaling factors along the X- and Y-axes. A scaling

	factor of 1.0 will not cause any scaling along the relevant

	axis.



	Returns m (updated).

*/
    fz_matrix fz_post_scale(fz_matrix, float, float) @nogc nothrow;
    /**

	Create a shearing matrix.



	The returned matrix is of the form [ 1 sy sx 1 0 0 ].



	m: pointer to place to store returned matrix



	sx, sy: Shearing factors. A shearing factor of 0.0 will not

	cause any shearing along the relevant axis.



	Returns m.

*/
    fz_matrix fz_shear(float, float) @nogc nothrow;
    /**

	Premultiply a matrix with a shearing matrix.



	The shearing matrix is of the form [ 1 sy sx 1 0 0 ].



	m: pointer to matrix to premultiply



	sx, sy: Shearing factors. A shearing factor of 0.0 will not

	cause any shearing along the relevant axis.



	Returns m (updated).

*/
    fz_matrix fz_pre_shear(fz_matrix, float, float) @nogc nothrow;
    /**

	Create a rotation matrix.



	The returned matrix is of the form

	[ cos(deg) sin(deg) -sin(deg) cos(deg) 0 0 ].



	m: Pointer to place to store matrix



	degrees: Degrees of counter clockwise rotation. Values less

	than zero and greater than 360 are handled as expected.



	Returns m.

*/
    fz_matrix fz_rotate(float) @nogc nothrow;
    /**

	Rotate a transformation by premultiplying.



	The premultiplied matrix is of the form

	[ cos(deg) sin(deg) -sin(deg) cos(deg) 0 0 ].



	m: Pointer to matrix to premultiply.



	degrees: Degrees of counter clockwise rotation. Values less

	than zero and greater than 360 are handled as expected.



	Returns m (updated).

*/
    fz_matrix fz_pre_rotate(fz_matrix, float) @nogc nothrow;
    /**

	Create a translation matrix.



	The returned matrix is of the form [ 1 0 0 1 tx ty ].



	m: A place to store the created matrix.



	tx, ty: Translation distances along the X- and Y-axes. A

	translation of 0 will not cause any translation along the

	relevant axis.



	Returns m.

*/
    fz_matrix fz_translate(float, float) @nogc nothrow;
    /**

	Translate a matrix by premultiplication.



	m: The matrix to translate



	tx, ty: Translation distances along the X- and Y-axes. A

	translation of 0 will not cause any translation along the

	relevant axis.



	Returns m.

*/
    fz_matrix fz_pre_translate(fz_matrix, float, float) @nogc nothrow;
    /**

	Create transform matrix to draw page

	at a given resolution and rotation. Adjusts the scaling

	factors so that the page covers whole number of

	pixels and adjust the page origin to be at 0,0.

*/
    fz_matrix fz_transform_page(fz_rect, float, float) @nogc nothrow;
    /**

	Create an inverse matrix.



	inverse: Place to store inverse matrix.



	matrix: Matrix to invert. A degenerate matrix, where the

	determinant is equal to zero, can not be inverted and the

	original matrix is returned instead.



	Returns inverse.

*/
    fz_matrix fz_invert_matrix(fz_matrix) @nogc nothrow;
    /**

	Attempt to create an inverse matrix.



	inverse: Place to store inverse matrix.



	matrix: Matrix to invert. A degenerate matrix, where the

	determinant is equal to zero, can not be inverted.



	Returns 1 if matrix is degenerate (singular), or 0 otherwise.

*/
    int fz_try_invert_matrix(fz_matrix*, fz_matrix) @nogc nothrow;
    /**

	Check if a transformation is rectilinear.



	Rectilinear means that no shearing is present and that any

	rotations present are a multiple of 90 degrees. Usually this

	is used to make sure that axis-aligned rectangles before the

	transformation are still axis-aligned rectangles afterwards.

*/
    int fz_is_rectilinear(fz_matrix) @nogc nothrow;
    /**

	Calculate average scaling factor of matrix.

*/
    float fz_matrix_expansion(fz_matrix) @nogc nothrow;
    /**

	Compute intersection of two rectangles.



	Given two rectangles, update the first to be the smallest

	axis-aligned rectangle that covers the area covered by both

	given rectangles. If either rectangle is empty then the

	intersection is also empty. If either rectangle is infinite

	then the intersection is simply the non-infinite rectangle.

	Should both rectangles be infinite, then the intersection is

	also infinite.

*/
    fz_rect fz_intersect_rect(fz_rect, fz_rect) @nogc nothrow;
    /**

	Compute intersection of two bounding boxes.



	Similar to fz_intersect_rect but operates on two bounding

	boxes instead of two rectangles.

*/
    fz_irect fz_intersect_irect(fz_irect, fz_irect) @nogc nothrow;
    /**

	Compute union of two rectangles.



	Given two rectangles, update the first to be the smallest

	axis-aligned rectangle that encompasses both given rectangles.

	If either rectangle is infinite then the union is also infinite.

	If either rectangle is empty then the union is simply the

	non-empty rectangle. Should both rectangles be empty, then the

	union is also empty.

*/
    fz_rect fz_union_rect(fz_rect, fz_rect) @nogc nothrow;
    /**

	Convert a rect into the minimal bounding box

	that covers the rectangle.



	Coordinates in a bounding box are integers, so rounding of the

	rects coordinates takes place. The top left corner is rounded

	upwards and left while the bottom right corner is rounded

	downwards and to the right.

*/
    fz_irect fz_irect_from_rect(fz_rect) @nogc nothrow;
    /**

	Round rectangle coordinates.



	Coordinates in a bounding box are integers, so rounding of the

	rects coordinates takes place. The top left corner is rounded

	upwards and left while the bottom right corner is rounded

	downwards and to the right.



	This differs from fz_irect_from_rect, in that fz_irect_from_rect

	slavishly follows the numbers (i.e any slight over/under

	calculations can cause whole extra pixels to be added).

	fz_round_rect allows for a small amount of rounding error when

	calculating the bbox.

*/
    fz_irect fz_round_rect(fz_rect) @nogc nothrow;
    /**

	Convert a bbox into a rect.



	For our purposes, a rect can represent all the values we meet in

	a bbox, so nothing can go wrong.



	rect: A place to store the generated rectangle.



	bbox: The bbox to convert.



	Returns rect (updated).

*/
    fz_rect fz_rect_from_irect(fz_irect) @nogc nothrow;
    /**

	Expand a bbox by a given amount in all directions.

*/
    fz_rect fz_expand_rect(fz_rect, float) @nogc nothrow;

    fz_irect fz_expand_irect(fz_irect, int) @nogc nothrow;
    /**

	Expand a bbox to include a given point.

	To create a rectangle that encompasses a sequence of points, the

	rectangle must first be set to be the empty rectangle at one of

	the points before including the others.

*/
    fz_rect fz_include_point_in_rect(fz_rect, fz_point) @nogc nothrow;
    /**

	Translate bounding box.



	Translate a bbox by a given x and y offset. Allows for overflow.

*/
    fz_rect fz_translate_rect(fz_rect, float, float) @nogc nothrow;

    fz_irect fz_translate_irect(fz_irect, int, int) @nogc nothrow;
    /**

	Test rectangle inclusion.



	Return true if a entirely contains b.

*/
    int fz_contains_rect(fz_rect, fz_rect) @nogc nothrow;
    /**

	Apply a transformation to a point.



	transform: Transformation matrix to apply. See fz_concat,

	fz_scale, fz_rotate and fz_translate for how to create a

	matrix.



	point: Pointer to point to update.



	Returns transform (unchanged).

*/
    fz_point fz_transform_point(fz_point, fz_matrix) @nogc nothrow;

    fz_point fz_transform_point_xy(float, float, fz_matrix) @nogc nothrow;
    /**

	Apply a transformation to a vector.



	transform: Transformation matrix to apply. See fz_concat,

	fz_scale and fz_rotate for how to create a matrix. Any

	translation will be ignored.



	vector: Pointer to vector to update.

*/
    fz_point fz_transform_vector(fz_point, fz_matrix) @nogc nothrow;
    /**

	Apply a transform to a rectangle.



	After the four corner points of the axis-aligned rectangle

	have been transformed it may not longer be axis-aligned. So a

	new axis-aligned rectangle is created covering at least the

	area of the transformed rectangle.



	transform: Transformation matrix to apply. See fz_concat,

	fz_scale and fz_rotate for how to create a matrix.



	rect: Rectangle to be transformed. The two special cases

	fz_empty_rect and fz_infinite_rect, may be used but are

	returned unchanged as expected.

*/
    fz_rect fz_transform_rect(fz_rect, fz_matrix) @nogc nothrow;
    /**

	Normalize a vector to length one.

*/
    fz_point fz_normalize_vector(fz_point) @nogc nothrow;
    /**

	Grid fit a matrix.



	as_tiled = 0 => adjust the matrix so that the image of the unit

	square completely covers any pixel that was touched by the

	image of the unit square under the original matrix.



	as_tiled = 1 => adjust the matrix so that the corners of the

	image of the unit square align with the closest integer corner

	of the image of the unit square under the original matrix.

*/
    fz_matrix fz_gridfit_matrix(int, fz_matrix) @nogc nothrow;
    /**

	Find the largest expansion performed by this matrix.

	(i.e. max(abs(m.a),abs(m.b),abs(m.c),abs(m.d))

*/
    float fz_matrix_max_expansion(fz_matrix) @nogc nothrow;
    /**

	A representation for a region defined by 4 points.



	The significant difference between quads and rects is that

	the edges of quads are not axis aligned.

*/
    struct fz_quad
    {

        fz_point ul;

        fz_point ur;

        fz_point ll;

        fz_point lr;
    }
    /**

	Convert a rect to a quad (losslessly).

*/
    fz_quad fz_quad_from_rect(fz_rect) @nogc nothrow;
    /**

	Convert a quad to the smallest rect that covers it.

*/
    fz_rect fz_rect_from_quad(fz_quad) @nogc nothrow;
    /**

	Transform a quad by a matrix.

*/
    fz_quad fz_transform_quad(fz_quad, fz_matrix) @nogc nothrow;
    /**

	Inclusion test for quads.

*/
    int fz_is_point_inside_quad(fz_point, fz_quad) @nogc nothrow;
    /**

	Inclusion test for rects. (Rect is assumed to be open, i.e.

	top right corner is not included).

*/
    int fz_is_point_inside_rect(fz_point, fz_rect) @nogc nothrow;
    /**

	Inclusion test for irects. (Rect is assumed to be open, i.e.

	top right corner is not included).

*/
    int fz_is_point_inside_irect(int, int, fz_irect) @nogc nothrow;
    /**

	Inclusion test for quad in quad.



	This may break down if quads are not 'well formed'.

*/
    int fz_is_quad_inside_quad(fz_quad, fz_quad) @nogc nothrow;
    /**

	Intersection test for quads.



	This may break down if quads are not 'well formed'.

*/
    int fz_is_quad_intersecting_quad(fz_quad, fz_quad) @nogc nothrow;
    /**

	Simple functions/variables for use in tools.

*/
    int fz_getopt(int, char**, const(char)*) @nogc nothrow;

    extern __gshared int fz_optind;

    extern __gshared char* fz_optarg;
    /**

	Purge all the glyphs from the cache.

*/
    void fz_purge_glyph_cache(fz_context*) @nogc nothrow;
    /**

	Create a pixmap containing a rendered glyph.



	Lookup gid from font, clip it with scissor, and rendering it

	with aa bits of antialiasing into a new pixmap.



	The caller takes ownership of the pixmap and so must free it.



	Note: This function is no longer used for normal rendering

	operations, and is kept around just because we use it in the

	app. It should be considered "at risk" of removal from the API.

*/
    fz_pixmap* fz_render_glyph_pixmap(fz_context*, fz_font*, int, fz_matrix*, const(fz_irect)*, int) @nogc nothrow;
    /**

	Nasty PDF interpreter specific hernia, required to allow the

	interpreter to replay glyphs from a type3 font directly into

	the target device.



	This is only used in exceptional circumstances (such as type3

	glyphs that inherit current graphics state, or nested type3

	glyphs).

*/
    void fz_render_t3_glyph_direct(fz_context*, fz_device*, fz_font*, int, fz_matrix, void*, fz_default_colorspaces*) @nogc nothrow;
    /**

	Force a type3 font to cache the displaylist for a given glyph

	id.



	This caching can involve reading the underlying file, so must

	happen ahead of time, so we aren't suddenly forced to read the

	file while playing a displaylist back.

*/
    void fz_prepare_t3_glyph(fz_context*, fz_font*, int) @nogc nothrow;
    /**

	Dump debug statistics for the glyph cache.

*/
    void fz_dump_glyph_cache_stats(fz_context*, fz_output*) @nogc nothrow;
    /**

	Perform subpixel quantisation and adjustment on a glyph matrix.



	ctm: On entry, the desired 'ideal' transformation for a glyph.

	On exit, adjusted to a (very similar) transformation quantised

	for subpixel caching.



	subpix_ctm: Initialised by the routine to the transform that

	should be used to render the glyph.



	qe, qf: which subpixel position we quantised to.



	Returns: the size of the glyph.



	Note: This is currently only exposed for use in our app. It

	should be considered "at risk" of removal from the API.

*/
    float fz_subpixel_adjust(fz_context*, fz_matrix*, fz_matrix*, ubyte*, ubyte*) @nogc nothrow;
    struct fz_glyph;
    /**

	Return the bounding box of the glyph in pixels.

*/
    fz_irect fz_glyph_bbox(fz_context*, fz_glyph*) @nogc nothrow;

    fz_irect fz_glyph_bbox_no_ctx(fz_glyph*) @nogc nothrow;
    /**

	Return the width of the glyph in pixels.

*/
    int fz_glyph_width(fz_context*, fz_glyph*) @nogc nothrow;
    /**

	Return the height of the glyph in pixels.

*/
    int fz_glyph_height(fz_context*, fz_glyph*) @nogc nothrow;
    /**

	Take a reference to a glyph.



	pix: The glyph to increment the reference for.



	Returns pix.

*/
    fz_glyph* fz_keep_glyph(fz_context*, fz_glyph*) @nogc nothrow;
    /**

	Drop a reference and free a glyph.



	Decrement the reference count for the glyph. When no

	references remain the glyph will be freed.

*/
    void fz_drop_glyph(fz_context*, fz_glyph*) @nogc nothrow;
    /**

	Look a glyph up from a font, and return the outline of the

	glyph using the given transform.



	The caller owns the returned path, and so is responsible for

	ensuring that it eventually gets dropped.

*/
    fz_path* fz_outline_glyph(fz_context*, fz_font*, int, fz_matrix) @nogc nothrow;
    struct fz_hash_table;
    alias fz_hash_table_drop_fn = void function(fz_context*, void*);
    /**

	Create a new hash table.



	initialsize: The initial size of the hashtable. The hashtable

	may grow (double in size) if it starts to get crowded (80%

	full).



	keylen: byte length for each key.



	lock: -1 for no lock, otherwise the FZ_LOCK to use to protect

	this table.



	drop_val: Function to use to destroy values on table drop.

*/
    fz_hash_table* fz_new_hash_table(fz_context*, int, int, int, void function(fz_context*, void*)) @nogc nothrow;
    /**

	Destroy the hash table.



	Values are dropped using the drop function.

*/
    void fz_drop_hash_table(fz_context*, fz_hash_table*) @nogc nothrow;
    /**

	Search for a matching hash within the table, and return the

	associated value.

*/
    void* fz_hash_find(fz_context*, fz_hash_table*, const(void)*) @nogc nothrow;
    /**

	Insert a new key/value pair into the hash table.



	If an existing entry with the same key is found, no change is

	made to the hash table, and a pointer to the existing value is

	returned.



	If no existing entry with the same key is found, ownership of

	val passes in, key is copied, and NULL is returned.

*/
    void* fz_hash_insert(fz_context*, fz_hash_table*, const(void)*, void*) @nogc nothrow;
    /**

	Remove the entry for a given key.



	The value is NOT freed, so the caller is expected to take care

	of this.

*/
    void fz_hash_remove(fz_context*, fz_hash_table*, const(void)*) @nogc nothrow;
    alias fz_hash_table_for_each_fn = void function(fz_context*, void*, void*, int, void*);
    /**

	Iterate over the entries in a hash table.

*/
    void fz_hash_for_each(fz_context*, fz_hash_table*, void*, void function(fz_context*, void*, void*, int, void*)) @nogc nothrow;
    alias fz_hash_table_filter_fn = int function(fz_context*, void*, void*, int, void*);
    /**

	Iterate over the entries in a hash table, removing all the ones where callback returns true.

	Does NOT free the value of the entry, so the caller is expected to take care of this.

*/
    void fz_hash_filter(fz_context*, fz_hash_table*, void*, int function(fz_context*, void*, void*, int, void*)) @nogc nothrow;
    /**

	Structure is public to allow other structures to

	be derived from it. Do not access members directly.

*/
    struct fz_image
    {
        import std.bitmanip: bitfields;

        align(4):

        fz_key_storable key_storable;

        int w;

        int h;

        ubyte n;

        ubyte bpc;
        mixin(bitfields!(

            uint, "imagemask", 1,

            uint, "interpolate", 1,

            uint, "use_colorkey", 1,

            uint, "use_decode", 1,

            uint, "invert_cmyk_jpeg", 1,

            uint, "decoded", 1,

            uint, "scalable", 1,
            uint, "_padding_0", 1
        ));

        ubyte orientation;

        fz_image* mask;

        int xres;

        int yres;

        fz_colorspace* colorspace;

        void function(fz_context*, fz_image*) drop_image;

        fz_pixmap* function(fz_context*, fz_image*, fz_irect*, int, int, int*) get_pixmap;

        ulong function(fz_context*, fz_image*) get_size;

        int[64] colorkey;

        float[64] decode;
    }
    struct fz_compressed_image;
    struct fz_pixmap_image;
    /**

	Called to get a handle to a pixmap from an image.



	image: The image to retrieve a pixmap from.



	subarea: The subarea of the image that we actually care about

	(or NULL to indicate the whole image).



	ctm: Optional, unless subarea is given. If given, then on

	entry this is the transform that will be applied to the complete

	image. It should be updated on exit to the transform to apply to

	the given subarea of the image. This is used to calculate the

	desired width/height for subsampling.



	w: If non-NULL, a pointer to an int to be updated on exit to the

	width (in pixels) that the scaled output will cover.



	h: If non-NULL, a pointer to an int to be updated on exit to the

	height (in pixels) that the scaled output will cover.



	Returns a non NULL kept pixmap pointer. May throw exceptions.

*/
    fz_pixmap* fz_get_pixmap_from_image(fz_context*, fz_image*, const(fz_irect)*, fz_matrix*, int*, int*) @nogc nothrow;
    /**

	Calls fz_get_pixmap_from_image() with ctm, subarea, w and h all set to NULL.

*/
    fz_pixmap* fz_get_unscaled_pixmap_from_image(fz_context*, fz_image*) @nogc nothrow;
    /**

	Increment the (normal) reference count for an image. Returns the

	same pointer.



	Never throws exceptions.

*/
    fz_image* fz_keep_image(fz_context*, fz_image*) @nogc nothrow;
    /**

	Decrement the (normal) reference count for an image. When the

	total (normal + key) reference count reaches zero, the image and

	its resources are freed.



	Never throws exceptions.

*/
    void fz_drop_image(fz_context*, fz_image*) @nogc nothrow;
    /**

	Increment the store key reference for an image. Returns the same

	pointer. (This is the count of references for an image held by

	keys in the image store).



	Never throws exceptions.

*/
    fz_image* fz_keep_image_store_key(fz_context*, fz_image*) @nogc nothrow;
    /**

	Decrement the store key reference count for an image. When the

	total (normal + key) reference count reaches zero, the image and

	its resources are freed.



	Never throws exceptions.

*/
    void fz_drop_image_store_key(fz_context*, fz_image*) @nogc nothrow;
    alias fz_drop_image_fn = void function(fz_context*, fz_image*);
    alias fz_image_get_pixmap_fn = fz_pixmap* function(fz_context*, fz_image*, fz_irect*, int, int, int*);
    alias fz_image_get_size_fn = ulong function(fz_context*, fz_image*);
    /**

	Internal function to make a new fz_image structure

	for a derived class.



	w,h: Width and height of the created image.



	bpc: Bits per component.



	colorspace: The colorspace (determines the number of components,

	and any color conversions required while decoding).



	xres, yres: The X and Y resolutions respectively.



	interpolate: 1 if interpolation should be used when decoding

	this image, 0 otherwise.



	imagemask: 1 if this is an imagemask (i.e. transparent), 0

	otherwise.



	decode: NULL, or a pointer to to a decode array. The default

	decode array is [0 1] (repeated n times, for n color components).



	colorkey: NULL, or a pointer to a colorkey array. The default

	colorkey array is [0 255] (repeated n times, for n color

	components).



	mask: NULL, or another image to use as a mask for this one.

	A new reference is taken to this image. Supplying a masked

	image as a mask to another image is illegal!



	size: The size of the required allocated structure (the size of

	the derived structure).



	get: The function to be called to obtain a decoded pixmap.



	get_size: The function to be called to return the storage size

	used by this image.



	drop: The function to be called to dispose of this image once

	the last reference is dropped.



	Returns a pointer to an allocated structure of the required size,

	with the first sizeof(fz_image) bytes initialised as appropriate

	given the supplied parameters, and the other bytes set to zero.

*/
    fz_image* fz_new_image_of_size(fz_context*, int, int, int, fz_colorspace*, int, int, int, int, float*, int*, fz_image*, ulong, fz_pixmap* function(fz_context*, fz_image*, fz_irect*, int, int, int*), ulong function(fz_context*, fz_image*), void function(fz_context*, fz_image*)) @nogc nothrow;
    /**

	Create an image based on

	the data in the supplied compressed buffer.



	w,h: Width and height of the created image.



	bpc: Bits per component.



	colorspace: The colorspace (determines the number of components,

	and any color conversions required while decoding).



	xres, yres: The X and Y resolutions respectively.



	interpolate: 1 if interpolation should be used when decoding

	this image, 0 otherwise.



	imagemask: 1 if this is an imagemask (i.e. transparency bitmap

	mask), 0 otherwise.



	decode: NULL, or a pointer to to a decode array. The default

	decode array is [0 1] (repeated n times, for n color components).



	colorkey: NULL, or a pointer to a colorkey array. The default

	colorkey array is [0 255] (repeated n times, for n color

	components).



	buffer: Buffer of compressed data and compression parameters.

	Ownership of this reference is passed in.



	mask: NULL, or another image to use as a mask for this one.

	A new reference is taken to this image. Supplying a masked

	image as a mask to another image is illegal!

*/
    fz_image* fz_new_image_from_compressed_buffer(fz_context*, int, int, int, fz_colorspace*, int, int, int, int, float*, int*, fz_compressed_buffer*, fz_image*) @nogc nothrow;
    /**

	Create an image from the given

	pixmap.



	pixmap: The pixmap to base the image upon. A new reference

	to this is taken.



	mask: NULL, or another image to use as a mask for this one.

	A new reference is taken to this image. Supplying a masked

	image as a mask to another image is illegal!

*/
    fz_image* fz_new_image_from_pixmap(fz_context*, fz_pixmap*, fz_image*) @nogc nothrow;
    /**

	Create a new image from a

	buffer of data, inferring its type from the format

	of the data.

*/
    fz_image* fz_new_image_from_buffer(fz_context*, fz_buffer*) @nogc nothrow;
    /**

	Create a new image from the contents

	of a file, inferring its type from the format of the

	data.

*/
    fz_image* fz_new_image_from_file(fz_context*, const(char)*) @nogc nothrow;
    /**

	Internal destructor exposed for fz_store integration.

*/
    void fz_drop_image_imp(fz_context*, fz_storable*) @nogc nothrow;
    /**

	Internal destructor for the base image class members.



	Exposed to allow derived image classes to be written.

*/
    void fz_drop_image_base(fz_context*, fz_image*) @nogc nothrow;
    /**

	Decode a subarea of a compressed image. l2factor is the amount

	of subsampling inbuilt to the stream (i.e. performed by the

	decoder). If non NULL, l2extra is the extra amount of

	subsampling that should be performed by this routine. This will

	be updated on exit to the amount of subsampling that is still

	required to be done.



	Returns a kept reference.

*/
    fz_pixmap* fz_decomp_image_from_stream(fz_context*, fz_stream*, fz_compressed_image*, fz_irect*, int, int, int*) @nogc nothrow;
    /**

	Convert pixmap from indexed to base colorspace.



	This creates a new bitmap containing the converted pixmap data.

 */
    fz_pixmap* fz_convert_indexed_pixmap_to_base(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Convert pixmap from DeviceN/Separation to base colorspace.



	This creates a new bitmap containing the converted pixmap data.

*/
    fz_pixmap* fz_convert_separation_pixmap_to_base(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Return the size of the storage used by an image.

*/
    ulong fz_image_size(fz_context*, fz_image*) @nogc nothrow;
    /**

	Request the natural resolution

	of an image.



	xres, yres: Pointers to ints to be updated with the

	natural resolution of an image (or a sensible default

	if not encoded).

*/
    void fz_image_resolution(fz_image*, int*, int*) @nogc nothrow;
    /**

	Request the natural orientation of an image.



	This is for images (such as JPEG) that can contain internal

	specifications of rotation/flips. This is ignored by all the

	internal decode/rendering routines, but can be used by callers

	(such as the image document handler) to respect such

	specifications.



	The values used by MuPDF are as follows, with the equivalent

	Exif specifications given for information:



	0: Undefined

	1: 0 degree ccw rotation. (Exif = 1)

	2: 90 degree ccw rotation. (Exif = 8)

	3: 180 degree ccw rotation. (Exif = 3)

	4: 270 degree ccw rotation. (Exif = 6)

	5: flip on X. (Exif = 2)

	6: flip on X, then rotate ccw by 90 degrees. (Exif = 5)

	7: flip on X, then rotate ccw by 180 degrees. (Exif = 4)

	8: flip on X, then rotate ccw by 270 degrees. (Exif = 7)

*/
    ubyte fz_image_orientation(fz_context*, fz_image*) @nogc nothrow;

    fz_matrix fz_image_orientation_matrix(fz_context*, fz_image*) @nogc nothrow;
    /**

	Retrieve the underlying compressed data for an image.



	Returns a pointer to the underlying data buffer for an image,

	or NULL if this image is not based upon a compressed data

	buffer.



	This is not a reference counted structure, so no reference is

	returned. Lifespan is limited to that of the image itself.

*/
    fz_compressed_buffer* fz_compressed_image_buffer(fz_context*, fz_image*) @nogc nothrow;

    void fz_set_compressed_image_buffer(fz_context*, fz_compressed_image*, fz_compressed_buffer*) @nogc nothrow;
    /**

	Retrieve the underlying fz_pixmap for an image.



	Returns a pointer to the underlying fz_pixmap for an image,

	or NULL if this image is not based upon an fz_pixmap.



	No reference is returned. Lifespan is limited to that of

	the image itself. If required, use fz_keep_pixmap to take

	a reference to keep it longer.

*/
    fz_pixmap* fz_pixmap_image_tile(fz_context*, fz_pixmap_image*) @nogc nothrow;

    void fz_set_pixmap_image_tile(fz_context*, fz_pixmap_image*, fz_pixmap*) @nogc nothrow;
    /**

	Exposed for PDF.

*/
    fz_pixmap* fz_load_jpx(fz_context*, const(ubyte)*, ulong, fz_colorspace*) @nogc nothrow;
    /**

	Exposed for CBZ.

*/
    int fz_load_tiff_subimage_count(fz_context*, const(ubyte)*, ulong) @nogc nothrow;

    fz_pixmap* fz_load_tiff_subimage(fz_context*, const(ubyte)*, ulong, int) @nogc nothrow;

    int fz_load_pnm_subimage_count(fz_context*, const(ubyte)*, ulong) @nogc nothrow;

    fz_pixmap* fz_load_pnm_subimage(fz_context*, const(ubyte)*, ulong, int) @nogc nothrow;

    int fz_load_jbig2_subimage_count(fz_context*, const(ubyte)*, ulong) @nogc nothrow;

    fz_pixmap* fz_load_jbig2_subimage(fz_context*, const(ubyte)*, ulong, int) @nogc nothrow;

    int fz_load_bmp_subimage_count(fz_context*, const(ubyte)*, ulong) @nogc nothrow;

    fz_pixmap* fz_load_bmp_subimage(fz_context*, const(ubyte)*, ulong, int) @nogc nothrow;
    /**

	fz_link is a list of interactive links on a page.



	There is no relation between the order of the links in the

	list and the order they appear on the page. The list of links

	for a given page can be obtained from fz_load_links.



	A link is reference counted. Dropping a reference to a link is

	done by calling fz_drop_link.



	rect: The hot zone. The area that can be clicked in

	untransformed coordinates.



	uri: Link destinations come in two forms: internal and external.

	Internal links refer to other pages in the same document.

	External links are URLs to other documents.



	next: A pointer to the next link on the same page.

*/
    struct fz_link
    {

        int refs;

        fz_link* next;

        fz_rect rect;

        char* uri;

        void function(fz_context*, fz_link*, fz_rect) set_rect_fn;

        void function(fz_context*, fz_link*, const(char)*) set_uri_fn;

        void function(fz_context*, fz_link*) drop;
    }
    alias fz_link_set_rect_fn = void function(fz_context*, fz_link*, fz_rect);
    alias fz_link_set_uri_fn = void function(fz_context*, fz_link*, const(char)*);
    alias fz_link_drop_link_fn = void function(fz_context*, fz_link*);

    alias fz_link_dest_type = _Anonymous_61;

    enum _Anonymous_61
    {

        FZ_LINK_DEST_FIT = 0,

        FZ_LINK_DEST_FIT_B = 1,

        FZ_LINK_DEST_FIT_H = 2,

        FZ_LINK_DEST_FIT_BH = 3,

        FZ_LINK_DEST_FIT_V = 4,

        FZ_LINK_DEST_FIT_BV = 5,

        FZ_LINK_DEST_FIT_R = 6,

        FZ_LINK_DEST_XYZ = 7,
    }
    enum FZ_LINK_DEST_FIT = _Anonymous_61.FZ_LINK_DEST_FIT;
    enum FZ_LINK_DEST_FIT_B = _Anonymous_61.FZ_LINK_DEST_FIT_B;
    enum FZ_LINK_DEST_FIT_H = _Anonymous_61.FZ_LINK_DEST_FIT_H;
    enum FZ_LINK_DEST_FIT_BH = _Anonymous_61.FZ_LINK_DEST_FIT_BH;
    enum FZ_LINK_DEST_FIT_V = _Anonymous_61.FZ_LINK_DEST_FIT_V;
    enum FZ_LINK_DEST_FIT_BV = _Anonymous_61.FZ_LINK_DEST_FIT_BV;
    enum FZ_LINK_DEST_FIT_R = _Anonymous_61.FZ_LINK_DEST_FIT_R;
    enum FZ_LINK_DEST_XYZ = _Anonymous_61.FZ_LINK_DEST_XYZ;

    struct fz_link_dest
    {

        fz_location loc;

        fz_link_dest_type type;

        float x;

        float y;

        float w;

        float h;

        float zoom;
    }

    fz_link_dest fz_make_link_dest_none() @nogc nothrow;

    fz_link_dest fz_make_link_dest_xyz(int, int, float, float, float) @nogc nothrow;
    /**

	Create a new link record.



	next is set to NULL with the expectation that the caller will

	handle the linked list setup. Internal function.



	Different document types will be implemented by deriving from

	fz_link. This macro allocates such derived structures, and

	initialises the base sections.

*/
    fz_link* fz_new_link_of_size(fz_context*, int, fz_rect, const(char)*) @nogc nothrow;
    /**

	Increment the reference count for a link. The same pointer is

	returned.



	Never throws exceptions.

*/
    fz_link* fz_keep_link(fz_context*, fz_link*) @nogc nothrow;
    /**

	Decrement the reference count for a link. When the reference

	count reaches zero, the link is destroyed.



	When a link is freed, the reference for any linked link (next)

	is dropped too, thus an entire linked list of fz_link's can be

	freed by just dropping the head.

*/
    void fz_drop_link(fz_context*, fz_link*) @nogc nothrow;
    /**

	Query whether a link is external to a document (determined by

	uri containing a ':', intended to match with '://' which

	separates the scheme from the scheme specific parts in URIs).

*/
    int fz_is_external_link(fz_context*, const(char)*) @nogc nothrow;

    void fz_set_link_rect(fz_context*, fz_link*, fz_rect) @nogc nothrow;

    void fz_set_link_uri(fz_context*, fz_link*, const(char)*) @nogc nothrow;
    /**

	Output a line to the log.

*/
    void fz_log(fz_context*, const(char)*, ...) @nogc nothrow;
    /**

	Output a line to the log for a given module.

*/
    void fz_log_module(fz_context*, const(char)*, const(char)*, ...) @nogc nothrow;
    /**

	Internal function to actually do the opening of the logfile.



	Caller should close/drop the output when finished with it.

*/
    fz_output* fz_new_log_for_module(fz_context*, const(char)*) @nogc nothrow;

    struct fz_outline_item
    {

        char* title;

        char* uri;

        int is_open;
    }

    struct fz_outline_iterator
    {

        void function(fz_context*, fz_outline_iterator*) drop;

        fz_outline_item* function(fz_context*, fz_outline_iterator*) item;

        int function(fz_context*, fz_outline_iterator*) next;

        int function(fz_context*, fz_outline_iterator*) prev;

        int function(fz_context*, fz_outline_iterator*) up;

        int function(fz_context*, fz_outline_iterator*) down;

        int function(fz_context*, fz_outline_iterator*, fz_outline_item*) insert;

        void function(fz_context*, fz_outline_iterator*, fz_outline_item*) update;

        int function(fz_context*, fz_outline_iterator*) del;

        fz_document* doc;
    }
    /**

	Call to get the current outline item.



	Can return NULL. The item is only valid until the next call.

*/
    fz_outline_item* fz_outline_iterator_item(fz_context*, fz_outline_iterator*) @nogc nothrow;
    /**

	Calls to move the iterator position.



	A negative return value means we could not move as requested. Otherwise:

	0 = the final position has a valid item.

	1 = not a valid item, but we can insert an item here.

*/
    int fz_outline_iterator_next(fz_context*, fz_outline_iterator*) @nogc nothrow;

    int fz_outline_iterator_prev(fz_context*, fz_outline_iterator*) @nogc nothrow;

    int fz_outline_iterator_up(fz_context*, fz_outline_iterator*) @nogc nothrow;

    int fz_outline_iterator_down(fz_context*, fz_outline_iterator*) @nogc nothrow;
    /**

	Call to insert a new item BEFORE the current point.



	Ownership of pointers are retained by the caller. The item data will be copied.



	After an insert, we do not change where we are pointing.

	The return code is the same as for next, it indicates the current iterator position.

*/
    int fz_outline_iterator_insert(fz_context*, fz_outline_iterator*, fz_outline_item*) @nogc nothrow;
    /**

	Delete the current item.



	This implicitly moves us to the 'next' item, and the return code is as for fz_outline_iterator_next.

*/
    int fz_outline_iterator_delete(fz_context*, fz_outline_iterator*) @nogc nothrow;
    /**

	Update the current item properties according to the given item.

*/
    void fz_outline_iterator_update(fz_context*, fz_outline_iterator*, fz_outline_item*) @nogc nothrow;
    /**

	Drop the current iterator.

*/
    void fz_drop_outline_iterator(fz_context*, fz_outline_iterator*) @nogc nothrow;
    /**

	fz_outline is a tree of the outline of a document (also known

	as table of contents).



	title: Title of outline item using UTF-8 encoding. May be NULL

	if the outline item has no text string.



	uri: Destination in the document to be displayed when this

	outline item is activated. May be an internal or external

	link, or NULL if the outline item does not have a destination.



	page: The page number of an internal link, or -1 for external

	links or links with no destination.



	next: The next outline item at the same level as this outline

	item. May be NULL if no more outline items exist at this level.



	down: The outline items immediate children in the hierarchy.

	May be NULL if no children exist.

*/
    struct fz_outline
    {

        int refs;

        char* title;

        char* uri;

        fz_location page;

        float x;

        float y;

        fz_outline* next;

        fz_outline* down;

        int is_open;
    }
    /**

	Create a new outline entry with zeroed fields for the caller

	to fill in.

*/
    fz_outline* fz_new_outline(fz_context*) @nogc nothrow;
    /**

	Increment the reference count. Returns the same pointer.



	Never throws exceptions.

*/
    fz_outline* fz_keep_outline(fz_context*, fz_outline*) @nogc nothrow;
    /**

	Decrements the reference count. When the reference point

	reaches zero, the outline is freed.



	When freed, it will drop linked	outline entries (next and down)

	too, thus a whole outline structure can be dropped by dropping

	the top entry.



	Never throws exceptions.

*/
    void fz_drop_outline(fz_context*, fz_outline*) @nogc nothrow;
    /**

	Routine to implement the old Structure based API from an iterator.

*/
    fz_outline* fz_load_outline_from_iterator(fz_context*, fz_outline_iterator*) @nogc nothrow;
    alias fz_outline_iterator_item_fn = fz_outline_item* function(fz_context*, fz_outline_iterator*);
    alias fz_outline_iterator_next_fn = int function(fz_context*, fz_outline_iterator*);
    alias fz_outline_iterator_prev_fn = int function(fz_context*, fz_outline_iterator*);
    alias fz_outline_iterator_up_fn = int function(fz_context*, fz_outline_iterator*);
    alias fz_outline_iterator_down_fn = int function(fz_context*, fz_outline_iterator*);
    alias fz_outline_iterator_insert_fn = int function(fz_context*, fz_outline_iterator*, fz_outline_item*);
    alias fz_outline_iterator_delete_fn = int function(fz_context*, fz_outline_iterator*);
    alias fz_outline_iterator_update_fn = void function(fz_context*, fz_outline_iterator*, fz_outline_item*);
    alias fz_outline_iterator_drop_fn = void function(fz_context*, fz_outline_iterator*);

    fz_outline_iterator* fz_new_outline_iterator_of_size(fz_context*, ulong, fz_document*) @nogc nothrow;

    fz_outline_iterator* fz_outline_iterator_from_outline(fz_context*, fz_outline*) @nogc nothrow;

    enum _Anonymous_62
    {

        FZ_SVG_TEXT_AS_PATH = 0,

        FZ_SVG_TEXT_AS_TEXT = 1,
    }
    enum FZ_SVG_TEXT_AS_PATH = _Anonymous_62.FZ_SVG_TEXT_AS_PATH;
    enum FZ_SVG_TEXT_AS_TEXT = _Anonymous_62.FZ_SVG_TEXT_AS_TEXT;
    /**

	Create a device that outputs (single page) SVG files to

	the given output stream.



	Equivalent to fz_new_svg_device_with_id passing id = NULL.

*/
    fz_device* fz_new_svg_device(fz_context*, fz_output*, float, float, int, int) @nogc nothrow;
    /**

	Create a device that outputs (single page) SVG files to

	the given output stream.



	output: The output stream to send the constructed SVG page to.



	page_width, page_height: The page dimensions to use (in points).



	text_format: How to emit text. One of the following values:

		FZ_SVG_TEXT_AS_TEXT: As <text> elements with possible

		layout errors and mismatching fonts.

		FZ_SVG_TEXT_AS_PATH: As <path> elements with exact

		visual appearance.



	reuse_images: Share image resources using <symbol> definitions.



	id: ID parameter to keep generated IDs unique across SVG files.

*/
    fz_device* fz_new_svg_device_with_id(fz_context*, fz_output*, float, float, int, int, int*) @nogc nothrow;
    alias fz_output_write_fn = void function(fz_context*, void*, const(void)*, ulong);
    alias fz_output_seek_fn = void function(fz_context*, void*, long, int);
    alias fz_output_tell_fn = long function(fz_context*, void*);
    alias fz_output_close_fn = void function(fz_context*, void*);
    alias fz_output_drop_fn = void function(fz_context*, void*);
    alias fz_stream_from_output_fn = fz_stream* function(fz_context*, void*);
    alias fz_truncate_fn = void function(fz_context*, void*);
    /**

	Create a new output object with the given

	internal state and function pointers.



	state: Internal state (opaque to everything but implementation).



	write: Function to output a given buffer.



	close: Cleanup function to destroy state when output closed.

	May permissibly be null.

*/
    fz_output* fz_new_output(fz_context*, int, void*, void function(fz_context*, void*, const(void)*, ulong), void function(fz_context*, void*), void function(fz_context*, void*)) @nogc nothrow;
    /**

	Open an output stream that writes to a

	given path.



	filename: The filename to write to (specified in UTF-8).



	append: non-zero if we should append to the file, rather than

	overwriting it.

*/
    fz_output* fz_new_output_with_path(fz_context*, const(char)*, int) @nogc nothrow;
    /**

	Open an output stream that appends

	to a buffer.



	buf: The buffer to append to.

*/
    fz_output* fz_new_output_with_buffer(fz_context*, fz_buffer*) @nogc nothrow;
    /**

	Retrieve an fz_output that directs to stdout.



	Optionally may be fz_dropped when finished with.

*/
    fz_output* fz_stdout(fz_context*) @nogc nothrow;
    /**

	Retrieve an fz_output that directs to stdout.



	Optionally may be fz_dropped when finished with.

*/
    fz_output* fz_stderr(fz_context*) @nogc nothrow;
    /**

	Retrieve an fz_output that directs to OutputDebugString.



	Optionally may be fz_dropped when finished with.

*/
    fz_output* fz_stdods(fz_context*) @nogc nothrow;
    /**

	Set the output stream to be used for fz_stddbg. Set to NULL to

	reset to default (stderr).

*/
    void fz_set_stddbg(fz_context*, fz_output*) @nogc nothrow;
    /**

	Retrieve an fz_output for the default debugging stream. On

	Windows this will be OutputDebugString for non-console apps.

	Otherwise, it is always fz_stderr.



	Optionally may be fz_dropped when finished with.

*/
    fz_output* fz_stddbg(fz_context*) @nogc nothrow;
    /**

	Format and write data to an output stream.

	See fz_format_string for formatting details.

*/
    void fz_write_printf(fz_context*, fz_output*, const(char)*, ...) @nogc nothrow;
    /**

	va_list version of fz_write_printf.

*/
    void fz_write_vprintf(fz_context*, fz_output*, const(char)*, char*) @nogc nothrow;
    /**

	Seek to the specified file position.

	See fseek for arguments.



	Throw an error on unseekable outputs.

*/
    void fz_seek_output(fz_context*, fz_output*, long, int) @nogc nothrow;
    /**

	Return the current file position.



	Throw an error on untellable outputs.

*/
    long fz_tell_output(fz_context*, fz_output*) @nogc nothrow;
    /**

	Flush unwritten data.

*/
    void fz_flush_output(fz_context*, fz_output*) @nogc nothrow;
    /**

	Flush pending output and close an output stream.

*/
    void fz_close_output(fz_context*, fz_output*) @nogc nothrow;
    /**

	Free an output stream. Don't forget to close it first!

*/
    void fz_drop_output(fz_context*, fz_output*) @nogc nothrow;
    /**

	Query whether a given fz_output supports fz_stream_from_output.

*/
    int fz_output_supports_stream(fz_context*, fz_output*) @nogc nothrow;
    /**

	Obtain the fz_output in the form of a fz_stream.



	This allows data to be read back from some forms of fz_output

	object. When finished reading, the fz_stream should be released

	by calling fz_drop_stream. Until the fz_stream is dropped, no

	further operations should be performed on the fz_output object.

*/
    fz_stream* fz_stream_from_output(fz_context*, fz_output*) @nogc nothrow;
    /**

	Truncate the output at the current position.



	This allows output streams which have seeked back from the end

	of their storage to be truncated at the current point.

*/
    void fz_truncate_output(fz_context*, fz_output*) @nogc nothrow;
    /**

	Write data to output.



	data: Pointer to data to write.

	size: Size of data to write in bytes.

*/
    void fz_write_data(fz_context*, fz_output*, const(void)*, ulong) @nogc nothrow;

    void fz_write_buffer(fz_context*, fz_output*, fz_buffer*) @nogc nothrow;
    /**

	Write a string. Does not write zero terminator.

*/
    void fz_write_string(fz_context*, fz_output*, const(char)*) @nogc nothrow;
    /**

	Write different sized data to an output stream.

*/
    void fz_write_int32_be(fz_context*, fz_output*, int) @nogc nothrow;

    void fz_write_int32_le(fz_context*, fz_output*, int) @nogc nothrow;

    void fz_write_uint32_be(fz_context*, fz_output*, uint) @nogc nothrow;

    void fz_write_uint32_le(fz_context*, fz_output*, uint) @nogc nothrow;

    void fz_write_int16_be(fz_context*, fz_output*, int) @nogc nothrow;

    void fz_write_int16_le(fz_context*, fz_output*, int) @nogc nothrow;

    void fz_write_uint16_be(fz_context*, fz_output*, uint) @nogc nothrow;

    void fz_write_uint16_le(fz_context*, fz_output*, uint) @nogc nothrow;

    void fz_write_char(fz_context*, fz_output*, char) @nogc nothrow;

    void fz_write_byte(fz_context*, fz_output*, ubyte) @nogc nothrow;

    void fz_write_float_be(fz_context*, fz_output*, float) @nogc nothrow;

    void fz_write_float_le(fz_context*, fz_output*, float) @nogc nothrow;
    /**

	Write a UTF-8 encoded unicode character.

*/
    void fz_write_rune(fz_context*, fz_output*, int) @nogc nothrow;
    /**

	Write a base64 encoded data block, optionally with periodic

	newlines.

*/
    void fz_write_base64(fz_context*, fz_output*, const(ubyte)*, ulong, int) @nogc nothrow;
    /**

	Write a base64 encoded fz_buffer, optionally with periodic

	newlines.

*/
    void fz_write_base64_buffer(fz_context*, fz_output*, fz_buffer*, int) @nogc nothrow;
    /**

	Write num_bits of data to the end of the output stream, assumed to be packed

	most significant bits first.

*/
    void fz_write_bits(fz_context*, fz_output*, uint, int) @nogc nothrow;
    /**

	Sync to byte boundary after writing bits.

*/
    void fz_write_bits_sync(fz_context*, fz_output*) @nogc nothrow;
    /**

	Our customised 'printf'-like string formatter.

	Takes %c, %d, %s, %u, %x, as usual.

	Modifiers are not supported except for zero-padding ints (e.g.

	%02d, %03u, %04x, etc).

	%g output in "as short as possible hopefully lossless

	non-exponent" form, see fz_ftoa for specifics.

	%f and %e output as usual.

	%C outputs a utf8 encoded int.

	%M outputs a fz_matrix*.

	%R outputs a fz_rect*.

	%P outputs a fz_point*.

	%n outputs a PDF name (with appropriate escaping).

	%q and %( output escaped strings in C/PDF syntax.

	%l{d,u,x} indicates that the values are int64_t.

	%z{d,u,x} indicates that the value is a size_t.



	user: An opaque pointer that is passed to the emit function.



	emit: A function pointer called to emit output bytes as the

	string is being formatted.

*/
    void fz_format_string(fz_context*, void*, void function(fz_context*, void*, int), const(char)*, char*) @nogc nothrow;
    /**

	A vsnprintf work-alike, using our custom formatter.

*/
    ulong fz_vsnprintf(char*, ulong, const(char)*, char*) @nogc nothrow;
    /**

	The non va_list equivalent of fz_vsnprintf.

*/
    ulong fz_snprintf(char*, ulong, const(char)*, ...) @nogc nothrow;
    /**

	Allocated sprintf.



	Returns a null terminated allocated block containing the

	formatted version of the format string/args.

*/
    char* fz_asprintf(fz_context*, const(char)*, ...) @nogc nothrow;
    /**

	Save the contents of a buffer to a file.

*/
    void fz_save_buffer(fz_context*, fz_buffer*, const(char)*) @nogc nothrow;
    /**

	Compression and other filtering outputs.



	These outputs write encoded data to another output. Create a

	filter output with the destination, write to the filter, then

	close and drop it when you're done. These can also be chained

	together, for example to write ASCII Hex encoded, Deflate

	compressed, and RC4 encrypted data to a buffer output.



	Output streams don't use reference counting, so make sure to

	close all of the filters in the reverse order of creation so

	that data is flushed properly.



	Accordingly, ownership of 'chain' is never passed into the

	following functions, but remains with the caller, whose

	responsibility it is to ensure they exist at least until

	the returned fz_output is dropped.

*/
    fz_output* fz_new_asciihex_output(fz_context*, fz_output*) @nogc nothrow;

    fz_output* fz_new_ascii85_output(fz_context*, fz_output*) @nogc nothrow;

    fz_output* fz_new_rle_output(fz_context*, fz_output*) @nogc nothrow;

    fz_output* fz_new_arc4_output(fz_context*, fz_output*, ubyte*, ulong) @nogc nothrow;

    fz_output* fz_new_deflate_output(fz_context*, fz_output*, int, int) @nogc nothrow;
    struct fz_path;

    alias fz_linecap = _Anonymous_63;

    enum _Anonymous_63
    {

        FZ_LINECAP_BUTT = 0,

        FZ_LINECAP_ROUND = 1,

        FZ_LINECAP_SQUARE = 2,

        FZ_LINECAP_TRIANGLE = 3,
    }
    enum FZ_LINECAP_BUTT = _Anonymous_63.FZ_LINECAP_BUTT;
    enum FZ_LINECAP_ROUND = _Anonymous_63.FZ_LINECAP_ROUND;
    enum FZ_LINECAP_SQUARE = _Anonymous_63.FZ_LINECAP_SQUARE;
    enum FZ_LINECAP_TRIANGLE = _Anonymous_63.FZ_LINECAP_TRIANGLE;

    alias fz_linejoin = _Anonymous_64;

    enum _Anonymous_64
    {

        FZ_LINEJOIN_MITER = 0,

        FZ_LINEJOIN_ROUND = 1,

        FZ_LINEJOIN_BEVEL = 2,

        FZ_LINEJOIN_MITER_XPS = 3,
    }
    enum FZ_LINEJOIN_MITER = _Anonymous_64.FZ_LINEJOIN_MITER;
    enum FZ_LINEJOIN_ROUND = _Anonymous_64.FZ_LINEJOIN_ROUND;
    enum FZ_LINEJOIN_BEVEL = _Anonymous_64.FZ_LINEJOIN_BEVEL;
    enum FZ_LINEJOIN_MITER_XPS = _Anonymous_64.FZ_LINEJOIN_MITER_XPS;

    struct fz_stroke_state
    {

        int refs;

        fz_linecap start_cap;

        fz_linecap dash_cap;

        fz_linecap end_cap;

        fz_linejoin linejoin;

        float linewidth;

        float miterlimit;

        float dash_phase;

        int dash_len;

        float[32] dash_list;
    }

    struct fz_path_walker
    {

        void function(fz_context*, void*, float, float) moveto;

        void function(fz_context*, void*, float, float) lineto;

        void function(fz_context*, void*, float, float, float, float, float, float) curveto;

        void function(fz_context*, void*) closepath;

        void function(fz_context*, void*, float, float, float, float) quadto;

        void function(fz_context*, void*, float, float, float, float) curvetov;

        void function(fz_context*, void*, float, float, float, float) curvetoy;

        void function(fz_context*, void*, float, float, float, float) rectto;
    }
    /**

	Walk the segments of a path, calling the

	appropriate callback function from a given set for each

	segment of the path.



	path: The path to walk.



	walker: The set of callback functions to use. The first

	4 callback pointers in the set must be non-NULL. The

	subsequent ones can either be supplied, or can be left

	as NULL, in which case the top 4 functions will be

	called as appropriate to simulate them.



	arg: An opaque argument passed in to each callback.



	Exceptions will only be thrown if the underlying callback

	functions throw them.

*/
    void fz_walk_path(fz_context*, const(fz_path)*, const(fz_path_walker)*, void*) @nogc nothrow;
    /**

	Create a new (empty) path structure.

*/
    fz_path* fz_new_path(fz_context*) @nogc nothrow;
    /**

	Increment the reference count. Returns the same pointer.



	All paths can be kept, regardless of their packing type.



	Never throws exceptions.

*/
    fz_path* fz_keep_path(fz_context*, const(fz_path)*) @nogc nothrow;
    /**

	Decrement the reference count. When the reference count hits

	zero, free the path.



	All paths can be dropped, regardless of their packing type.

	Packed paths do not own the blocks into which they are packed

	so dropping them does not free those blocks.



	Never throws exceptions.

*/
    void fz_drop_path(fz_context*, const(fz_path)*) @nogc nothrow;
    /**

	Minimise the internal storage used by a path.



	As paths are constructed, the internal buffers

	grow. To avoid repeated reallocations they

	grow with some spare space. Once a path has

	been fully constructed, this call allows the

	excess space to be trimmed.

*/
    void fz_trim_path(fz_context*, fz_path*) @nogc nothrow;
    /**

	Return the number of bytes required to pack a path.

*/
    int fz_packed_path_size(const(fz_path)*) @nogc nothrow;
    /**

	Pack a path into the given block.

	To minimise the size of paths, this function allows them to be

	packed into a buffer with other information. Paths can be used

	interchangeably regardless of how they are packed.



	pack: Pointer to a block of data to pack the path into. Should

	be aligned by the caller to the same alignment as required for

	a fz_path pointer.



	max: The number of bytes available in the block.

	If max < sizeof(fz_path) then an exception will

	be thrown. If max >= the value returned by

	fz_packed_path_size, then this call will never

	fail, except in low memory situations with large

	paths.



	path: The path to pack.



	Returns the number of bytes within the block used. Callers can

	access the packed path data by casting the value of pack on

	entry to be a fz_path *.



	Throws exceptions on failure to allocate, or if

	max < sizeof(fz_path).



	Implementation details: Paths can be 'unpacked', 'flat', or

	'open'. Standard paths, as created are 'unpacked'. Paths that

	will pack into less than max bytes will be packed as 'flat',

	unless they are too large (where large indicates that they

	exceed some private implementation defined limits, currently

	including having more than 256 coordinates or commands).



	Large paths are 'open' packed as a header into the given block,

	plus pointers to other data blocks.



	Users should not have to care about whether paths are 'open'

	or 'flat' packed. Simply pack a path (if required), and then

	forget about the details.

*/
    ulong fz_pack_path(fz_context*, ubyte*, ulong, const(fz_path)*) @nogc nothrow;
    /**

	Clone the data for a path.



	This is used in preference to fz_keep_path when a whole

	new copy of a path is required, rather than just a shared

	pointer. This probably indicates that the path is about to

	be modified.



	path: path to clone.



	Throws exceptions on failure to allocate.

*/
    fz_path* fz_clone_path(fz_context*, fz_path*) @nogc nothrow;
    /**

	Return the current point that a path has

	reached or (0,0) if empty.



	path: path to return the current point of.

*/
    fz_point fz_currentpoint(fz_context*, fz_path*) @nogc nothrow;
    /**

	Append a 'moveto' command to a path.

	This 'opens' a path.



	path: The path to modify.



	x, y: The coordinate to move to.



	Throws exceptions on failure to allocate, or attempting to

	modify a packed path.

*/
    void fz_moveto(fz_context*, fz_path*, float, float) @nogc nothrow;
    /**

	Append a 'lineto' command to an open path.



	path: The path to modify.



	x, y: The coordinate to line to.



	Throws exceptions on failure to allocate, or attempting to

	modify a packed path.

*/
    void fz_lineto(fz_context*, fz_path*, float, float) @nogc nothrow;
    /**

	Append a 'rectto' command to an open path.



	The rectangle is equivalent to:

		moveto x0 y0

		lineto x1 y0

		lineto x1 y1

		lineto x0 y1

		closepath



	path: The path to modify.



	x0, y0: First corner of the rectangle.



	x1, y1: Second corner of the rectangle.



	Throws exceptions on failure to allocate, or attempting to

	modify a packed path.

*/
    void fz_rectto(fz_context*, fz_path*, float, float, float, float) @nogc nothrow;
    /**

	Append a 'quadto' command to an open path. (For a

	quadratic bezier).



	path: The path to modify.



	x0, y0: The control coordinates for the quadratic curve.



	x1, y1: The end coordinates for the quadratic curve.



	Throws exceptions on failure to allocate, or attempting to

	modify a packed path.

*/
    void fz_quadto(fz_context*, fz_path*, float, float, float, float) @nogc nothrow;
    /**

	Append a 'curveto' command to an open path. (For a

	cubic bezier).



	path: The path to modify.



	x0, y0: The coordinates of the first control point for the

	curve.



	x1, y1: The coordinates of the second control point for the

	curve.



	x2, y2: The end coordinates for the curve.



	Throws exceptions on failure to allocate, or attempting to

	modify a packed path.

*/
    void fz_curveto(fz_context*, fz_path*, float, float, float, float, float, float) @nogc nothrow;
    /**

	Append a 'curvetov' command to an open path. (For a

	cubic bezier with the first control coordinate equal to

	the start point).



	path: The path to modify.



	x1, y1: The coordinates of the second control point for the

	curve.



	x2, y2: The end coordinates for the curve.



	Throws exceptions on failure to allocate, or attempting to

	modify a packed path.

*/
    void fz_curvetov(fz_context*, fz_path*, float, float, float, float) @nogc nothrow;
    /**

	Append a 'curvetoy' command to an open path. (For a

	cubic bezier with the second control coordinate equal to

	the end point).



	path: The path to modify.



	x0, y0: The coordinates of the first control point for the

	curve.



	x2, y2: The end coordinates for the curve (and the second

	control coordinate).



	Throws exceptions on failure to allocate, or attempting to

	modify a packed path.

*/
    void fz_curvetoy(fz_context*, fz_path*, float, float, float, float) @nogc nothrow;
    /**

	Close the current subpath.



	path: The path to modify.



	Throws exceptions on failure to allocate, attempting to modify

	a packed path, and illegal path closes (i.e. closing a non open

	path).

*/
    void fz_closepath(fz_context*, fz_path*) @nogc nothrow;
    /**

	Transform a path by a given

	matrix.



	path: The path to modify (must not be a packed path).



	transform: The transform to apply.



	Throws exceptions if the path is packed, or on failure

	to allocate.

*/
    void fz_transform_path(fz_context*, fz_path*, fz_matrix) @nogc nothrow;
    /**

	Return a bounding rectangle for a path.



	path: The path to bound.



	stroke: If NULL, the bounding rectangle given is for

	the filled path. If non-NULL the bounding rectangle

	given is for the path stroked with the given attributes.



	ctm: The matrix to apply to the path during stroking.



	r: Pointer to a fz_rect which will be used to hold

	the result.



	Returns r, updated to contain the bounding rectangle.

*/
    fz_rect fz_bound_path(fz_context*, const(fz_path)*, const(fz_stroke_state)*, fz_matrix) @nogc nothrow;
    /**

	Given a rectangle (assumed to be the bounding box for a path),

	expand it to allow for the expansion of the bbox that would be

	seen by stroking the path with the given stroke state and

	transform.

*/
    fz_rect fz_adjust_rect_for_stroke(fz_context*, fz_rect, const(fz_stroke_state)*, fz_matrix) @nogc nothrow;
    /**

	A sane 'default' stroke state.

*/
    extern __gshared const(fz_stroke_state) fz_default_stroke_state;
    /**

	Create a new (empty) stroke state structure (with no dash

	data) and return a reference to it.



	Throws exception on failure to allocate.

*/
    fz_stroke_state* fz_new_stroke_state(fz_context*) @nogc nothrow;
    /**

	Create a new (empty) stroke state structure, with room for

	dash data of the given length, and return a reference to it.



	len: The number of dash elements to allow room for.



	Throws exception on failure to allocate.

*/
    fz_stroke_state* fz_new_stroke_state_with_dash_len(fz_context*, int) @nogc nothrow;
    /**

	Take an additional reference to a stroke state structure.



	No modifications should be carried out on a stroke

	state to which more than one reference is held, as

	this can cause race conditions.

*/
    fz_stroke_state* fz_keep_stroke_state(fz_context*, const(fz_stroke_state)*) @nogc nothrow;
    /**

	Drop a reference to a stroke state structure, destroying the

	structure if it is the last reference.

*/
    void fz_drop_stroke_state(fz_context*, const(fz_stroke_state)*) @nogc nothrow;
    /**

	Given a reference to a (possibly) shared stroke_state structure,

	return a reference to an equivalent stroke_state structure

	that is guaranteed to be unshared (i.e. one that can

	safely be modified).



	shared: The reference to a (possibly) shared structure

	to unshare. Ownership of this reference is passed in

	to this function, even in the case of exceptions being

	thrown.



	Exceptions may be thrown in the event of failure to

	allocate if required.

*/
    fz_stroke_state* fz_unshare_stroke_state(fz_context*, fz_stroke_state*) @nogc nothrow;
    /**

	Given a reference to a (possibly) shared stroke_state structure,

	return a reference to a stroke_state structure (with room for a

	given amount of dash data) that is guaranteed to be unshared

	(i.e. one that can safely be modified).



	shared: The reference to a (possibly) shared structure

	to unshare. Ownership of this reference is passed in

	to this function, even in the case of exceptions being

	thrown.



	Exceptions may be thrown in the event of failure to

	allocate if required.

*/
    fz_stroke_state* fz_unshare_stroke_state_with_dash_len(fz_context*, fz_stroke_state*, int) @nogc nothrow;
    /**

	Create an identical stroke_state structure and return a

	reference to it.



	stroke: The stroke state reference to clone.



	Exceptions may be thrown in the event of a failure to

	allocate.

*/
    fz_stroke_state* fz_clone_stroke_state(fz_context*, fz_stroke_state*) @nogc nothrow;
    struct fz_overprint;
    /**

	Return the bounding box for a pixmap.

*/
    fz_irect fz_pixmap_bbox(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Return the width of the pixmap in pixels.

*/
    int fz_pixmap_width(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Return the height of the pixmap in pixels.

*/
    int fz_pixmap_height(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Return the x value of the pixmap in pixels.

*/
    int fz_pixmap_x(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Return the y value of the pixmap in pixels.

*/
    int fz_pixmap_y(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Create a new pixmap, with its origin at (0,0)



	cs: The colorspace to use for the pixmap, or NULL for an alpha

	plane/mask.



	w: The width of the pixmap (in pixels)



	h: The height of the pixmap (in pixels)



	seps: Details of separations.



	alpha: 0 for no alpha, 1 for alpha.



	Returns a pointer to the new pixmap. Throws exception on failure

	to allocate.

*/
    fz_pixmap* fz_new_pixmap(fz_context*, fz_colorspace*, int, int, fz_separations*, int) @nogc nothrow;
    /**

	Create a pixmap of a given size, location and pixel format.



	The bounding box specifies the size of the created pixmap and

	where it will be located. The colorspace determines the number

	of components per pixel. Alpha is always present. Pixmaps are

	reference counted, so drop references using fz_drop_pixmap.



	colorspace: Colorspace format used for the created pixmap. The

	pixmap will keep a reference to the colorspace.



	bbox: Bounding box specifying location/size of created pixmap.



	seps: Details of separations.



	alpha: 0 for no alpha, 1 for alpha.



	Returns a pointer to the new pixmap. Throws exception on failure

	to allocate.

*/
    fz_pixmap* fz_new_pixmap_with_bbox(fz_context*, fz_colorspace*, fz_irect, fz_separations*, int) @nogc nothrow;
    /**

	Create a new pixmap, with its origin at

	(0,0) using the supplied data block.



	cs: The colorspace to use for the pixmap, or NULL for an alpha

	plane/mask.



	w: The width of the pixmap (in pixels)



	h: The height of the pixmap (in pixels)



	seps: Details of separations.



	alpha: 0 for no alpha, 1 for alpha.



	stride: The byte offset from the pixel data in a row to the

	pixel data in the next row.



	samples: The data block to keep the samples in.



	Returns a pointer to the new pixmap. Throws exception on failure to

	allocate.

*/
    fz_pixmap* fz_new_pixmap_with_data(fz_context*, fz_colorspace*, int, int, fz_separations*, int, int, ubyte*) @nogc nothrow;
    /**

	Create a pixmap of a given size, location and pixel format,

	using the supplied data block.



	The bounding box specifies the size of the created pixmap and

	where it will be located. The colorspace determines the number

	of components per pixel. Alpha is always present. Pixmaps are

	reference counted, so drop references using fz_drop_pixmap.



	colorspace: Colorspace format used for the created pixmap. The

	pixmap will keep a reference to the colorspace.



	rect: Bounding box specifying location/size of created pixmap.



	seps: Details of separations.



	alpha: Number of alpha planes (0 or 1).



	samples: The data block to keep the samples in.



	Returns a pointer to the new pixmap. Throws exception on failure

	to allocate.

*/
    fz_pixmap* fz_new_pixmap_with_bbox_and_data(fz_context*, fz_colorspace*, fz_irect, fz_separations*, int, ubyte*) @nogc nothrow;
    /**

	Create a new pixmap that represents a subarea of the specified

	pixmap. A reference is taken to this pixmap that will be dropped

	on destruction.



	The supplied rectangle must be wholly contained within the

	original pixmap.



	Returns a pointer to the new pixmap. Throws exception on failure

	to allocate.

*/
    fz_pixmap* fz_new_pixmap_from_pixmap(fz_context*, fz_pixmap*, const(fz_irect)*) @nogc nothrow;
    /**

	Clone a pixmap, copying the pixels and associated data to new

	storage.



	The reference count of 'old' is unchanged.

*/
    fz_pixmap* fz_clone_pixmap(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Increment the reference count for the pixmap. The same pointer

	is returned.



	Never throws exceptions.

*/
    fz_pixmap* fz_keep_pixmap(fz_context*, fz_pixmap*) @nogc nothrow;
    /**

	Decrement the reference count for the pixmap. When the

	reference count hits 0, the pixmap is freed.



	Never throws exceptions.

*/
    void fz_drop_pixmap(fz_context*, fz_pixmap*) @nogc nothrow;
    /**

	Return the colorspace of a pixmap



	Returns colorspace.

*/
    fz_colorspace* fz_pixmap_colorspace(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Return the number of components in a pixmap.



	Returns the number of components (including spots and alpha).

*/
    int fz_pixmap_components(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Return the number of colorants in a pixmap.



	Returns the number of colorants (components, less any spots and

	alpha).

*/
    int fz_pixmap_colorants(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Return the number of spots in a pixmap.



	Returns the number of spots (components, less colorants and

	alpha). Does not throw exceptions.

*/
    int fz_pixmap_spots(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Return the number of alpha planes in a pixmap.



	Returns the number of alphas. Does not throw exceptions.

*/
    int fz_pixmap_alpha(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Returns a pointer to the pixel data of a pixmap.



	Returns the pointer.

*/
    ubyte* fz_pixmap_samples(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Return the number of bytes in a row in the pixmap.

*/
    int fz_pixmap_stride(fz_context*, const(fz_pixmap)*) @nogc nothrow;
    /**

	Set the pixels per inch resolution of the pixmap.

*/
    void fz_set_pixmap_resolution(fz_context*, fz_pixmap*, int, int) @nogc nothrow;
    /**

	Clears a pixmap with the given value.



	pix: The pixmap to clear.



	value: Values in the range 0 to 255 are valid. Each component

	sample for each pixel in the pixmap will be set to this value,

	while alpha will always be set to 255 (non-transparent).



	This function is horrible, and should be removed from the

	API and replaced with a less magic one.

*/
    void fz_clear_pixmap_with_value(fz_context*, fz_pixmap*, int) @nogc nothrow;
    /**

	Fill pixmap with solid color.

*/
    void fz_fill_pixmap_with_color(fz_context*, fz_pixmap*, fz_colorspace*, float*, fz_color_params) @nogc nothrow;
    /**

	Clears a subrect of a pixmap with the given value.



	pix: The pixmap to clear.



	value: Values in the range 0 to 255 are valid. Each component

	sample for each pixel in the pixmap will be set to this value,

	while alpha will always be set to 255 (non-transparent).



	r: the rectangle.

*/
    void fz_clear_pixmap_rect_with_value(fz_context*, fz_pixmap*, int, fz_irect) @nogc nothrow;
    /**

	Sets all components (including alpha) of

	all pixels in a pixmap to 0.



	pix: The pixmap to clear.

*/
    void fz_clear_pixmap(fz_context*, fz_pixmap*) @nogc nothrow;
    /**

	Invert all the pixels in a pixmap. All components (process and

	spots) of all pixels are inverted (except alpha, which is

	unchanged).

*/
    void fz_invert_pixmap(fz_context*, fz_pixmap*) @nogc nothrow;
    /**

	Invert the alpha fo all the pixels in a pixmap.

*/
    void fz_invert_pixmap_alpha(fz_context*, fz_pixmap*) @nogc nothrow;
    /**

	Transform the pixels in a pixmap so that luminance of each

	pixel is inverted, and the chrominance remains unchanged (as

	much as accuracy allows).



	All components of all pixels are inverted (except alpha, which

	is unchanged). Only supports Grey and RGB bitmaps.

*/
    void fz_invert_pixmap_luminance(fz_context*, fz_pixmap*) @nogc nothrow;
    /**

	Tint all the pixels in an RGB, BGR, or Gray pixmap.



	black: Map black to this hexadecimal RGB color.



	white: Map white to this hexadecimal RGB color.

*/
    void fz_tint_pixmap(fz_context*, fz_pixmap*, int, int) @nogc nothrow;
    /**

	Invert all the pixels in a given rectangle of a

	pixmap. All components of all pixels in the rectangle are

	inverted (except alpha, which is unchanged).

*/
    void fz_invert_pixmap_rect(fz_context*, fz_pixmap*, fz_irect) @nogc nothrow;
    /**

	Apply gamma correction to a pixmap. All components

	of all pixels are modified (except alpha, which is unchanged).



	gamma: The gamma value to apply; 1.0 for no change.

*/
    void fz_gamma_pixmap(fz_context*, fz_pixmap*, float) @nogc nothrow;
    /**

	Convert an existing pixmap to a desired

	colorspace. Other properties of the pixmap, such as resolution

	and position are copied to the converted pixmap.



	pix: The pixmap to convert.



	default_cs: If NULL pix->colorspace is used. It is possible that

	the data may need to be interpreted as one of the color spaces

	in default_cs.



	cs_des: Desired colorspace, may be NULL to denote alpha-only.



	prf: Proofing color space through which we need to convert.



	color_params: Parameters that may be used in conversion (e.g.

	ri).



	keep_alpha: If 0 any alpha component is removed, otherwise

	alpha is kept if present in the pixmap.

*/
    fz_pixmap* fz_convert_pixmap(fz_context*, const(fz_pixmap)*, fz_colorspace*, fz_colorspace*, fz_default_colorspaces*, fz_color_params, int) @nogc nothrow;
    /**

	Check if the pixmap is a 1-channel image containing samples with

	only values 0 and 255

*/
    int fz_is_pixmap_monochrome(fz_context*, fz_pixmap*) @nogc nothrow;

    fz_pixmap* fz_alpha_from_gray(fz_context*, fz_pixmap*) @nogc nothrow;

    void fz_decode_tile(fz_context*, fz_pixmap*, const(float)*) @nogc nothrow;

    void fz_md5_pixmap(fz_context*, fz_pixmap*, ubyte*) @nogc nothrow;

    fz_stream* fz_unpack_stream(fz_context*, fz_stream*, int, int, int, int, int, int, int) @nogc nothrow;

    enum _Anonymous_65
    {

        FZ_PIXMAP_FLAG_INTERPOLATE = 1,

        FZ_PIXMAP_FLAG_FREE_SAMPLES = 2,
    }
    enum FZ_PIXMAP_FLAG_INTERPOLATE = _Anonymous_65.FZ_PIXMAP_FLAG_INTERPOLATE;
    enum FZ_PIXMAP_FLAG_FREE_SAMPLES = _Anonymous_65.FZ_PIXMAP_FLAG_FREE_SAMPLES;

    fz_pixmap* fz_warp_pixmap(fz_context*, fz_pixmap*, const(fz_point)*, int, int) @nogc nothrow;

    fz_pixmap* fz_clone_pixmap_area_with_different_seps(fz_context*, fz_pixmap*, const(fz_irect)*, fz_colorspace*, fz_separations*, fz_color_params, fz_default_colorspaces*) @nogc nothrow;

    fz_pixmap* fz_new_pixmap_from_alpha_channel(fz_context*, fz_pixmap*) @nogc nothrow;

    fz_pixmap* fz_new_pixmap_from_color_and_mask(fz_context*, fz_pixmap*, fz_pixmap*) @nogc nothrow;
    struct fz_pool;
    /**

	Create a new pool to allocate from.

*/
    fz_pool* fz_new_pool(fz_context*) @nogc nothrow;
    /**

	Allocate a block of size bytes from the pool.

*/
    void* fz_pool_alloc(fz_context*, fz_pool*, ulong) @nogc nothrow;
    /**

	strdup equivalent allocating from the pool.

*/
    char* fz_pool_strdup(fz_context*, fz_pool*, const(char)*) @nogc nothrow;
    /**

	The current size of the pool.



	The number of bytes of storage currently allocated to the pool.

	This is the total of the storage used for the blocks making

	up the pool, rather then total of the allocated blocks so far,

	so it will increase in 'lumps'.

	from the pool, then the pool size may still be X

*/
    ulong fz_pool_size(fz_context*, fz_pool*) @nogc nothrow;
    /**

	Drop a pool, freeing and invalidating all storage returned from

	the pool.

*/
    void fz_drop_pool(fz_context*, fz_pool*) @nogc nothrow;
    /**

	A fz_separation structure holds details of a set of separations

	(such as might be used on within a page of the document).



	The app might control the separations by enabling/disabling them,

	and subsequent renders would take this into account.

*/
    enum _Anonymous_66
    {

        FZ_MAX_SEPARATIONS = 64,
    }
    enum FZ_MAX_SEPARATIONS = _Anonymous_66.FZ_MAX_SEPARATIONS;
    struct fz_separations;

    alias fz_separation_behavior = _Anonymous_67;

    enum _Anonymous_67
    {

        FZ_SEPARATION_COMPOSITE = 0,

        FZ_SEPARATION_SPOT = 1,

        FZ_SEPARATION_DISABLED = 2,
    }
    enum FZ_SEPARATION_COMPOSITE = _Anonymous_67.FZ_SEPARATION_COMPOSITE;
    enum FZ_SEPARATION_SPOT = _Anonymous_67.FZ_SEPARATION_SPOT;
    enum FZ_SEPARATION_DISABLED = _Anonymous_67.FZ_SEPARATION_DISABLED;
    /**

	Create a new separations structure (initially empty)

*/
    fz_separations* fz_new_separations(fz_context*, int) @nogc nothrow;
    /**

	Increment the reference count for a separations structure.

	Returns the same pointer.



	Never throws exceptions.

*/
    fz_separations* fz_keep_separations(fz_context*, fz_separations*) @nogc nothrow;
    /**

	Decrement the reference count for a separations structure.

	When the reference count hits zero, the separations structure

	is freed.



	Never throws exceptions.

*/
    void fz_drop_separations(fz_context*, fz_separations*) @nogc nothrow;
    /**

	Add a separation (null terminated name, colorspace)

*/
    void fz_add_separation(fz_context*, fz_separations*, const(char)*, fz_colorspace*, int) @nogc nothrow;
    /**

	Add a separation with equivalents (null terminated name,

	colorspace)



	(old, deprecated)

*/
    void fz_add_separation_equivalents(fz_context*, fz_separations*, uint, uint, const(char)*) @nogc nothrow;
    /**

	Control the rendering of a given separation.

*/
    void fz_set_separation_behavior(fz_context*, fz_separations*, int, fz_separation_behavior) @nogc nothrow;
    /**

	Test for the current behavior of a separation.

*/
    fz_separation_behavior fz_separation_current_behavior(fz_context*, const(fz_separations)*, int) @nogc nothrow;

    const(char)* fz_separation_name(fz_context*, const(fz_separations)*, int) @nogc nothrow;

    int fz_count_separations(fz_context*, const(fz_separations)*) @nogc nothrow;
    /**

	Return the number of active separations.

*/
    int fz_count_active_separations(fz_context*, const(fz_separations)*) @nogc nothrow;
    /**

	Return a separations object with all the spots in the input

	separations object that are set to composite, reset to be

	enabled. If there ARE no spots in the object, this returns

	NULL. If the object already has all its spots enabled, then

	just returns another handle on the same object.

*/
    fz_separations* fz_clone_separations_for_overprint(fz_context*, fz_separations*) @nogc nothrow;
    /**

	Convert a color given in terms of one colorspace,

	to a color in terms of another colorspace/separations.

*/
    void fz_convert_separation_colors(fz_context*, fz_colorspace*, const(float)*, fz_separations*, fz_colorspace*, float*, fz_color_params) @nogc nothrow;
    /**

	Get the equivalent separation color in a given colorspace.

*/
    void fz_separation_equivalent(fz_context*, const(fz_separations)*, int, fz_colorspace*, float*, fz_colorspace*, fz_color_params) @nogc nothrow;
    /**

 * The shading code uses gouraud shaded triangle meshes.

 */
    enum _Anonymous_68
    {

        FZ_FUNCTION_BASED = 1,

        FZ_LINEAR = 2,

        FZ_RADIAL = 3,

        FZ_MESH_TYPE4 = 4,

        FZ_MESH_TYPE5 = 5,

        FZ_MESH_TYPE6 = 6,

        FZ_MESH_TYPE7 = 7,
    }
    enum FZ_FUNCTION_BASED = _Anonymous_68.FZ_FUNCTION_BASED;
    enum FZ_LINEAR = _Anonymous_68.FZ_LINEAR;
    enum FZ_RADIAL = _Anonymous_68.FZ_RADIAL;
    enum FZ_MESH_TYPE4 = _Anonymous_68.FZ_MESH_TYPE4;
    enum FZ_MESH_TYPE5 = _Anonymous_68.FZ_MESH_TYPE5;
    enum FZ_MESH_TYPE6 = _Anonymous_68.FZ_MESH_TYPE6;
    enum FZ_MESH_TYPE7 = _Anonymous_68.FZ_MESH_TYPE7;
    /**

	Structure is public to allow derived classes. Do not

	access the members directly.

*/
    struct fz_shade
    {

        fz_storable storable;

        fz_rect bbox;

        fz_colorspace* colorspace;

        fz_matrix matrix;

        int use_background;

        float[32] background;

        int use_function;

        float[33][256] function_;

        int type;

        static union _Anonymous_69
        {

            static struct _Anonymous_70
            {

                int[2] extend;

                float[3][2] coords;
            }

            _Anonymous_70 l_or_r;

            static struct _Anonymous_71
            {

                int vprow;

                int bpflag;

                int bpcoord;

                int bpcomp;

                float x0;

                float x1;

                float y0;

                float y1;

                float[32] c0;

                float[32] c1;
            }

            _Anonymous_71 m;

            static struct _Anonymous_72
            {

                fz_matrix matrix;

                int xdivs;

                int ydivs;

                float[2][2] domain;

                float* fn_vals;
            }

            _Anonymous_72 f;
        }

        _Anonymous_69 u;

        fz_compressed_buffer* buffer;
    }
    /**

	Increment the reference count for the shade structure. The

	same pointer is returned.



	Never throws exceptions.

*/
    fz_shade* fz_keep_shade(fz_context*, fz_shade*) @nogc nothrow;
    /**

	Decrement the reference count for the shade structure. When

	the reference count hits zero, the structure is freed.



	Never throws exceptions.

*/
    void fz_drop_shade(fz_context*, fz_shade*) @nogc nothrow;
    /**

	Bound a given shading.



	shade: The shade to bound.



	ctm: The transform to apply to the shade before bounding.



	r: Pointer to storage to put the bounds in.



	Returns r, updated to contain the bounds for the shading.

*/
    fz_rect fz_bound_shade(fz_context*, fz_shade*, fz_matrix) @nogc nothrow;
    struct fz_shade_color_cache;

    void fz_drop_shade_color_cache(fz_context*, fz_shade_color_cache*) @nogc nothrow;
    /**

	Render a shade to a given pixmap.



	shade: The shade to paint.



	override_cs: NULL, or colorspace to override the shades

	inbuilt colorspace.



	ctm: The transform to apply.



	dest: The pixmap to render into.



	color_params: The color rendering settings



	bbox: Pointer to a bounding box to limit the rendering

	of the shade.



	eop: NULL, or pointer to overprint bitmap.



	cache: *cache is used to cache color information. If *cache is NULL it

	is set to point to a new fz_shade_color_cache. If cache is NULL it is

	ignored.

*/
    void fz_paint_shade(fz_context*, fz_shade*, fz_colorspace*, fz_matrix, fz_pixmap*, fz_color_params, fz_irect, const(fz_overprint)*, fz_shade_color_cache**) @nogc nothrow;
    /**

 *	Handy routine for processing mesh based shades

 */
    struct fz_vertex
    {

        fz_point p;

        float[32] c;
    }
    alias fz_shade_prepare_fn = void function(fz_context*, void*, fz_vertex*, const(float)*);
    alias fz_shade_process_fn = void function(fz_context*, void*, fz_vertex*, fz_vertex*, fz_vertex*);
    /**

	Process a shade, using supplied callback functions. This

	decomposes the shading to a mesh (even ones that are not

	natively meshes, such as linear or radial shadings), and

	processes triangles from those meshes.



	shade: The shade to process.



	ctm: The transform to use



	prepare: Callback function to 'prepare' each vertex.

	This function is passed an array of floats, and populates

	a fz_vertex structure.



	process: This function is passed 3 pointers to vertex

	structures, and actually performs the processing (typically

	filling the area between the vertexes).



	process_arg: An opaque argument passed through from caller

	to callback functions.

*/
    void fz_process_shade(fz_context*, fz_shade*, fz_matrix, fz_rect, void function(fz_context*, void*, fz_vertex*, const(float)*), void function(fz_context*, void*, fz_vertex*, fz_vertex*, fz_vertex*), void*) @nogc nothrow;
    /**

	Internal function to destroy a

	shade. Only exposed for use with the fz_store.



	shade: The reference to destroy.

*/
    void fz_drop_shade_imp(fz_context*, fz_storable*) @nogc nothrow;
    /**

	Any storable object should include an fz_storable structure

	at the start (by convention at least) of their structure.

	(Unless it starts with an fz_key_storable, see below).

*/
    struct fz_storable
    {

        int refs;

        void function(fz_context*, fz_storable*) drop;
    }
    alias fz_store_drop_fn = void function(fz_context*, fz_storable*);
    /**

	Any storable object that can appear in the key of another

	storable object should include an fz_key_storable structure

	at the start (by convention at least) of their structure.

*/
    struct fz_key_storable
    {

        fz_storable storable;

        short store_key_refs;
    }
    /**

	Increment the reference count for a storable object.

	Returns the same pointer.



	Never throws exceptions.

*/
    void* fz_keep_storable(fz_context*, const(fz_storable)*) @nogc nothrow;
    /**

	Decrement the reference count for a storable object. When the

	reference count hits zero, the drop function for that object

	is called to free the object.



	Never throws exceptions.

*/
    void fz_drop_storable(fz_context*, const(fz_storable)*) @nogc nothrow;
    /**

	Increment the (normal) reference count for a key storable

	object. Returns the same pointer.



	Never throws exceptions.

*/
    void* fz_keep_key_storable(fz_context*, const(fz_key_storable)*) @nogc nothrow;
    /**

	Decrement the (normal) reference count for a storable object.

	When the total reference count hits zero, the drop function for

	that object is called to free the object.



	Never throws exceptions.

*/
    void fz_drop_key_storable(fz_context*, const(fz_key_storable)*) @nogc nothrow;
    /**

	Increment the (key) reference count for a key storable

	object. Returns the same pointer.



	Never throws exceptions.

*/
    void* fz_keep_key_storable_key(fz_context*, const(fz_key_storable)*) @nogc nothrow;
    /**

	Decrement the (key) reference count for a storable object.

	When the total reference count hits zero, the drop function for

	that object is called to free the object.



	Never throws exceptions.

*/
    void fz_drop_key_storable_key(fz_context*, const(fz_key_storable)*) @nogc nothrow;
    /**

	The store can be seen as a dictionary that maps keys to

	fz_storable values. In order to allow keys of different types to

	be stored, we have a structure full of functions for each key

	'type'; this fz_store_type pointer is stored with each key, and

	tells the store how to perform certain operations (like taking/

	dropping a reference, comparing two keys, outputting details for

	debugging etc).



	The store uses a hash table internally for speed where possible.

	In order for this to work, we need a mechanism for turning a

	generic 'key' into 'a hashable string'. For this purpose the

	type structure contains a make_hash_key function pointer that

	maps from a void * to a fz_store_hash structure. If

	make_hash_key function returns 0, then the key is determined not

	to be hashable, and the value is not stored in the hash table.



	Some objects can be used both as values within the store, and as

	a component of keys within the store. We refer to these objects

	as "key storable" objects. In this case, we need to take

	additional care to ensure that we do not end up keeping an item

	within the store, purely because its value is referred to by

	another key in the store.



	An example of this are fz_images in PDF files. Each fz_image is

	placed into the	store to enable it to be easily reused. When the

	image is rendered, a pixmap is generated from the image, and the

	pixmap is placed into the store so it can be reused on

	subsequent renders. The image forms part of the key for the

	pixmap.



	When we close the pdf document (and any associated pages/display

	lists etc), we drop the images from the store. This may leave us

	in the position of the images having non-zero reference counts

	purely because they are used as part of the keys for the

	pixmaps.



	We therefore use special reference counting functions to keep

	track of these "key storable" items, and hence store the number

	of references to these items that are used in keys.



	When the number of references to an object == the number of

	references to an object from keys in the store, we know that we

	can remove all the items which have that object as part of the

	key. This is done by running a pass over the store, 'reaping'

	those items.



	Reap passes are slower than we would like as they touch every

	item in the store. We therefore provide a way to 'batch' such

	reap passes together, using fz_defer_reap_start/

	fz_defer_reap_end to bracket a region in which many may be

	triggered.

*/
    struct fz_store_hash
    {

        void function(fz_context*, fz_storable*) drop;

        static union _Anonymous_73
        {

            static struct _Anonymous_74
            {

                const(void)* ptr;

                int i;
            }

            _Anonymous_74 pi;

            static struct _Anonymous_75
            {

                const(void)* ptr;

                int i;

                fz_irect r;
            }

            _Anonymous_75 pir;

            static struct _Anonymous_76
            {

                int id;

                char has_shape;

                char has_group_alpha;

                float[4] m;

                void* ptr;
            }

            _Anonymous_76 im;

            static struct _Anonymous_77
            {
                import std.bitmanip: bitfields;

                align(4):

                ubyte[16] src_md5;

                ubyte[16] dst_md5;
                mixin(bitfields!(

                    uint, "ri", 2,

                    uint, "bp", 1,

                    uint, "format", 1,

                    uint, "proof", 1,

                    uint, "src_extras", 5,

                    uint, "dst_extras", 5,

                    uint, "copy_spots", 1,

                    uint, "bgr", 1,
                    uint, "_padding_0", 15
                ));
            }

            _Anonymous_77 link;
        }

        _Anonymous_73 u;
    }
    /**

	Every type of object to be placed into the store defines an

	fz_store_type. This contains the pointers to functions to

	make hashes, manipulate keys, and check for needing reaping.

*/
    struct fz_store_type
    {

        const(char)* name;

        int function(fz_context*, fz_store_hash*, void*) make_hash_key;

        void* function(fz_context*, void*) keep_key;

        void function(fz_context*, void*) drop_key;

        int function(fz_context*, void*, void*) cmp_key;

        void function(fz_context*, char*, ulong, void*) format_key;

        int function(fz_context*, void*) needs_reap;
    }
    /**

	Create a new store inside the context



	max: The maximum size (in bytes) that the store is allowed to

	grow to. FZ_STORE_UNLIMITED means no limit.

*/
    void fz_new_store_context(fz_context*, ulong) @nogc nothrow;
    /**

	Increment the reference count for the store context. Returns

	the same pointer.



	Never throws exceptions.

*/
    fz_store* fz_keep_store_context(fz_context*) @nogc nothrow;
    /**

	Decrement the reference count for the store context. When the

	reference count hits zero, the store context is freed.



	Never throws exceptions.

*/
    void fz_drop_store_context(fz_context*) @nogc nothrow;
    /**

	Add an item to the store.



	Add an item into the store, returning NULL for success. If an

	item with the same key is found in the store, then our item will

	not be inserted, and the function will return a pointer to that

	value instead. This function takes its own reference to val, as

	required (i.e. the caller maintains ownership of its own

	reference).



	key: The key used to index the item.



	val: The value to store.



	itemsize: The size in bytes of the value (as counted towards the

	store size).



	type: Functions used to manipulate the key.

*/
    void* fz_store_item(fz_context*, void*, void*, ulong, const(fz_store_type)*) @nogc nothrow;
    /**

	Find an item within the store.



	drop: The function used to free the value (to ensure we get a

	value of the correct type).



	key: The key used to index the item.



	type: Functions used to manipulate the key.



	Returns NULL for not found, otherwise returns a pointer to the

	value indexed by key to which a reference has been taken.

*/
    void* fz_find_item(fz_context*, void function(fz_context*, fz_storable*), void*, const(fz_store_type)*) @nogc nothrow;
    /**

	Remove an item from the store.



	If an item indexed by the given key exists in the store, remove

	it.



	drop: The function used to free the value (to ensure we get a

	value of the correct type).



	key: The key used to find the item to remove.



	type: Functions used to manipulate the key.

*/
    void fz_remove_item(fz_context*, void function(fz_context*, fz_storable*), void*, const(fz_store_type)*) @nogc nothrow;
    /**

	Evict every item from the store.

*/
    void fz_empty_store(fz_context*) @nogc nothrow;
    /**

	Internal function used as part of the scavenging

	allocator; when we fail to allocate memory, before returning a

	failure to the caller, we try to scavenge space within the store

	by evicting at least 'size' bytes. The allocator then retries.



	size: The number of bytes we are trying to have free.



	phase: What phase of the scavenge we are in. Updated on exit.



	Returns non zero if we managed to free any memory.

*/
    int fz_store_scavenge(fz_context*, ulong, int*) @nogc nothrow;
    /**

	External function for callers to use

	to scavenge while trying allocations.



	size: The number of bytes we are trying to have free.



	phase: What phase of the scavenge we are in. Updated on exit.



	Returns non zero if we managed to free any memory.

*/
    int fz_store_scavenge_external(fz_context*, ulong, int*) @nogc nothrow;
    /**

	Evict items from the store until the total size of

	the objects in the store is reduced to a given percentage of its

	current size.



	percent: %age of current size to reduce the store to.



	Returns non zero if we managed to free enough memory, zero

	otherwise.

*/
    int fz_shrink_store(fz_context*, uint) @nogc nothrow;
    alias fz_store_filter_fn = int function(fz_context*, void*, void*);
    /**

	Filter every element in the store with a matching type with the

	given function.



	If the function returns 1 for an element, drop the element.

*/
    void fz_filter_store(fz_context*, int function(fz_context*, void*, void*), void*, const(fz_store_type)*) @nogc nothrow;
    /**

	Output debugging information for the current state of the store

	to the given output channel.

*/
    void fz_debug_store(fz_context*, fz_output*) @nogc nothrow;
    /**

	Increment the defer reap count.



	No reap operations will take place (except for those

	triggered by an immediate failed malloc) until the

	defer reap count returns to 0.



	Call this at the start of a process during which you

	potentially might drop many reapable objects.



	It is vital that every fz_defer_reap_start is matched

	by a fz_defer_reap_end call.

*/
    void fz_defer_reap_start(fz_context*) @nogc nothrow;
    /**

	Decrement the defer reap count.



	If the defer reap count returns to 0, and the store

	has reapable objects in, a reap pass will begin.



	Call this at the end of a process during which you

	potentially might drop many reapable objects.



	It is vital that every fz_defer_reap_start is matched

	by a fz_defer_reap_end call.

*/
    void fz_defer_reap_end(fz_context*) @nogc nothrow;

    struct fz_write_story_position
    {

        fz_story_element_position element;

        int page_num;
    }

    struct fz_write_story_positions
    {

        fz_write_story_position* positions;

        int num;
    }
    alias fz_write_story_rectfn = int function(fz_context*, void*, int, fz_rect, fz_rect*, fz_matrix*, fz_rect*);
    alias fz_write_story_positionfn = void function(fz_context*, void*, const(fz_write_story_position)*);
    alias fz_write_story_pagefn = void function(fz_context*, void*, int, fz_rect, fz_device*, int);
    alias fz_write_story_contentfn = void function(fz_context*, void*, const(fz_write_story_positions)*, fz_buffer*);

    void fz_write_story(fz_context*, fz_document_writer*, fz_story_s*, int function(fz_context*, void*, int, fz_rect, fz_rect*, fz_matrix*, fz_rect*), void*, void function(fz_context*, void*, const(fz_write_story_position)*), void*, void function(fz_context*, void*, int, fz_rect, fz_device*, int), void*) @nogc nothrow;

    void fz_write_stabilized_story(fz_context*, fz_document_writer*, const(char)*, float, void function(fz_context*, void*, const(fz_write_story_positions)*, fz_buffer*), void*, int function(fz_context*, void*, int, fz_rect, fz_rect*, fz_matrix*, fz_rect*), void*, void function(fz_context*, void*, int, fz_rect, fz_device*, int), void*, fz_archive*) @nogc nothrow;

    alias fz_story = fz_story_s;
    struct fz_story_s;

    fz_story_s* fz_new_story(fz_context*, fz_buffer*, const(char)*, float, fz_archive*) @nogc nothrow;

    const(char)* fz_story_warnings(fz_context*, fz_story_s*) @nogc nothrow;

    int fz_place_story(fz_context*, fz_story_s*, fz_rect, fz_rect*) @nogc nothrow;

    void fz_draw_story(fz_context*, fz_story_s*, fz_device*, fz_matrix) @nogc nothrow;

    void fz_reset_story(fz_context*, fz_story_s*) @nogc nothrow;

    void fz_drop_story(fz_context*, fz_story_s*) @nogc nothrow;

    fz_xml* fz_story_document(fz_context*, fz_story_s*) @nogc nothrow;

    struct fz_story_element_position
    {

        int depth;

        int heading;

        const(char)* id;

        const(char)* href;

        fz_rect rect;

        const(char)* text;

        int open_close;

        int rectangle_num;
    }
    alias fz_story_position_callback = void function(fz_context*, void*, const(fz_story_element_position)*);

    void fz_story_positions(fz_context*, fz_story_s*, void function(fz_context*, void*, const(fz_story_element_position)*), void*) @nogc nothrow;
    /**

	Return true if the named file exists and is readable.

*/
    int fz_file_exists(fz_context*, const(char)*) @nogc nothrow;

    struct fz_stream
    {

        int refs;

        int error;

        int eof;

        int progressive;

        long pos;

        int avail;

        int bits;

        ubyte* rp;

        ubyte* wp;

        void* state;

        int function(fz_context*, fz_stream*, ulong) next;

        void function(fz_context*, void*) drop;

        void function(fz_context*, fz_stream*, long, int) seek;
    }
    /**

	Open the named file and wrap it in a stream.



	filename: Path to a file. On non-Windows machines the filename

	should be exactly as it would be passed to fopen(2). On Windows

	machines, the path should be UTF-8 encoded so that non-ASCII

	characters can be represented. Other platforms do the encoding

	as standard anyway (and in most cases, particularly for MacOS

	and Linux, the encoding they use is UTF-8 anyway).

*/
    fz_stream* fz_open_file(fz_context*, const(char)*) @nogc nothrow;
    /**

	Open the named file and wrap it in a stream.



	This function is only available when compiling for Win32.



	filename: Wide character path to the file as it would be given

	to _wfopen().

*/
    fz_stream* fz_open_file_w(fz_context*, const(ushort)*) @nogc nothrow;
    /**

	Open a block of memory as a stream.



	data: Pointer to start of data block. Ownership of the data

	block is NOT passed in.



	len: Number of bytes in data block.



	Returns pointer to newly created stream. May throw exceptions on

	failure to allocate.

*/
    fz_stream* fz_open_memory(fz_context*, const(ubyte)*, ulong) @nogc nothrow;
    /**

	Open a buffer as a stream.



	buf: The buffer to open. Ownership of the buffer is NOT passed

	in (this function takes its own reference).



	Returns pointer to newly created stream. May throw exceptions on

	failure to allocate.

*/
    fz_stream* fz_open_buffer(fz_context*, fz_buffer*) @nogc nothrow;
    /**

	Attach a filter to a stream that will store any

	characters read from the stream into the supplied buffer.



	chain: The underlying stream to leech from.



	buf: The buffer into which the read data should be appended.

	The buffer will be resized as required.



	Returns pointer to newly created stream. May throw exceptions on

	failure to allocate.

*/
    fz_stream* fz_open_leecher(fz_context*, fz_stream*, fz_buffer*) @nogc nothrow;
    /**

	Increments the reference count for a stream. Returns the same

	pointer.



	Never throws exceptions.

*/
    fz_stream* fz_keep_stream(fz_context*, fz_stream*) @nogc nothrow;
    /**

	Decrements the reference count for a stream.



	When the reference count for the stream hits zero, frees the

	storage used for the fz_stream itself, and (usually)

	releases the underlying resources that the stream is based upon

	(depends on the method used to open the stream initially).

*/
    void fz_drop_stream(fz_context*, fz_stream*) @nogc nothrow;
    /**

	return the current reading position within a stream

*/
    long fz_tell(fz_context*, fz_stream*) @nogc nothrow;
    /**

	Seek within a stream.



	stm: The stream to seek within.



	offset: The offset to seek to.



	whence: From where the offset is measured (see fseek).

*/
    void fz_seek(fz_context*, fz_stream*, long, int) @nogc nothrow;
    /**

	Read from a stream into a given data block.



	stm: The stream to read from.



	data: The data block to read into.



	len: The length of the data block (in bytes).



	Returns the number of bytes read. May throw exceptions.

*/
    ulong fz_read(fz_context*, fz_stream*, ubyte*, ulong) @nogc nothrow;
    /**

	Read from a stream discarding data.



	stm: The stream to read from.



	len: The number of bytes to read.



	Returns the number of bytes read. May throw exceptions.

*/
    ulong fz_skip(fz_context*, fz_stream*, ulong) @nogc nothrow;
    /**

	Read all of a stream into a buffer.



	stm: The stream to read from



	initial: Suggested initial size for the buffer.



	Returns a buffer created from reading from the stream. May throw

	exceptions on failure to allocate.

*/
    fz_buffer* fz_read_all(fz_context*, fz_stream*, ulong) @nogc nothrow;
    /**

	Read all the contents of a file into a buffer.

*/
    fz_buffer* fz_read_file(fz_context*, const(char)*) @nogc nothrow;
    /**

	fz_read_[u]int(16|24|32|64)(_le)?



	Read a 16/32/64 bit signed/unsigned integer from stream,

	in big or little-endian byte orders.



	Throws an exception if EOF is encountered.

*/
    ushort fz_read_uint16(fz_context*, fz_stream*) @nogc nothrow;

    uint fz_read_uint24(fz_context*, fz_stream*) @nogc nothrow;

    uint fz_read_uint32(fz_context*, fz_stream*) @nogc nothrow;

    ulong fz_read_uint64(fz_context*, fz_stream*) @nogc nothrow;

    ushort fz_read_uint16_le(fz_context*, fz_stream*) @nogc nothrow;

    uint fz_read_uint24_le(fz_context*, fz_stream*) @nogc nothrow;

    uint fz_read_uint32_le(fz_context*, fz_stream*) @nogc nothrow;

    ulong fz_read_uint64_le(fz_context*, fz_stream*) @nogc nothrow;

    short fz_read_int16(fz_context*, fz_stream*) @nogc nothrow;

    int fz_read_int32(fz_context*, fz_stream*) @nogc nothrow;

    long fz_read_int64(fz_context*, fz_stream*) @nogc nothrow;

    short fz_read_int16_le(fz_context*, fz_stream*) @nogc nothrow;

    int fz_read_int32_le(fz_context*, fz_stream*) @nogc nothrow;

    long fz_read_int64_le(fz_context*, fz_stream*) @nogc nothrow;

    float fz_read_float_le(fz_context*, fz_stream*) @nogc nothrow;

    float fz_read_float(fz_context*, fz_stream*) @nogc nothrow;
    /**

	Read a null terminated string from the stream into

	a buffer of a given length. The buffer will be null terminated.

	Throws on failure (including the failure to fit the entire

	string including the terminator into the buffer).

*/
    void fz_read_string(fz_context*, fz_stream*, char*, int) @nogc nothrow;
    alias fz_stream_next_fn = int function(fz_context*, fz_stream*, ulong);
    alias fz_stream_drop_fn = void function(fz_context*, void*);
    alias fz_stream_seek_fn = void function(fz_context*, fz_stream*, long, int);
    /**

	Create a new stream object with the given

	internal state and function pointers.



	state: Internal state (opaque to everything but implementation).



	next: Should provide the next set of bytes (up to max) of stream

	data. Return the number of bytes read, or EOF when there is no

	more data.



	drop: Should clean up and free the internal state. May not

	throw exceptions.

*/
    fz_stream* fz_new_stream(fz_context*, void*, int function(fz_context*, fz_stream*, ulong), void function(fz_context*, void*)) @nogc nothrow;
    /**

	Attempt to read a stream into a buffer. If truncated

	is NULL behaves as fz_read_all, sets a truncated flag in case of

	error.



	stm: The stream to read from.



	initial: Suggested initial size for the buffer.



	truncated: Flag to store success/failure indication in.



	worst_case: 0 for unknown, otherwise an upper bound for the

	size of the stream.



	Returns a buffer created from reading from the stream.

*/
    fz_buffer* fz_read_best(fz_context*, fz_stream*, ulong, int*, ulong) @nogc nothrow;
    /**

	Read a line from stream into the buffer until either a

	terminating newline or EOF, which it replaces with a null byte

	('\0').



	Returns buf on success, and NULL when end of file occurs while

	no characters have been read.

*/
    char* fz_read_line(fz_context*, fz_stream*, char*, ulong) @nogc nothrow;
    /**

	Skip over a given string in a stream. Return 0 if successfully

	skipped, non-zero otherwise. As many characters will be skipped

	over as matched in the string.

*/
    int fz_skip_string(fz_context*, fz_stream*, const(char)*) @nogc nothrow;
    /**

	Skip over whitespace (bytes <= 32) in a stream.

*/
    void fz_skip_space(fz_context*, fz_stream*) @nogc nothrow;







    enum _dpp_impl_FZ_LOG_DUMP_STORE_mixin = ` auto FZ_LOG_DUMP_STORE(, REST...)(, REST rest) {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_FZ_LOG_DUMP_STORE_mixin); })) {
        mixin(_dpp_impl_FZ_LOG_DUMP_STORE_mixin);
    }


    enum _dpp_impl_FZ_LOG_STORE_mixin = ` auto FZ_LOG_STORE(, REST...)(, REST rest) {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_FZ_LOG_STORE_mixin); })) {
        mixin(_dpp_impl_FZ_LOG_STORE_mixin);
    }


    enum _dpp_impl_FZ_INIT_KEY_STORABLE_mixin = ` auto FZ_INIT_KEY_STORABLE(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return do { fz_key_storable * KS = & ( arg0 ) . key_storable ; KS . store_key_refs = 0 ; FZ_INIT_STORABLE ( KS , arg1 , arg2 ) ; } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_FZ_INIT_KEY_STORABLE_mixin); })) {
        mixin(_dpp_impl_FZ_INIT_KEY_STORABLE_mixin);
    }


    enum _dpp_impl_FZ_INIT_STORABLE_mixin = ` auto FZ_INIT_STORABLE(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return do { fz_storable * S = & ( arg0 ) . storable ; S . refs = ( arg1 ) ; S . drop = ( arg2 ) ; } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_FZ_INIT_STORABLE_mixin); })) {
        mixin(_dpp_impl_FZ_INIT_STORABLE_mixin);
    }
    enum _dpp_impl_fz_new_derived_outline_iter_mixin = ` auto fz_new_derived_outline_iter(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ( cast( arg1 * ) Memento_label ( fz_new_outline_iterator_of_size ( ctx , ( arg1 ) .sizeof , arg2 ) , "arg1" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_new_derived_outline_iter_mixin); })) {
        mixin(_dpp_impl_fz_new_derived_outline_iter_mixin);
    }






    enum _dpp_impl_fz_new_derived_link_mixin = ` auto fz_new_derived_link(A0, A1, A2, A3)(A0 arg0, A1 arg1, A2 arg2, A3 arg3) {
        return ( cast( arg1 * ) Memento_label ( fz_new_link_of_size ( arg0 , ( arg1 ) .sizeof , arg2 , arg3 ) , "arg1" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_new_derived_link_mixin); })) {
        mixin(_dpp_impl_fz_new_derived_link_mixin);
    }




    enum _dpp_impl_fz_new_derived_image_mixin = ` auto fz_new_derived_image(A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15)(A0 arg0, A1 arg1, A2 arg2, A3 arg3, A4 arg4, A5 arg5, A6 arg6, A7 arg7, A8 arg8, A9 arg9, A10 arg10, A11 arg11, A12 arg12, A13 arg13, A14 arg14, A15 arg15) {
        return ( cast( arg12 * ) Memento_label ( fz_new_image_of_size ( arg0 , arg1 , arg2 , arg3 , arg4 , arg5 , arg6 , arg7 , arg8 , arg9 , arg10 , arg11 , ( arg12 ) .sizeof , arg13 , arg14 , arg15 ) , "arg12" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_new_derived_image_mixin); })) {
        mixin(_dpp_impl_fz_new_derived_image_mixin);
    }






    static if(!is(typeof(FZ_HASH_TABLE_KEY_LENGTH))) {
        private enum enumMixinStr_FZ_HASH_TABLE_KEY_LENGTH = `enum FZ_HASH_TABLE_KEY_LENGTH = 48;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_HASH_TABLE_KEY_LENGTH); }))) {
            mixin(enumMixinStr_FZ_HASH_TABLE_KEY_LENGTH);
        }
    }
    static if(!is(typeof(FZ_MAX_INF_RECT))) {
        private enum enumMixinStr_FZ_MAX_INF_RECT = `enum FZ_MAX_INF_RECT = ( cast( int ) 0x7fffff80 );`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_MAX_INF_RECT); }))) {
            mixin(enumMixinStr_FZ_MAX_INF_RECT);
        }
    }






    static if(!is(typeof(FZ_MIN_INF_RECT))) {
        private enum enumMixinStr_FZ_MIN_INF_RECT = `enum FZ_MIN_INF_RECT = ( cast( int ) 0x80000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_MIN_INF_RECT); }))) {
            mixin(enumMixinStr_FZ_MIN_INF_RECT);
        }
    }


    enum _dpp_impl_DIV_BY_ZERO_mixin = ` auto DIV_BY_ZERO(A0, A1, A2, A3)(A0 arg0, A1 arg1, A2 arg2, A3 arg3) {
        return ( ( ( arg0 ) < 0 ) ^ ( ( arg1 ) < 0 ) ? ( arg2 ) : ( arg3 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_DIV_BY_ZERO_mixin); })) {
        mixin(_dpp_impl_DIV_BY_ZERO_mixin);
    }




    static if(!is(typeof(FZ_REPLACEMENT_CHARACTER))) {
        private enum enumMixinStr_FZ_REPLACEMENT_CHARACTER = `enum FZ_REPLACEMENT_CHARACTER = 0xFFFD;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_REPLACEMENT_CHARACTER); }))) {
            mixin(enumMixinStr_FZ_REPLACEMENT_CHARACTER);
        }
    }


    enum _dpp_impl_FZ_BLEND_mixin = ` auto FZ_BLEND(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ( ( ( ( arg0 ) - ( arg1 ) ) * ( arg2 ) + ( ( arg1 ) << 8 ) ) >> 8 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_FZ_BLEND_mixin); })) {
        mixin(_dpp_impl_FZ_BLEND_mixin);
    }


    enum _dpp_impl_FZ_COMBINE2_mixin = ` auto FZ_COMBINE2(A0, A1, A2, A3)(A0 arg0, A1 arg1, A2 arg2, A3 arg3) {
        return ( ( ( arg0 ) * ( arg1 ) + ( arg2 ) * ( arg3 ) ) >> 8 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_FZ_COMBINE2_mixin); })) {
        mixin(_dpp_impl_FZ_COMBINE2_mixin);
    }


    enum _dpp_impl_FZ_COMBINE_mixin = ` auto FZ_COMBINE(A0, A1)(A0 arg0, A1 arg1) {
        return ( ( ( arg0 ) * ( arg1 ) ) >> 8 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_FZ_COMBINE_mixin); })) {
        mixin(_dpp_impl_FZ_COMBINE_mixin);
    }


    enum _dpp_impl_FZ_EXPAND_mixin = ` auto FZ_EXPAND(A0)(A0 arg0) {
        return ( ( arg0 ) + ( ( arg0 ) >> 7 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_FZ_EXPAND_mixin); })) {
        mixin(_dpp_impl_FZ_EXPAND_mixin);
    }
    static if(!is(typeof(FZ_META_INFO_MODIFICATIONDATE))) {
        private enum enumMixinStr_FZ_META_INFO_MODIFICATIONDATE = `enum FZ_META_INFO_MODIFICATIONDATE = "info:ModDate";`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_META_INFO_MODIFICATIONDATE); }))) {
            mixin(enumMixinStr_FZ_META_INFO_MODIFICATIONDATE);
        }
    }




    static if(!is(typeof(FZ_META_INFO_CREATIONDATE))) {
        private enum enumMixinStr_FZ_META_INFO_CREATIONDATE = `enum FZ_META_INFO_CREATIONDATE = "info:CreationDate";`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_META_INFO_CREATIONDATE); }))) {
            mixin(enumMixinStr_FZ_META_INFO_CREATIONDATE);
        }
    }




    static if(!is(typeof(FZ_META_INFO_PRODUCER))) {
        private enum enumMixinStr_FZ_META_INFO_PRODUCER = `enum FZ_META_INFO_PRODUCER = "info:Producer";`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_META_INFO_PRODUCER); }))) {
            mixin(enumMixinStr_FZ_META_INFO_PRODUCER);
        }
    }




    static if(!is(typeof(FZ_META_INFO_CREATOR))) {
        private enum enumMixinStr_FZ_META_INFO_CREATOR = `enum FZ_META_INFO_CREATOR = "info:Creator";`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_META_INFO_CREATOR); }))) {
            mixin(enumMixinStr_FZ_META_INFO_CREATOR);
        }
    }




    static if(!is(typeof(FZ_META_INFO_KEYWORDS))) {
        private enum enumMixinStr_FZ_META_INFO_KEYWORDS = `enum FZ_META_INFO_KEYWORDS = "info:Keywords";`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_META_INFO_KEYWORDS); }))) {
            mixin(enumMixinStr_FZ_META_INFO_KEYWORDS);
        }
    }




    static if(!is(typeof(FZ_META_INFO_SUBJECT))) {
        private enum enumMixinStr_FZ_META_INFO_SUBJECT = `enum FZ_META_INFO_SUBJECT = "info:Subject";`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_META_INFO_SUBJECT); }))) {
            mixin(enumMixinStr_FZ_META_INFO_SUBJECT);
        }
    }




    static if(!is(typeof(FZ_META_INFO_AUTHOR))) {
        private enum enumMixinStr_FZ_META_INFO_AUTHOR = `enum FZ_META_INFO_AUTHOR = "info:Author";`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_META_INFO_AUTHOR); }))) {
            mixin(enumMixinStr_FZ_META_INFO_AUTHOR);
        }
    }




    static if(!is(typeof(FZ_META_INFO_TITLE))) {
        private enum enumMixinStr_FZ_META_INFO_TITLE = `enum FZ_META_INFO_TITLE = "info:Title";`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_META_INFO_TITLE); }))) {
            mixin(enumMixinStr_FZ_META_INFO_TITLE);
        }
    }




    static if(!is(typeof(FZ_META_INFO))) {
        private enum enumMixinStr_FZ_META_INFO = `enum FZ_META_INFO = "info:";`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_META_INFO); }))) {
            mixin(enumMixinStr_FZ_META_INFO);
        }
    }




    static if(!is(typeof(FZ_META_ENCRYPTION))) {
        private enum enumMixinStr_FZ_META_ENCRYPTION = `enum FZ_META_ENCRYPTION = "encryption";`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_META_ENCRYPTION); }))) {
            mixin(enumMixinStr_FZ_META_ENCRYPTION);
        }
    }




    static if(!is(typeof(FZ_META_FORMAT))) {
        private enum enumMixinStr_FZ_META_FORMAT = `enum FZ_META_FORMAT = "format";`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_META_FORMAT); }))) {
            mixin(enumMixinStr_FZ_META_FORMAT);
        }
    }


    enum _dpp_impl_fz_new_derived_page_mixin = ` auto fz_new_derived_page(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ( cast( arg1 * ) Memento_label ( fz_new_page_of_size ( arg0 , ( arg1 ) .sizeof , arg2 ) , "arg1" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_new_derived_page_mixin); })) {
        mixin(_dpp_impl_fz_new_derived_page_mixin);
    }


    enum _dpp_impl_fz_new_derived_document_mixin = ` auto fz_new_derived_document(A0, A1)(A0 arg0, A1 arg1) {
        return ( cast( arg1 * ) Memento_label ( fz_new_document_of_size ( arg0 , ( arg1 ) .sizeof ) , "arg1" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_new_derived_document_mixin); })) {
        mixin(_dpp_impl_fz_new_derived_document_mixin);
    }






    enum _dpp_impl_fz_new_derived_device_mixin = ` auto fz_new_derived_device(A0, A1)(A0 arg0, A1 arg1) {
        return ( cast( arg1 * ) Memento_label ( fz_new_device_of_size ( ctx , ( arg1 ) .sizeof ) , "arg1" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_new_derived_device_mixin); })) {
        mixin(_dpp_impl_fz_new_derived_device_mixin);
    }
    static if(!is(typeof(FZ_AES_ENCRYPT))) {
        private enum enumMixinStr_FZ_AES_ENCRYPT = `enum FZ_AES_ENCRYPT = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_AES_ENCRYPT); }))) {
            mixin(enumMixinStr_FZ_AES_ENCRYPT);
        }
    }




    static if(!is(typeof(FZ_AES_DECRYPT))) {
        private enum enumMixinStr_FZ_AES_DECRYPT = `enum FZ_AES_DECRYPT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_AES_DECRYPT); }))) {
            mixin(enumMixinStr_FZ_AES_DECRYPT);
        }
    }






    static if(!is(typeof(FZ_JMPBUF_ALIGN))) {
        private enum enumMixinStr_FZ_JMPBUF_ALIGN = `enum FZ_JMPBUF_ALIGN = 32;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_JMPBUF_ALIGN); }))) {
            mixin(enumMixinStr_FZ_JMPBUF_ALIGN);
        }
    }


    enum _dpp_impl_fz_realloc_array_mixin = ` auto fz_realloc_array(A0, A1, A2, A3)(A0 arg0, A1 arg1, A2 arg2, A3 arg3) {
        return ( cast( arg3 * ) Memento_label ( fz_realloc ( arg0 , arg1 , ( arg2 ) * ( arg3 ) .sizeof ) , "arg3" "[]" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_realloc_array_mixin); })) {
        mixin(_dpp_impl_fz_realloc_array_mixin);
    }


    enum _dpp_impl_fz_malloc_array_mixin = ` auto fz_malloc_array(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ( cast( arg2 * ) Memento_label ( fz_malloc ( arg0 , ( arg1 ) * ( arg2 ) .sizeof ) , "arg2" "[]" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_malloc_array_mixin); })) {
        mixin(_dpp_impl_fz_malloc_array_mixin);
    }


    enum _dpp_impl_fz_malloc_struct_array_mixin = ` auto fz_malloc_struct_array(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ( cast( arg2 * ) Memento_label ( fz_calloc ( arg0 , arg1 , ( arg2 ) .sizeof ) , "arg2" "[]" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_malloc_struct_array_mixin); })) {
        mixin(_dpp_impl_fz_malloc_struct_array_mixin);
    }


    enum _dpp_impl_fz_malloc_struct_mixin = ` auto fz_malloc_struct(A0, A1)(A0 arg0, A1 arg1) {
        return ( cast( arg1 * ) Memento_label ( fz_calloc ( arg0 , 1 , ( arg1 ) .sizeof ) , "arg1" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_malloc_struct_mixin); })) {
        mixin(_dpp_impl_fz_malloc_struct_mixin);
    }


    enum _dpp_impl_fz_new_context_mixin = ` auto fz_new_context(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return fz_new_context_imp ( arg0 , arg1 , arg2 , FZ_VERSION );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_new_context_mixin); })) {
        mixin(_dpp_impl_fz_new_context_mixin);
    }




    enum _dpp_impl_fz_catch_mixin = ` auto fz_catch(A0)(A0 arg0) {
        return while ( 0 ) ; if ( fz_do_catch ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_catch_mixin); })) {
        mixin(_dpp_impl_fz_catch_mixin);
    }


    enum _dpp_impl_fz_always_mixin = ` auto fz_always(A0)(A0 arg0) {
        return while ( 0 ) ; if ( fz_do_always ( arg0 ) ) do;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_always_mixin); })) {
        mixin(_dpp_impl_fz_always_mixin);
    }


    enum _dpp_impl_fz_try_mixin = ` auto fz_try(A0)(A0 arg0) {
        return if ( ! fz_setjmp ( * fz_push_try ( arg0 ) ) ) if ( fz_do_try ( arg0 ) ) do;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_try_mixin); })) {
        mixin(_dpp_impl_fz_try_mixin);
    }


    enum _dpp_impl_fz_var_mixin = ` auto fz_var(A0)(A0 arg0) {
        return fz_var_imp ( cast( void * ) & ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_var_mixin); })) {
        mixin(_dpp_impl_fz_var_mixin);
    }
    static if(!is(typeof(FZ_ENABLE_ICC))) {
        private enum enumMixinStr_FZ_ENABLE_ICC = `enum FZ_ENABLE_ICC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_ICC); }))) {
            mixin(enumMixinStr_FZ_ENABLE_ICC);
        }
    }




    static if(!is(typeof(FZ_ENABLE_JS))) {
        private enum enumMixinStr_FZ_ENABLE_JS = `enum FZ_ENABLE_JS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_JS); }))) {
            mixin(enumMixinStr_FZ_ENABLE_JS);
        }
    }




    static if(!is(typeof(FZ_ENABLE_JPX))) {
        private enum enumMixinStr_FZ_ENABLE_JPX = `enum FZ_ENABLE_JPX = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_JPX); }))) {
            mixin(enumMixinStr_FZ_ENABLE_JPX);
        }
    }




    static if(!is(typeof(FZ_ENABLE_DOCX_OUTPUT))) {
        private enum enumMixinStr_FZ_ENABLE_DOCX_OUTPUT = `enum FZ_ENABLE_DOCX_OUTPUT = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_DOCX_OUTPUT); }))) {
            mixin(enumMixinStr_FZ_ENABLE_DOCX_OUTPUT);
        }
    }




    static if(!is(typeof(FZ_ENABLE_ODT_OUTPUT))) {
        private enum enumMixinStr_FZ_ENABLE_ODT_OUTPUT = `enum FZ_ENABLE_ODT_OUTPUT = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_ODT_OUTPUT); }))) {
            mixin(enumMixinStr_FZ_ENABLE_ODT_OUTPUT);
        }
    }




    static if(!is(typeof(FZ_ENABLE_OCR_OUTPUT))) {
        private enum enumMixinStr_FZ_ENABLE_OCR_OUTPUT = `enum FZ_ENABLE_OCR_OUTPUT = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_OCR_OUTPUT); }))) {
            mixin(enumMixinStr_FZ_ENABLE_OCR_OUTPUT);
        }
    }




    static if(!is(typeof(FZ_ENABLE_EPUB))) {
        private enum enumMixinStr_FZ_ENABLE_EPUB = `enum FZ_ENABLE_EPUB = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_EPUB); }))) {
            mixin(enumMixinStr_FZ_ENABLE_EPUB);
        }
    }




    static if(!is(typeof(FZ_ENABLE_HTML))) {
        private enum enumMixinStr_FZ_ENABLE_HTML = `enum FZ_ENABLE_HTML = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_HTML); }))) {
            mixin(enumMixinStr_FZ_ENABLE_HTML);
        }
    }




    static if(!is(typeof(FZ_ENABLE_IMG))) {
        private enum enumMixinStr_FZ_ENABLE_IMG = `enum FZ_ENABLE_IMG = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_IMG); }))) {
            mixin(enumMixinStr_FZ_ENABLE_IMG);
        }
    }




    static if(!is(typeof(FZ_ENABLE_CBZ))) {
        private enum enumMixinStr_FZ_ENABLE_CBZ = `enum FZ_ENABLE_CBZ = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_CBZ); }))) {
            mixin(enumMixinStr_FZ_ENABLE_CBZ);
        }
    }




    static if(!is(typeof(FZ_ENABLE_SVG))) {
        private enum enumMixinStr_FZ_ENABLE_SVG = `enum FZ_ENABLE_SVG = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_SVG); }))) {
            mixin(enumMixinStr_FZ_ENABLE_SVG);
        }
    }




    static if(!is(typeof(FZ_ENABLE_XPS))) {
        private enum enumMixinStr_FZ_ENABLE_XPS = `enum FZ_ENABLE_XPS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_XPS); }))) {
            mixin(enumMixinStr_FZ_ENABLE_XPS);
        }
    }




    static if(!is(typeof(FZ_ENABLE_PDF))) {
        private enum enumMixinStr_FZ_ENABLE_PDF = `enum FZ_ENABLE_PDF = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_PDF); }))) {
            mixin(enumMixinStr_FZ_ENABLE_PDF);
        }
    }




    static if(!is(typeof(FZ_PLOTTERS_CMYK))) {
        private enum enumMixinStr_FZ_PLOTTERS_CMYK = `enum FZ_PLOTTERS_CMYK = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_PLOTTERS_CMYK); }))) {
            mixin(enumMixinStr_FZ_PLOTTERS_CMYK);
        }
    }




    static if(!is(typeof(FZ_PLOTTERS_RGB))) {
        private enum enumMixinStr_FZ_PLOTTERS_RGB = `enum FZ_PLOTTERS_RGB = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_PLOTTERS_RGB); }))) {
            mixin(enumMixinStr_FZ_PLOTTERS_RGB);
        }
    }




    static if(!is(typeof(FZ_PLOTTERS_G))) {
        private enum enumMixinStr_FZ_PLOTTERS_G = `enum FZ_PLOTTERS_G = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_PLOTTERS_G); }))) {
            mixin(enumMixinStr_FZ_PLOTTERS_G);
        }
    }




    static if(!is(typeof(FZ_PLOTTERS_N))) {
        private enum enumMixinStr_FZ_PLOTTERS_N = `enum FZ_PLOTTERS_N = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_PLOTTERS_N); }))) {
            mixin(enumMixinStr_FZ_PLOTTERS_N);
        }
    }




    static if(!is(typeof(FZ_ENABLE_SPOT_RENDERING))) {
        private enum enumMixinStr_FZ_ENABLE_SPOT_RENDERING = `enum FZ_ENABLE_SPOT_RENDERING = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_ENABLE_SPOT_RENDERING); }))) {
            mixin(enumMixinStr_FZ_ENABLE_SPOT_RENDERING);
        }
    }
    enum _dpp_impl_fz_new_band_writer_mixin = ` auto fz_new_band_writer(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ( cast( arg1 * ) Memento_label ( fz_new_band_writer_of_size ( ctx , ( arg1 ) .sizeof , arg2 ) , "arg1" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_new_band_writer_mixin); })) {
        mixin(_dpp_impl_fz_new_band_writer_mixin);
    }




    enum _dpp_impl_fz_new_derived_archive_mixin = ` auto fz_new_derived_archive(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ( cast( arg2 * ) Memento_label ( fz_new_archive_of_size ( arg0 , arg1 , ( arg2 ) .sizeof ) , "arg2" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_new_derived_archive_mixin); })) {
        mixin(_dpp_impl_fz_new_derived_archive_mixin);
    }
    enum _dpp_impl_offsetof_mixin = ` auto offsetof(A0, A1)(A0 arg0, A1 arg1) {
        return __builtin_offsetof ( arg0 , arg1 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_offsetof_mixin); })) {
        mixin(_dpp_impl_offsetof_mixin);
    }




    static if(!is(typeof(NULL))) {
        private enum enumMixinStr_NULL = `enum NULL = ( cast( void * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_NULL); }))) {
            mixin(enumMixinStr_NULL);
        }
    }
    enum _dpp_impl_nelem_mixin = ` auto nelem(A0)(A0 arg0) {
        return ( ( arg0 ) .sizeof / ( ( arg0 ) [ 0 ] ) .sizeof );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_nelem_mixin); })) {
        mixin(_dpp_impl_nelem_mixin);
    }




    static if(!is(typeof(FZ_PI))) {
        private enum enumMixinStr_FZ_PI = `enum FZ_PI = 3.14159265f;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_PI); }))) {
            mixin(enumMixinStr_FZ_PI);
        }
    }




    static if(!is(typeof(FZ_RADIAN))) {
        private enum enumMixinStr_FZ_RADIAN = `enum FZ_RADIAN = 57.2957795f;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_RADIAN); }))) {
            mixin(enumMixinStr_FZ_RADIAN);
        }
    }




    static if(!is(typeof(FZ_DEGREE))) {
        private enum enumMixinStr_FZ_DEGREE = `enum FZ_DEGREE = 0.017453292f;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_DEGREE); }))) {
            mixin(enumMixinStr_FZ_DEGREE);
        }
    }




    static if(!is(typeof(FZ_SQRT2))) {
        private enum enumMixinStr_FZ_SQRT2 = `enum FZ_SQRT2 = 1.41421356f;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_SQRT2); }))) {
            mixin(enumMixinStr_FZ_SQRT2);
        }
    }




    static if(!is(typeof(FZ_LN2))) {
        private enum enumMixinStr_FZ_LN2 = `enum FZ_LN2 = 0.69314718f;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_LN2); }))) {
            mixin(enumMixinStr_FZ_LN2);
        }
    }




    static if(!is(typeof(HAVE_SIGSETJMP))) {
        private enum enumMixinStr_HAVE_SIGSETJMP = `enum HAVE_SIGSETJMP = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_HAVE_SIGSETJMP); }))) {
            mixin(enumMixinStr_HAVE_SIGSETJMP);
        }
    }




    static if(!is(typeof(__GNUC_VA_LIST))) {
        private enum enumMixinStr___GNUC_VA_LIST = `enum __GNUC_VA_LIST = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___GNUC_VA_LIST); }))) {
            mixin(enumMixinStr___GNUC_VA_LIST);
        }
    }


    enum _dpp_impl_fz_setjmp_mixin = ` auto fz_setjmp(A0)(A0 arg0) {
        return setjmp ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_setjmp_mixin); })) {
        mixin(_dpp_impl_fz_setjmp_mixin);
    }


    enum _dpp_impl_fz_longjmp_mixin = ` auto fz_longjmp(A0, A1)(A0 arg0, A1 arg1) {
        return longjmp ( arg0 , arg1 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_longjmp_mixin); })) {
        mixin(_dpp_impl_fz_longjmp_mixin);
    }


    enum _dpp_impl_va_copy_mixin = ` auto va_copy(A0, A1)(A0 arg0, A1 arg1) {
        return __builtin_va_copy ( arg0 , arg1 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_va_copy_mixin); })) {
        mixin(_dpp_impl_va_copy_mixin);
    }




    enum _dpp_impl_va_arg_mixin = ` auto va_arg(A0, A1)(A0 arg0, A1 arg1) {
        return __builtin_va_arg ( arg0 , arg1 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_va_arg_mixin); })) {
        mixin(_dpp_impl_va_arg_mixin);
    }


    enum _dpp_impl_va_end_mixin = ` auto va_end(A0)(A0 arg0) {
        return __builtin_va_end ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_va_end_mixin); })) {
        mixin(_dpp_impl_va_end_mixin);
    }


    enum _dpp_impl_va_start_mixin = ` auto va_start(A0, A1)(A0 arg0, A1 arg1) {
        return __builtin_va_start ( arg0 , arg1 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_va_start_mixin); })) {
        mixin(_dpp_impl_va_start_mixin);
    }
    static if(!is(typeof(ULONG_LONG_MAX))) {
        private enum enumMixinStr_ULONG_LONG_MAX = `enum ULONG_LONG_MAX = ( 9223372036854775807LL * 2LU + 1LU );`;
        static if(is(typeof({ mixin(enumMixinStr_ULONG_LONG_MAX); }))) {
            mixin(enumMixinStr_ULONG_LONG_MAX);
        }
    }




    static if(!is(typeof(LONG_LONG_MIN))) {
        private enum enumMixinStr_LONG_LONG_MIN = `enum LONG_LONG_MIN = ( - 9223372036854775807LL - 1L );`;
        static if(is(typeof({ mixin(enumMixinStr_LONG_LONG_MIN); }))) {
            mixin(enumMixinStr_LONG_LONG_MIN);
        }
    }




    static if(!is(typeof(atoll))) {
        private enum enumMixinStr_atoll = `enum atoll = _atoi64;`;
        static if(is(typeof({ mixin(enumMixinStr_atoll); }))) {
            mixin(enumMixinStr_atoll);
        }
    }




    static if(!is(typeof(LONG_LONG_MAX))) {
        private enum enumMixinStr_LONG_LONG_MAX = `enum LONG_LONG_MAX = 9223372036854775807LL;`;
        static if(is(typeof({ mixin(enumMixinStr_LONG_LONG_MAX); }))) {
            mixin(enumMixinStr_LONG_LONG_MAX);
        }
    }




    static if(!is(typeof(ULLONG_MAX))) {
        private enum enumMixinStr_ULLONG_MAX = `enum ULLONG_MAX = ( 9223372036854775807LL * 2LU + 1LU );`;
        static if(is(typeof({ mixin(enumMixinStr_ULLONG_MAX); }))) {
            mixin(enumMixinStr_ULLONG_MAX);
        }
    }




    static if(!is(typeof(LLONG_MIN))) {
        private enum enumMixinStr_LLONG_MIN = `enum LLONG_MIN = ( - 9223372036854775807LL - 1L );`;
        static if(is(typeof({ mixin(enumMixinStr_LLONG_MIN); }))) {
            mixin(enumMixinStr_LLONG_MIN);
        }
    }




    static if(!is(typeof(LLONG_MAX))) {
        private enum enumMixinStr_LLONG_MAX = `enum LLONG_MAX = 9223372036854775807LL;`;
        static if(is(typeof({ mixin(enumMixinStr_LLONG_MAX); }))) {
            mixin(enumMixinStr_LLONG_MAX);
        }
    }




    static if(!is(typeof(CHAR_MAX))) {
        private enum enumMixinStr_CHAR_MAX = `enum CHAR_MAX = 127;`;
        static if(is(typeof({ mixin(enumMixinStr_CHAR_MAX); }))) {
            mixin(enumMixinStr_CHAR_MAX);
        }
    }




    static if(!is(typeof(CHAR_MIN))) {
        private enum enumMixinStr_CHAR_MIN = `enum CHAR_MIN = SCHAR_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_CHAR_MIN); }))) {
            mixin(enumMixinStr_CHAR_MIN);
        }
    }




    static if(!is(typeof(CHAR_BIT))) {
        private enum enumMixinStr_CHAR_BIT = `enum CHAR_BIT = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_CHAR_BIT); }))) {
            mixin(enumMixinStr_CHAR_BIT);
        }
    }


    enum _dpp_impl_S_ISDIR_mixin = ` auto S_ISDIR(A0)(A0 arg0) {
        return ( ( arg0 ) & S_IFDIR );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_S_ISDIR_mixin); })) {
        mixin(_dpp_impl_S_ISDIR_mixin);
    }




    static if(!is(typeof(ULONG_MAX))) {
        private enum enumMixinStr_ULONG_MAX = `enum ULONG_MAX = ( 2147483647L * 2UL + 1UL );`;
        static if(is(typeof({ mixin(enumMixinStr_ULONG_MAX); }))) {
            mixin(enumMixinStr_ULONG_MAX);
        }
    }




    static if(!is(typeof(UINT_MAX))) {
        private enum enumMixinStr_UINT_MAX = `enum UINT_MAX = ( 2147483647 * 2U + 1U );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_MAX); }))) {
            mixin(enumMixinStr_UINT_MAX);
        }
    }




    static if(!is(typeof(USHRT_MAX))) {
        private enum enumMixinStr_USHRT_MAX = `enum USHRT_MAX = ( 32767 * 2 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_USHRT_MAX); }))) {
            mixin(enumMixinStr_USHRT_MAX);
        }
    }




    static if(!is(typeof(UCHAR_MAX))) {
        private enum enumMixinStr_UCHAR_MAX = `enum UCHAR_MAX = ( 127 * 2 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_UCHAR_MAX); }))) {
            mixin(enumMixinStr_UCHAR_MAX);
        }
    }




    static if(!is(typeof(LONG_MIN))) {
        private enum enumMixinStr_LONG_MIN = `enum LONG_MIN = ( - 2147483647L - 1L );`;
        static if(is(typeof({ mixin(enumMixinStr_LONG_MIN); }))) {
            mixin(enumMixinStr_LONG_MIN);
        }
    }




    static if(!is(typeof(inline))) {
        private enum enumMixinStr_inline = `enum inline = __inline;`;
        static if(is(typeof({ mixin(enumMixinStr_inline); }))) {
            mixin(enumMixinStr_inline);
        }
    }




    static if(!is(typeof(fz_forceinline))) {
        private enum enumMixinStr_fz_forceinline = `enum fz_forceinline = __forceinline;`;
        static if(is(typeof({ mixin(enumMixinStr_fz_forceinline); }))) {
            mixin(enumMixinStr_fz_forceinline);
        }
    }




    static if(!is(typeof(INT_MIN))) {
        private enum enumMixinStr_INT_MIN = `enum INT_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_MIN); }))) {
            mixin(enumMixinStr_INT_MIN);
        }
    }




    static if(!is(typeof(SHRT_MIN))) {
        private enum enumMixinStr_SHRT_MIN = `enum SHRT_MIN = ( - 32767 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_SHRT_MIN); }))) {
            mixin(enumMixinStr_SHRT_MIN);
        }
    }




    static if(!is(typeof(SCHAR_MIN))) {
        private enum enumMixinStr_SCHAR_MIN = `enum SCHAR_MIN = ( - 127 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_SCHAR_MIN); }))) {
            mixin(enumMixinStr_SCHAR_MIN);
        }
    }




    static if(!is(typeof(LONG_MAX))) {
        private enum enumMixinStr_LONG_MAX = `enum LONG_MAX = 2147483647L;`;
        static if(is(typeof({ mixin(enumMixinStr_LONG_MAX); }))) {
            mixin(enumMixinStr_LONG_MAX);
        }
    }




    static if(!is(typeof(FZ_RESTRICT))) {
        private enum enumMixinStr_FZ_RESTRICT = `enum FZ_RESTRICT = __restrict;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_RESTRICT); }))) {
            mixin(enumMixinStr_FZ_RESTRICT);
        }
    }




    static if(!is(typeof(INT_MAX))) {
        private enum enumMixinStr_INT_MAX = `enum INT_MAX = 2147483647;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_MAX); }))) {
            mixin(enumMixinStr_INT_MAX);
        }
    }




    static if(!is(typeof(FZ_NORETURN))) {
        private enum enumMixinStr_FZ_NORETURN = `enum FZ_NORETURN = __declspec ( noreturn );`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_NORETURN); }))) {
            mixin(enumMixinStr_FZ_NORETURN);
        }
    }




    enum _dpp_impl_FZ_PRINTFLIKE_mixin = ` auto FZ_PRINTFLIKE(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_FZ_PRINTFLIKE_mixin); })) {
        mixin(_dpp_impl_FZ_PRINTFLIKE_mixin);
    }




    static if(!is(typeof(FZ_MEMORY_BLOCK_ALIGN_MOD))) {
        private enum enumMixinStr_FZ_MEMORY_BLOCK_ALIGN_MOD = `enum FZ_MEMORY_BLOCK_ALIGN_MOD = ( void * ) .sizeof;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_MEMORY_BLOCK_ALIGN_MOD); }))) {
            mixin(enumMixinStr_FZ_MEMORY_BLOCK_ALIGN_MOD);
        }
    }




    static if(!is(typeof(SHRT_MAX))) {
        private enum enumMixinStr_SHRT_MAX = `enum SHRT_MAX = 32767;`;
        static if(is(typeof({ mixin(enumMixinStr_SHRT_MAX); }))) {
            mixin(enumMixinStr_SHRT_MAX);
        }
    }




    static if(!is(typeof(SCHAR_MAX))) {
        private enum enumMixinStr_SCHAR_MAX = `enum SCHAR_MAX = 127;`;
        static if(is(typeof({ mixin(enumMixinStr_SCHAR_MAX); }))) {
            mixin(enumMixinStr_SCHAR_MAX);
        }
    }
    static if(!is(typeof(FZ_POINTER_ALIGN_MOD))) {
        private enum enumMixinStr_FZ_POINTER_ALIGN_MOD = `enum FZ_POINTER_ALIGN_MOD = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_POINTER_ALIGN_MOD); }))) {
            mixin(enumMixinStr_FZ_POINTER_ALIGN_MOD);
        }
    }




    static if(!is(typeof(environ))) {
        private enum enumMixinStr_environ = `enum environ = _environ;`;
        static if(is(typeof({ mixin(enumMixinStr_environ); }))) {
            mixin(enumMixinStr_environ);
        }
    }




    static if(!is(typeof(sys_nerr))) {
        private enum enumMixinStr_sys_nerr = `enum sys_nerr = _sys_nerr;`;
        static if(is(typeof({ mixin(enumMixinStr_sys_nerr); }))) {
            mixin(enumMixinStr_sys_nerr);
        }
    }






    static if(!is(typeof(sys_errlist))) {
        private enum enumMixinStr_sys_errlist = `enum sys_errlist = _sys_errlist;`;
        static if(is(typeof({ mixin(enumMixinStr_sys_errlist); }))) {
            mixin(enumMixinStr_sys_errlist);
        }
    }


    enum _dpp_impl_min_mixin = ` auto min(A0, A1)(A0 arg0, A1 arg1) {
        return ( ( ( arg0 ) < ( arg1 ) ) ? ( arg0 ) : ( arg1 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_min_mixin); })) {
        mixin(_dpp_impl_min_mixin);
    }


    enum _dpp_impl_max_mixin = ` auto max(A0, A1)(A0 arg0, A1 arg1) {
        return ( ( ( arg0 ) > ( arg1 ) ) ? ( arg0 ) : ( arg1 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_max_mixin); })) {
        mixin(_dpp_impl_max_mixin);
    }




    static if(!is(typeof(_MAX_ENV))) {
        private enum enumMixinStr__MAX_ENV = `enum _MAX_ENV = 32767;`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_ENV); }))) {
            mixin(enumMixinStr__MAX_ENV);
        }
    }




    static if(!is(typeof(_wenviron))) {
        private enum enumMixinStr__wenviron = `enum _wenviron = ( * __p__wenviron ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr__wenviron); }))) {
            mixin(enumMixinStr__wenviron);
        }
    }




    static if(!is(typeof(_environ))) {
        private enum enumMixinStr__environ = `enum _environ = ( * __p__environ ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr__environ); }))) {
            mixin(enumMixinStr__environ);
        }
    }




    enum _dpp_impl_FZ_LANG_TAG2_mixin = ` auto FZ_LANG_TAG2(A0, A1)(A0 arg0, A1 arg1) {
        return ( ( arg0 - 'a' + 1 ) + ( ( arg1 - 'a' + 1 ) * 27 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_FZ_LANG_TAG2_mixin); })) {
        mixin(_dpp_impl_FZ_LANG_TAG2_mixin);
    }


    enum _dpp_impl_FZ_LANG_TAG3_mixin = ` auto FZ_LANG_TAG3(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ( ( arg0 - 'a' + 1 ) + ( ( arg1 - 'a' + 1 ) * 27 ) + ( ( arg2 - 'a' + 1 ) * 27 * 27 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_FZ_LANG_TAG3_mixin); })) {
        mixin(_dpp_impl_FZ_LANG_TAG3_mixin);
    }




    static if(!is(typeof(__wargv))) {
        private enum enumMixinStr___wargv = `enum __wargv = ( * __p___wargv ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr___wargv); }))) {
            mixin(enumMixinStr___wargv);
        }
    }




    static if(!is(typeof(__argv))) {
        private enum enumMixinStr___argv = `enum __argv = ( * __p___argv ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr___argv); }))) {
            mixin(enumMixinStr___argv);
        }
    }




    static if(!is(typeof(__argc))) {
        private enum enumMixinStr___argc = `enum __argc = ( * __p___argc ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr___argc); }))) {
            mixin(enumMixinStr___argc);
        }
    }




    static if(!is(typeof(_MAX_EXT))) {
        private enum enumMixinStr__MAX_EXT = `enum _MAX_EXT = 256;`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_EXT); }))) {
            mixin(enumMixinStr__MAX_EXT);
        }
    }




    static if(!is(typeof(_MAX_FNAME))) {
        private enum enumMixinStr__MAX_FNAME = `enum _MAX_FNAME = 256;`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_FNAME); }))) {
            mixin(enumMixinStr__MAX_FNAME);
        }
    }




    static if(!is(typeof(_MAX_DIR))) {
        private enum enumMixinStr__MAX_DIR = `enum _MAX_DIR = 256;`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_DIR); }))) {
            mixin(enumMixinStr__MAX_DIR);
        }
    }




    static if(!is(typeof(_MAX_DRIVE))) {
        private enum enumMixinStr__MAX_DRIVE = `enum _MAX_DRIVE = 3;`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_DRIVE); }))) {
            mixin(enumMixinStr__MAX_DRIVE);
        }
    }




    static if(!is(typeof(_MAX_PATH))) {
        private enum enumMixinStr__MAX_PATH = `enum _MAX_PATH = 260;`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_PATH); }))) {
            mixin(enumMixinStr__MAX_PATH);
        }
    }




    static if(!is(typeof(__mb_cur_max))) {
        private enum enumMixinStr___mb_cur_max = `enum __mb_cur_max = ( ___mb_cur_max_func ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr___mb_cur_max); }))) {
            mixin(enumMixinStr___mb_cur_max);
        }
    }




    static if(!is(typeof(MB_CUR_MAX))) {
        private enum enumMixinStr_MB_CUR_MAX = `enum MB_CUR_MAX = ___mb_cur_max_func ( );`;
        static if(is(typeof({ mixin(enumMixinStr_MB_CUR_MAX); }))) {
            mixin(enumMixinStr_MB_CUR_MAX);
        }
    }




    static if(!is(typeof(_CVTBUFSIZE))) {
        private enum enumMixinStr__CVTBUFSIZE = `enum _CVTBUFSIZE = ( 309 + 40 );`;
        static if(is(typeof({ mixin(enumMixinStr__CVTBUFSIZE); }))) {
            mixin(enumMixinStr__CVTBUFSIZE);
        }
    }


    enum _dpp_impl__PTR_LD_mixin = ` auto _PTR_LD(A0)(A0 arg0) {
        return ( cast( ubyte * ) ( & ( arg0 ) . ld ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__PTR_LD_mixin); })) {
        mixin(_dpp_impl__PTR_LD_mixin);
    }






    static if(!is(typeof(RAND_MAX))) {
        private enum enumMixinStr_RAND_MAX = `enum RAND_MAX = 0x7fff;`;
        static if(is(typeof({ mixin(enumMixinStr_RAND_MAX); }))) {
            mixin(enumMixinStr_RAND_MAX);
        }
    }




    static if(!is(typeof(_fmode))) {
        private enum enumMixinStr__fmode = `enum _fmode = ( * __p__fmode ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr__fmode); }))) {
            mixin(enumMixinStr__fmode);
        }
    }




    static if(!is(typeof(_wpgmptr))) {
        private enum enumMixinStr__wpgmptr = `enum _wpgmptr = ( * __p__wpgmptr ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr__wpgmptr); }))) {
            mixin(enumMixinStr__wpgmptr);
        }
    }




    static if(!is(typeof(_pgmptr))) {
        private enum enumMixinStr__pgmptr = `enum _pgmptr = ( * __p__pgmptr ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr__pgmptr); }))) {
            mixin(enumMixinStr__pgmptr);
        }
    }




    static if(!is(typeof(_sys_nerr))) {
        private enum enumMixinStr__sys_nerr = `enum _sys_nerr = ( * __sys_nerr ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr__sys_nerr); }))) {
            mixin(enumMixinStr__sys_nerr);
        }
    }




    static if(!is(typeof(_sys_errlist))) {
        private enum enumMixinStr__sys_errlist = `enum _sys_errlist = ( __sys_errlist ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr__sys_errlist); }))) {
            mixin(enumMixinStr__sys_errlist);
        }
    }




    static if(!is(typeof(_doserrno))) {
        private enum enumMixinStr__doserrno = `enum _doserrno = ( * __doserrno ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr__doserrno); }))) {
            mixin(enumMixinStr__doserrno);
        }
    }




    static if(!is(typeof(errno))) {
        private enum enumMixinStr_errno = `enum errno = ( * _errno ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr_errno); }))) {
            mixin(enumMixinStr_errno);
        }
    }




    static if(!is(typeof(_REPORT_ERRMODE))) {
        private enum enumMixinStr__REPORT_ERRMODE = `enum _REPORT_ERRMODE = 3;`;
        static if(is(typeof({ mixin(enumMixinStr__REPORT_ERRMODE); }))) {
            mixin(enumMixinStr__REPORT_ERRMODE);
        }
    }




    enum _dpp_impl_TRACK_LABEL_mixin = ` auto TRACK_LABEL(A0)(A0 arg0) {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_TRACK_LABEL_mixin); })) {
        mixin(_dpp_impl_TRACK_LABEL_mixin);
    }


    enum _dpp_impl_TRACK_FN_mixin = ` auto TRACK_FN()() {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_TRACK_FN_mixin); })) {
        mixin(_dpp_impl_TRACK_FN_mixin);
    }






    static if(!is(typeof(_OUT_TO_MSGBOX))) {
        private enum enumMixinStr__OUT_TO_MSGBOX = `enum _OUT_TO_MSGBOX = 2;`;
        static if(is(typeof({ mixin(enumMixinStr__OUT_TO_MSGBOX); }))) {
            mixin(enumMixinStr__OUT_TO_MSGBOX);
        }
    }




    static if(!is(typeof(_OUT_TO_STDERR))) {
        private enum enumMixinStr__OUT_TO_STDERR = `enum _OUT_TO_STDERR = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__OUT_TO_STDERR); }))) {
            mixin(enumMixinStr__OUT_TO_STDERR);
        }
    }




    static if(!is(typeof(_OUT_TO_DEFAULT))) {
        private enum enumMixinStr__OUT_TO_DEFAULT = `enum _OUT_TO_DEFAULT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__OUT_TO_DEFAULT); }))) {
            mixin(enumMixinStr__OUT_TO_DEFAULT);
        }
    }




    static if(!is(typeof(onexit_t))) {
        private enum enumMixinStr_onexit_t = `enum onexit_t = _onexit_t;`;
        static if(is(typeof({ mixin(enumMixinStr_onexit_t); }))) {
            mixin(enumMixinStr_onexit_t);
        }
    }






    static if(!is(typeof(_CALL_REPORTFAULT))) {
        private enum enumMixinStr__CALL_REPORTFAULT = `enum _CALL_REPORTFAULT = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr__CALL_REPORTFAULT); }))) {
            mixin(enumMixinStr__CALL_REPORTFAULT);
        }
    }






    static if(!is(typeof(_WRITE_ABORT_MSG))) {
        private enum enumMixinStr__WRITE_ABORT_MSG = `enum _WRITE_ABORT_MSG = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr__WRITE_ABORT_MSG); }))) {
            mixin(enumMixinStr__WRITE_ABORT_MSG);
        }
    }




    static if(!is(typeof(EXIT_FAILURE))) {
        private enum enumMixinStr_EXIT_FAILURE = `enum EXIT_FAILURE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_EXIT_FAILURE); }))) {
            mixin(enumMixinStr_EXIT_FAILURE);
        }
    }




    static if(!is(typeof(EXIT_SUCCESS))) {
        private enum enumMixinStr_EXIT_SUCCESS = `enum EXIT_SUCCESS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_EXIT_SUCCESS); }))) {
            mixin(enumMixinStr_EXIT_SUCCESS);
        }
    }
    static if(!is(typeof(_countof))) {
        private enum enumMixinStr__countof = `enum _countof = __crt_countof;`;
        static if(is(typeof({ mixin(enumMixinStr__countof); }))) {
            mixin(enumMixinStr__countof);
        }
    }
    static if(!is(typeof(SYS_OPEN))) {
        private enum enumMixinStr_SYS_OPEN = `enum SYS_OPEN = _SYS_OPEN;`;
        static if(is(typeof({ mixin(enumMixinStr_SYS_OPEN); }))) {
            mixin(enumMixinStr_SYS_OPEN);
        }
    }




    static if(!is(typeof(_commode))) {
        private enum enumMixinStr__commode = `enum _commode = ( * __p__commode ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr__commode); }))) {
            mixin(enumMixinStr__commode);
        }
    }


    enum _dpp_impl__putwchar_nolock_mixin = ` auto _putwchar_nolock(A0)(A0 arg0) {
        return _putwc_nolock ( arg0 , stdout );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__putwchar_nolock_mixin); })) {
        mixin(_dpp_impl__putwchar_nolock_mixin);
    }


    enum _dpp_impl__getwchar_nolock_mixin = ` auto _getwchar_nolock()() {
        return _getwc_nolock ( stdin );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__getwchar_nolock_mixin); })) {
        mixin(_dpp_impl__getwchar_nolock_mixin);
    }




    enum _dpp_impl__putchar_nolock_mixin = ` auto _putchar_nolock(A0)(A0 arg0) {
        return _putc_nolock ( arg0 , stdout );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__putchar_nolock_mixin); })) {
        mixin(_dpp_impl__putchar_nolock_mixin);
    }


    enum _dpp_impl__getchar_nolock_mixin = ` auto _getchar_nolock()() {
        return _getc_nolock ( stdin );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__getchar_nolock_mixin); })) {
        mixin(_dpp_impl__getchar_nolock_mixin);
    }




    static if(!is(typeof(_TMP_MAX_S))) {
        private enum enumMixinStr__TMP_MAX_S = `enum _TMP_MAX_S = TMP_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__TMP_MAX_S); }))) {
            mixin(enumMixinStr__TMP_MAX_S);
        }
    }




    static if(!is(typeof(TMP_MAX_S))) {
        private enum enumMixinStr_TMP_MAX_S = `enum TMP_MAX_S = TMP_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_TMP_MAX_S); }))) {
            mixin(enumMixinStr_TMP_MAX_S);
        }
    }




    static if(!is(typeof(TMP_MAX))) {
        private enum enumMixinStr_TMP_MAX = `enum TMP_MAX = _CRT_INT_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_TMP_MAX); }))) {
            mixin(enumMixinStr_TMP_MAX);
        }
    }




    static if(!is(typeof(_SYS_OPEN))) {
        private enum enumMixinStr__SYS_OPEN = `enum _SYS_OPEN = 20;`;
        static if(is(typeof({ mixin(enumMixinStr__SYS_OPEN); }))) {
            mixin(enumMixinStr__SYS_OPEN);
        }
    }




    static if(!is(typeof(FOPEN_MAX))) {
        private enum enumMixinStr_FOPEN_MAX = `enum FOPEN_MAX = 20;`;
        static if(is(typeof({ mixin(enumMixinStr_FOPEN_MAX); }))) {
            mixin(enumMixinStr_FOPEN_MAX);
        }
    }




    static if(!is(typeof(FILENAME_MAX))) {
        private enum enumMixinStr_FILENAME_MAX = `enum FILENAME_MAX = 260;`;
        static if(is(typeof({ mixin(enumMixinStr_FILENAME_MAX); }))) {
            mixin(enumMixinStr_FILENAME_MAX);
        }
    }




    static if(!is(typeof(SEEK_SET))) {
        private enum enumMixinStr_SEEK_SET = `enum SEEK_SET = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_SEEK_SET); }))) {
            mixin(enumMixinStr_SEEK_SET);
        }
    }




    static if(!is(typeof(SEEK_END))) {
        private enum enumMixinStr_SEEK_END = `enum SEEK_END = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_SEEK_END); }))) {
            mixin(enumMixinStr_SEEK_END);
        }
    }




    static if(!is(typeof(SEEK_CUR))) {
        private enum enumMixinStr_SEEK_CUR = `enum SEEK_CUR = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_SEEK_CUR); }))) {
            mixin(enumMixinStr_SEEK_CUR);
        }
    }




    static if(!is(typeof(L_tmpnam_s))) {
        private enum enumMixinStr_L_tmpnam_s = `enum L_tmpnam_s = L_tmpnam;`;
        static if(is(typeof({ mixin(enumMixinStr_L_tmpnam_s); }))) {
            mixin(enumMixinStr_L_tmpnam_s);
        }
    }




    static if(!is(typeof(L_tmpnam))) {
        private enum enumMixinStr_L_tmpnam = `enum L_tmpnam = 260;`;
        static if(is(typeof({ mixin(enumMixinStr_L_tmpnam); }))) {
            mixin(enumMixinStr_L_tmpnam);
        }
    }




    static if(!is(typeof(_IONBF))) {
        private enum enumMixinStr__IONBF = `enum _IONBF = 0x0004;`;
        static if(is(typeof({ mixin(enumMixinStr__IONBF); }))) {
            mixin(enumMixinStr__IONBF);
        }
    }




    static if(!is(typeof(_IOLBF))) {
        private enum enumMixinStr__IOLBF = `enum _IOLBF = 0x0040;`;
        static if(is(typeof({ mixin(enumMixinStr__IOLBF); }))) {
            mixin(enumMixinStr__IOLBF);
        }
    }




    static if(!is(typeof(_IOFBF))) {
        private enum enumMixinStr__IOFBF = `enum _IOFBF = 0x0000;`;
        static if(is(typeof({ mixin(enumMixinStr__IOFBF); }))) {
            mixin(enumMixinStr__IOFBF);
        }
    }




    static if(!is(typeof(EOF))) {
        private enum enumMixinStr_EOF = `enum EOF = ( - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_EOF); }))) {
            mixin(enumMixinStr_EOF);
        }
    }




    static if(!is(typeof(_IOB_ENTRIES))) {
        private enum enumMixinStr__IOB_ENTRIES = `enum _IOB_ENTRIES = 3;`;
        static if(is(typeof({ mixin(enumMixinStr__IOB_ENTRIES); }))) {
            mixin(enumMixinStr__IOB_ENTRIES);
        }
    }




    static if(!is(typeof(_NSTREAM_))) {
        private enum enumMixinStr__NSTREAM_ = `enum _NSTREAM_ = 512;`;
        static if(is(typeof({ mixin(enumMixinStr__NSTREAM_); }))) {
            mixin(enumMixinStr__NSTREAM_);
        }
    }




    static if(!is(typeof(_NFILE))) {
        private enum enumMixinStr__NFILE = `enum _NFILE = 512;`;
        static if(is(typeof({ mixin(enumMixinStr__NFILE); }))) {
            mixin(enumMixinStr__NFILE);
        }
    }




    static if(!is(typeof(BUFSIZ))) {
        private enum enumMixinStr_BUFSIZ = `enum BUFSIZ = 512;`;
        static if(is(typeof({ mixin(enumMixinStr_BUFSIZ); }))) {
            mixin(enumMixinStr_BUFSIZ);
        }
    }






    static if(!is(typeof(_MAX_U64TOSTR_BASE2_COUNT))) {
        private enum enumMixinStr__MAX_U64TOSTR_BASE2_COUNT = `enum _MAX_U64TOSTR_BASE2_COUNT = ( 64 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_U64TOSTR_BASE2_COUNT); }))) {
            mixin(enumMixinStr__MAX_U64TOSTR_BASE2_COUNT);
        }
    }




    static if(!is(typeof(_MAX_U64TOSTR_BASE8_COUNT))) {
        private enum enumMixinStr__MAX_U64TOSTR_BASE8_COUNT = `enum _MAX_U64TOSTR_BASE8_COUNT = ( 22 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_U64TOSTR_BASE8_COUNT); }))) {
            mixin(enumMixinStr__MAX_U64TOSTR_BASE8_COUNT);
        }
    }




    static if(!is(typeof(_MAX_U64TOSTR_BASE10_COUNT))) {
        private enum enumMixinStr__MAX_U64TOSTR_BASE10_COUNT = `enum _MAX_U64TOSTR_BASE10_COUNT = ( 20 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_U64TOSTR_BASE10_COUNT); }))) {
            mixin(enumMixinStr__MAX_U64TOSTR_BASE10_COUNT);
        }
    }




    static if(!is(typeof(_MAX_U64TOSTR_BASE16_COUNT))) {
        private enum enumMixinStr__MAX_U64TOSTR_BASE16_COUNT = `enum _MAX_U64TOSTR_BASE16_COUNT = ( 16 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_U64TOSTR_BASE16_COUNT); }))) {
            mixin(enumMixinStr__MAX_U64TOSTR_BASE16_COUNT);
        }
    }




    static if(!is(typeof(_MAX_I64TOSTR_BASE2_COUNT))) {
        private enum enumMixinStr__MAX_I64TOSTR_BASE2_COUNT = `enum _MAX_I64TOSTR_BASE2_COUNT = ( 64 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_I64TOSTR_BASE2_COUNT); }))) {
            mixin(enumMixinStr__MAX_I64TOSTR_BASE2_COUNT);
        }
    }




    static if(!is(typeof(_MAX_I64TOSTR_BASE8_COUNT))) {
        private enum enumMixinStr__MAX_I64TOSTR_BASE8_COUNT = `enum _MAX_I64TOSTR_BASE8_COUNT = ( 22 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_I64TOSTR_BASE8_COUNT); }))) {
            mixin(enumMixinStr__MAX_I64TOSTR_BASE8_COUNT);
        }
    }




    static if(!is(typeof(_MAX_I64TOSTR_BASE10_COUNT))) {
        private enum enumMixinStr__MAX_I64TOSTR_BASE10_COUNT = `enum _MAX_I64TOSTR_BASE10_COUNT = ( 1 + 19 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_I64TOSTR_BASE10_COUNT); }))) {
            mixin(enumMixinStr__MAX_I64TOSTR_BASE10_COUNT);
        }
    }




    static if(!is(typeof(_MAX_I64TOSTR_BASE16_COUNT))) {
        private enum enumMixinStr__MAX_I64TOSTR_BASE16_COUNT = `enum _MAX_I64TOSTR_BASE16_COUNT = ( 16 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_I64TOSTR_BASE16_COUNT); }))) {
            mixin(enumMixinStr__MAX_I64TOSTR_BASE16_COUNT);
        }
    }




    static if(!is(typeof(_MAX_ULTOSTR_BASE2_COUNT))) {
        private enum enumMixinStr__MAX_ULTOSTR_BASE2_COUNT = `enum _MAX_ULTOSTR_BASE2_COUNT = ( 32 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_ULTOSTR_BASE2_COUNT); }))) {
            mixin(enumMixinStr__MAX_ULTOSTR_BASE2_COUNT);
        }
    }




    static if(!is(typeof(_MAX_ULTOSTR_BASE8_COUNT))) {
        private enum enumMixinStr__MAX_ULTOSTR_BASE8_COUNT = `enum _MAX_ULTOSTR_BASE8_COUNT = ( 11 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_ULTOSTR_BASE8_COUNT); }))) {
            mixin(enumMixinStr__MAX_ULTOSTR_BASE8_COUNT);
        }
    }




    static if(!is(typeof(_MAX_ULTOSTR_BASE10_COUNT))) {
        private enum enumMixinStr__MAX_ULTOSTR_BASE10_COUNT = `enum _MAX_ULTOSTR_BASE10_COUNT = ( 10 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_ULTOSTR_BASE10_COUNT); }))) {
            mixin(enumMixinStr__MAX_ULTOSTR_BASE10_COUNT);
        }
    }




    static if(!is(typeof(_MAX_ULTOSTR_BASE16_COUNT))) {
        private enum enumMixinStr__MAX_ULTOSTR_BASE16_COUNT = `enum _MAX_ULTOSTR_BASE16_COUNT = ( 8 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_ULTOSTR_BASE16_COUNT); }))) {
            mixin(enumMixinStr__MAX_ULTOSTR_BASE16_COUNT);
        }
    }




    static if(!is(typeof(_MAX_LTOSTR_BASE2_COUNT))) {
        private enum enumMixinStr__MAX_LTOSTR_BASE2_COUNT = `enum _MAX_LTOSTR_BASE2_COUNT = ( 32 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_LTOSTR_BASE2_COUNT); }))) {
            mixin(enumMixinStr__MAX_LTOSTR_BASE2_COUNT);
        }
    }




    static if(!is(typeof(_MAX_LTOSTR_BASE8_COUNT))) {
        private enum enumMixinStr__MAX_LTOSTR_BASE8_COUNT = `enum _MAX_LTOSTR_BASE8_COUNT = ( 11 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_LTOSTR_BASE8_COUNT); }))) {
            mixin(enumMixinStr__MAX_LTOSTR_BASE8_COUNT);
        }
    }




    static if(!is(typeof(_MAX_LTOSTR_BASE10_COUNT))) {
        private enum enumMixinStr__MAX_LTOSTR_BASE10_COUNT = `enum _MAX_LTOSTR_BASE10_COUNT = ( 1 + 10 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_LTOSTR_BASE10_COUNT); }))) {
            mixin(enumMixinStr__MAX_LTOSTR_BASE10_COUNT);
        }
    }




    static if(!is(typeof(_MAX_LTOSTR_BASE16_COUNT))) {
        private enum enumMixinStr__MAX_LTOSTR_BASE16_COUNT = `enum _MAX_LTOSTR_BASE16_COUNT = ( 8 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_LTOSTR_BASE16_COUNT); }))) {
            mixin(enumMixinStr__MAX_LTOSTR_BASE16_COUNT);
        }
    }




    static if(!is(typeof(_MAX_ITOSTR_BASE2_COUNT))) {
        private enum enumMixinStr__MAX_ITOSTR_BASE2_COUNT = `enum _MAX_ITOSTR_BASE2_COUNT = ( 32 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_ITOSTR_BASE2_COUNT); }))) {
            mixin(enumMixinStr__MAX_ITOSTR_BASE2_COUNT);
        }
    }




    static if(!is(typeof(_MAX_ITOSTR_BASE8_COUNT))) {
        private enum enumMixinStr__MAX_ITOSTR_BASE8_COUNT = `enum _MAX_ITOSTR_BASE8_COUNT = ( 11 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_ITOSTR_BASE8_COUNT); }))) {
            mixin(enumMixinStr__MAX_ITOSTR_BASE8_COUNT);
        }
    }




    static if(!is(typeof(_MAX_ITOSTR_BASE10_COUNT))) {
        private enum enumMixinStr__MAX_ITOSTR_BASE10_COUNT = `enum _MAX_ITOSTR_BASE10_COUNT = ( 1 + 10 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_ITOSTR_BASE10_COUNT); }))) {
            mixin(enumMixinStr__MAX_ITOSTR_BASE10_COUNT);
        }
    }




    static if(!is(typeof(_MAX_ITOSTR_BASE16_COUNT))) {
        private enum enumMixinStr__MAX_ITOSTR_BASE16_COUNT = `enum _MAX_ITOSTR_BASE16_COUNT = ( 8 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__MAX_ITOSTR_BASE16_COUNT); }))) {
            mixin(enumMixinStr__MAX_ITOSTR_BASE16_COUNT);
        }
    }




    static if(!is(typeof(_SWPRINTFS_DEPRECATED))) {
        private enum enumMixinStr__SWPRINTFS_DEPRECATED = `enum _SWPRINTFS_DEPRECATED = _CRT_DEPRECATE_TEXT ( "function has been changed to conform with the ISO C standard, " "adding an extra character count parameter. To use the traditional " "Microsoft version, set _CRT_NON_CONFORMING_SWPRINTFS." );`;
        static if(is(typeof({ mixin(enumMixinStr__SWPRINTFS_DEPRECATED); }))) {
            mixin(enumMixinStr__SWPRINTFS_DEPRECATED);
        }
    }






    static if(!is(typeof(FZ_VERSION))) {
        private enum enumMixinStr_FZ_VERSION = `enum FZ_VERSION = "1.21.1";`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_VERSION); }))) {
            mixin(enumMixinStr_FZ_VERSION);
        }
    }




    static if(!is(typeof(FZ_VERSION_MAJOR))) {
        private enum enumMixinStr_FZ_VERSION_MAJOR = `enum FZ_VERSION_MAJOR = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_VERSION_MAJOR); }))) {
            mixin(enumMixinStr_FZ_VERSION_MAJOR);
        }
    }




    static if(!is(typeof(FZ_VERSION_MINOR))) {
        private enum enumMixinStr_FZ_VERSION_MINOR = `enum FZ_VERSION_MINOR = 21;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_VERSION_MINOR); }))) {
            mixin(enumMixinStr_FZ_VERSION_MINOR);
        }
    }




    static if(!is(typeof(FZ_VERSION_PATCH))) {
        private enum enumMixinStr_FZ_VERSION_PATCH = `enum FZ_VERSION_PATCH = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FZ_VERSION_PATCH); }))) {
            mixin(enumMixinStr_FZ_VERSION_PATCH);
        }
    }






    static if(!is(typeof(WEOF))) {
        private enum enumMixinStr_WEOF = `enum WEOF = ( cast( wint_t ) ( 0xFFFF ) );`;
        static if(is(typeof({ mixin(enumMixinStr_WEOF); }))) {
            mixin(enumMixinStr_WEOF);
        }
    }




    static if(!is(typeof(stderr))) {
        private enum enumMixinStr_stderr = `enum stderr = ( __acrt_iob_func ( 2 ) );`;
        static if(is(typeof({ mixin(enumMixinStr_stderr); }))) {
            mixin(enumMixinStr_stderr);
        }
    }




    static if(!is(typeof(stdout))) {
        private enum enumMixinStr_stdout = `enum stdout = ( __acrt_iob_func ( 1 ) );`;
        static if(is(typeof({ mixin(enumMixinStr_stdout); }))) {
            mixin(enumMixinStr_stdout);
        }
    }




    static if(!is(typeof(stdin))) {
        private enum enumMixinStr_stdin = `enum stdin = ( __acrt_iob_func ( 0 ) );`;
        static if(is(typeof({ mixin(enumMixinStr_stdin); }))) {
            mixin(enumMixinStr_stdin);
        }
    }






    static if(!is(typeof(_CRT_INTERNAL_SCANF_LEGACY_MSVCRT_COMPATIBILITY))) {
        private enum enumMixinStr__CRT_INTERNAL_SCANF_LEGACY_MSVCRT_COMPATIBILITY = `enum _CRT_INTERNAL_SCANF_LEGACY_MSVCRT_COMPATIBILITY = ( 1LU << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INTERNAL_SCANF_LEGACY_MSVCRT_COMPATIBILITY); }))) {
            mixin(enumMixinStr__CRT_INTERNAL_SCANF_LEGACY_MSVCRT_COMPATIBILITY);
        }
    }




    static if(!is(typeof(_CRT_INTERNAL_SCANF_LEGACY_WIDE_SPECIFIERS))) {
        private enum enumMixinStr__CRT_INTERNAL_SCANF_LEGACY_WIDE_SPECIFIERS = `enum _CRT_INTERNAL_SCANF_LEGACY_WIDE_SPECIFIERS = ( 1LU << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INTERNAL_SCANF_LEGACY_WIDE_SPECIFIERS); }))) {
            mixin(enumMixinStr__CRT_INTERNAL_SCANF_LEGACY_WIDE_SPECIFIERS);
        }
    }




    static if(!is(typeof(_CRT_INTERNAL_SCANF_SECURECRT))) {
        private enum enumMixinStr__CRT_INTERNAL_SCANF_SECURECRT = `enum _CRT_INTERNAL_SCANF_SECURECRT = ( 1LU << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INTERNAL_SCANF_SECURECRT); }))) {
            mixin(enumMixinStr__CRT_INTERNAL_SCANF_SECURECRT);
        }
    }




    static if(!is(typeof(_CRT_INTERNAL_PRINTF_STANDARD_ROUNDING))) {
        private enum enumMixinStr__CRT_INTERNAL_PRINTF_STANDARD_ROUNDING = `enum _CRT_INTERNAL_PRINTF_STANDARD_ROUNDING = ( 1LU << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INTERNAL_PRINTF_STANDARD_ROUNDING); }))) {
            mixin(enumMixinStr__CRT_INTERNAL_PRINTF_STANDARD_ROUNDING);
        }
    }




    static if(!is(typeof(_CRT_INTERNAL_PRINTF_LEGACY_THREE_DIGIT_EXPONENTS))) {
        private enum enumMixinStr__CRT_INTERNAL_PRINTF_LEGACY_THREE_DIGIT_EXPONENTS = `enum _CRT_INTERNAL_PRINTF_LEGACY_THREE_DIGIT_EXPONENTS = ( 1LU << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INTERNAL_PRINTF_LEGACY_THREE_DIGIT_EXPONENTS); }))) {
            mixin(enumMixinStr__CRT_INTERNAL_PRINTF_LEGACY_THREE_DIGIT_EXPONENTS);
        }
    }




    static if(!is(typeof(_CRT_INTERNAL_PRINTF_LEGACY_MSVCRT_COMPATIBILITY))) {
        private enum enumMixinStr__CRT_INTERNAL_PRINTF_LEGACY_MSVCRT_COMPATIBILITY = `enum _CRT_INTERNAL_PRINTF_LEGACY_MSVCRT_COMPATIBILITY = ( 1LU << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INTERNAL_PRINTF_LEGACY_MSVCRT_COMPATIBILITY); }))) {
            mixin(enumMixinStr__CRT_INTERNAL_PRINTF_LEGACY_MSVCRT_COMPATIBILITY);
        }
    }




    static if(!is(typeof(_CRT_INTERNAL_PRINTF_LEGACY_WIDE_SPECIFIERS))) {
        private enum enumMixinStr__CRT_INTERNAL_PRINTF_LEGACY_WIDE_SPECIFIERS = `enum _CRT_INTERNAL_PRINTF_LEGACY_WIDE_SPECIFIERS = ( 1LU << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INTERNAL_PRINTF_LEGACY_WIDE_SPECIFIERS); }))) {
            mixin(enumMixinStr__CRT_INTERNAL_PRINTF_LEGACY_WIDE_SPECIFIERS);
        }
    }




    static if(!is(typeof(_CRT_INTERNAL_PRINTF_STANDARD_SNPRINTF_BEHAVIOR))) {
        private enum enumMixinStr__CRT_INTERNAL_PRINTF_STANDARD_SNPRINTF_BEHAVIOR = `enum _CRT_INTERNAL_PRINTF_STANDARD_SNPRINTF_BEHAVIOR = ( 1LU << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INTERNAL_PRINTF_STANDARD_SNPRINTF_BEHAVIOR); }))) {
            mixin(enumMixinStr__CRT_INTERNAL_PRINTF_STANDARD_SNPRINTF_BEHAVIOR);
        }
    }




    static if(!is(typeof(_CRT_INTERNAL_PRINTF_LEGACY_VSPRINTF_NULL_TERMINATION))) {
        private enum enumMixinStr__CRT_INTERNAL_PRINTF_LEGACY_VSPRINTF_NULL_TERMINATION = `enum _CRT_INTERNAL_PRINTF_LEGACY_VSPRINTF_NULL_TERMINATION = ( 1LU << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INTERNAL_PRINTF_LEGACY_VSPRINTF_NULL_TERMINATION); }))) {
            mixin(enumMixinStr__CRT_INTERNAL_PRINTF_LEGACY_VSPRINTF_NULL_TERMINATION);
        }
    }




    static if(!is(typeof(_CRT_INTERNAL_LOCAL_SCANF_OPTIONS))) {
        private enum enumMixinStr__CRT_INTERNAL_LOCAL_SCANF_OPTIONS = `enum _CRT_INTERNAL_LOCAL_SCANF_OPTIONS = ( * __local_stdio_scanf_options ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INTERNAL_LOCAL_SCANF_OPTIONS); }))) {
            mixin(enumMixinStr__CRT_INTERNAL_LOCAL_SCANF_OPTIONS);
        }
    }




    static if(!is(typeof(_CRT_INTERNAL_LOCAL_PRINTF_OPTIONS))) {
        private enum enumMixinStr__CRT_INTERNAL_LOCAL_PRINTF_OPTIONS = `enum _CRT_INTERNAL_LOCAL_PRINTF_OPTIONS = ( * __local_stdio_printf_options ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INTERNAL_LOCAL_PRINTF_OPTIONS); }))) {
            mixin(enumMixinStr__CRT_INTERNAL_LOCAL_PRINTF_OPTIONS);
        }
    }




    static if(!is(typeof(_CRT_INTERNAL_STDIO_SYMBOL_PREFIX))) {
        private enum enumMixinStr__CRT_INTERNAL_STDIO_SYMBOL_PREFIX = `enum _CRT_INTERNAL_STDIO_SYMBOL_PREFIX = "";`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INTERNAL_STDIO_SYMBOL_PREFIX); }))) {
            mixin(enumMixinStr__CRT_INTERNAL_STDIO_SYMBOL_PREFIX);
        }
    }




    static if(!is(typeof(_CRT_STDIO_INLINE))) {
        private enum enumMixinStr__CRT_STDIO_INLINE = `enum _CRT_STDIO_INLINE = __inline;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_STDIO_INLINE); }))) {
            mixin(enumMixinStr__CRT_STDIO_INLINE);
        }
    }
    enum _dpp_impl_fz_new_derived_document_writer_mixin = ` auto fz_new_derived_document_writer(A0, A1, A2, A3, A4, A5)(A0 arg0, A1 arg1, A2 arg2, A3 arg3, A4 arg4, A5 arg5) {
        return ( cast( arg1 * ) Memento_label ( fz_new_document_writer_of_size ( arg0 , ( arg1 ) .sizeof , arg2 , arg3 , arg4 , arg5 ) , "arg1" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_fz_new_derived_document_writer_mixin); })) {
        mixin(_dpp_impl_fz_new_derived_document_writer_mixin);
    }
    static if(!is(typeof(_CRT_SECURE_CPP_NOTHROW))) {
        private enum enumMixinStr__CRT_SECURE_CPP_NOTHROW = `enum _CRT_SECURE_CPP_NOTHROW = throw ( );`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_SECURE_CPP_NOTHROW); }))) {
            mixin(enumMixinStr__CRT_SECURE_CPP_NOTHROW);
        }
    }




    static if(!is(typeof(_CRT_SECURE_CPP_OVERLOAD_SECURE_NAMES_MEMORY))) {
        private enum enumMixinStr__CRT_SECURE_CPP_OVERLOAD_SECURE_NAMES_MEMORY = `enum _CRT_SECURE_CPP_OVERLOAD_SECURE_NAMES_MEMORY = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_SECURE_CPP_OVERLOAD_SECURE_NAMES_MEMORY); }))) {
            mixin(enumMixinStr__CRT_SECURE_CPP_OVERLOAD_SECURE_NAMES_MEMORY);
        }
    }




    static if(!is(typeof(_CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES_MEMORY))) {
        private enum enumMixinStr__CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES_MEMORY = `enum _CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES_MEMORY = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES_MEMORY); }))) {
            mixin(enumMixinStr__CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES_MEMORY);
        }
    }




    static if(!is(typeof(_CRT_SECURE_CPP_OVERLOAD_SECURE_NAMES))) {
        private enum enumMixinStr__CRT_SECURE_CPP_OVERLOAD_SECURE_NAMES = `enum _CRT_SECURE_CPP_OVERLOAD_SECURE_NAMES = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_SECURE_CPP_OVERLOAD_SECURE_NAMES); }))) {
            mixin(enumMixinStr__CRT_SECURE_CPP_OVERLOAD_SECURE_NAMES);
        }
    }




    static if(!is(typeof(_CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES_COUNT))) {
        private enum enumMixinStr__CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES_COUNT = `enum _CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES_COUNT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES_COUNT); }))) {
            mixin(enumMixinStr__CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES_COUNT);
        }
    }




    static if(!is(typeof(_CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES))) {
        private enum enumMixinStr__CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES = `enum _CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES); }))) {
            mixin(enumMixinStr__CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES);
        }
    }


    enum _dpp_impl__CRT_OBSOLETE_mixin = ` auto _CRT_OBSOLETE(A0)(A0 arg0) {
        return _CRT_DEPRECATE_TEXT ( "This function or variable has been superceded by newer library " "or operating system functionality. Consider using " "arg0" " " "instead. See online help for details." );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_OBSOLETE_mixin); })) {
        mixin(_dpp_impl__CRT_OBSOLETE_mixin);
    }




    static if(!is(typeof(_SECURECRT_FILL_BUFFER_PATTERN))) {
        private enum enumMixinStr__SECURECRT_FILL_BUFFER_PATTERN = `enum _SECURECRT_FILL_BUFFER_PATTERN = 0xFE;`;
        static if(is(typeof({ mixin(enumMixinStr__SECURECRT_FILL_BUFFER_PATTERN); }))) {
            mixin(enumMixinStr__SECURECRT_FILL_BUFFER_PATTERN);
        }
    }


    enum _dpp_impl__CRT_INSECURE_DEPRECATE_GLOBALS_mixin = ` auto _CRT_INSECURE_DEPRECATE_GLOBALS(A0)(A0 arg0) {
        return _CRT_INSECURE_DEPRECATE ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_INSECURE_DEPRECATE_GLOBALS_mixin); })) {
        mixin(_dpp_impl__CRT_INSECURE_DEPRECATE_GLOBALS_mixin);
    }




    static if(!is(typeof(__GOT_SECURE_LIB__))) {
        private enum enumMixinStr___GOT_SECURE_LIB__ = `enum __GOT_SECURE_LIB__ = __STDC_SECURE_LIB__;`;
        static if(is(typeof({ mixin(enumMixinStr___GOT_SECURE_LIB__); }))) {
            mixin(enumMixinStr___GOT_SECURE_LIB__);
        }
    }






    enum _dpp_impl__CRT_NONSTDC_DEPRECATE_mixin = ` auto _CRT_NONSTDC_DEPRECATE(A0)(A0 arg0) {
        return _CRT_DEPRECATE_TEXT ( "The POSIX name for this item is deprecated. Instead, use the ISO C " "and C++ conformant name: " "arg0" ". See online help for details." );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_NONSTDC_DEPRECATE_mixin); })) {
        mixin(_dpp_impl__CRT_NONSTDC_DEPRECATE_mixin);
    }




    static if(!is(typeof(_CRT_INTERNAL_NONSTDC_NAMES))) {
        private enum enumMixinStr__CRT_INTERNAL_NONSTDC_NAMES = `enum _CRT_INTERNAL_NONSTDC_NAMES = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INTERNAL_NONSTDC_NAMES); }))) {
            mixin(enumMixinStr__CRT_INTERNAL_NONSTDC_NAMES);
        }
    }


    enum _dpp_impl__CRT_WARNING_MESSAGE_mixin = ` auto _CRT_WARNING_MESSAGE(A0, A1)(A0 arg0, A1 arg1) {
        return "generated/1.21.1/MSYS_NT-10.0-19044\\mupdf.d.tmp" "(" _CRT_STRINGIZE ( 18333 ) "): warning " arg0 ": " arg1;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_WARNING_MESSAGE_mixin); })) {
        mixin(_dpp_impl__CRT_WARNING_MESSAGE_mixin);
    }


    enum _dpp_impl__CRT_SECURE_INVALID_PARAMETER_mixin = ` auto _CRT_SECURE_INVALID_PARAMETER(A0)(A0 arg0) {
        return : : _invalid_parameter_noinfo_noreturn ( );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_SECURE_INVALID_PARAMETER_mixin); })) {
        mixin(_dpp_impl__CRT_SECURE_INVALID_PARAMETER_mixin);
    }




    static if(!is(typeof(_CRT_BUILD_DESKTOP_APP))) {
        private enum enumMixinStr__CRT_BUILD_DESKTOP_APP = `enum _CRT_BUILD_DESKTOP_APP = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_BUILD_DESKTOP_APP); }))) {
            mixin(enumMixinStr__CRT_BUILD_DESKTOP_APP);
        }
    }




    static if(!is(typeof(_ARM_WINAPI_PARTITION_DESKTOP_SDK_AVAILABLE))) {
        private enum enumMixinStr__ARM_WINAPI_PARTITION_DESKTOP_SDK_AVAILABLE = `enum _ARM_WINAPI_PARTITION_DESKTOP_SDK_AVAILABLE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__ARM_WINAPI_PARTITION_DESKTOP_SDK_AVAILABLE); }))) {
            mixin(enumMixinStr__ARM_WINAPI_PARTITION_DESKTOP_SDK_AVAILABLE);
        }
    }






    static if(!is(typeof(_CRT_HAS_CXX17))) {
        private enum enumMixinStr__CRT_HAS_CXX17 = `enum _CRT_HAS_CXX17 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_HAS_CXX17); }))) {
            mixin(enumMixinStr__CRT_HAS_CXX17);
        }
    }


    enum _dpp_impl__CRT_UNUSED_mixin = ` auto _CRT_UNUSED(A0)(A0 arg0) {
        return cast( void ) arg0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_UNUSED_mixin); })) {
        mixin(_dpp_impl__CRT_UNUSED_mixin);
    }




    static if(!is(typeof(_CRT_FUNCTIONS_REQUIRED))) {
        private enum enumMixinStr__CRT_FUNCTIONS_REQUIRED = `enum _CRT_FUNCTIONS_REQUIRED = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_FUNCTIONS_REQUIRED); }))) {
            mixin(enumMixinStr__CRT_FUNCTIONS_REQUIRED);
        }
    }


    enum _dpp_impl__STATIC_ASSERT_mixin = ` auto _STATIC_ASSERT(A0)(A0 arg0) {
        return _Static_assert ( ( arg0 ) , "arg0" );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__STATIC_ASSERT_mixin); })) {
        mixin(_dpp_impl__STATIC_ASSERT_mixin);
    }




    static if(!is(typeof(__FUNCTIONW__))) {
        private enum enumMixinStr___FUNCTIONW__ = `enum __FUNCTIONW__ = _CRT_WIDE cast( __FUNCTION__ );`;
        static if(is(typeof({ mixin(enumMixinStr___FUNCTIONW__); }))) {
            mixin(enumMixinStr___FUNCTIONW__);
        }
    }




    static if(!is(typeof(__FILEW__))) {
        private enum enumMixinStr___FILEW__ = `enum __FILEW__ = _CRT_WIDE ( "generated/1.21.1/MSYS_NT-10.0-19044\\mupdf.d.tmp" );`;
        static if(is(typeof({ mixin(enumMixinStr___FILEW__); }))) {
            mixin(enumMixinStr___FILEW__);
        }
    }




    static if(!is(typeof(_CRT_SIZE_MAX))) {
        private enum enumMixinStr__CRT_SIZE_MAX = `enum _CRT_SIZE_MAX = ( cast( size_t ) - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_SIZE_MAX); }))) {
            mixin(enumMixinStr__CRT_SIZE_MAX);
        }
    }




    static if(!is(typeof(_CRT_INT_MAX))) {
        private enum enumMixinStr__CRT_INT_MAX = `enum _CRT_INT_MAX = 2147483647;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_INT_MAX); }))) {
            mixin(enumMixinStr__CRT_INT_MAX);
        }
    }




    static if(!is(typeof(_TRUNCATE))) {
        private enum enumMixinStr__TRUNCATE = `enum _TRUNCATE = ( cast( size_t ) - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__TRUNCATE); }))) {
            mixin(enumMixinStr__TRUNCATE);
        }
    }




    static if(!is(typeof(_ARGMAX))) {
        private enum enumMixinStr__ARGMAX = `enum _ARGMAX = 100;`;
        static if(is(typeof({ mixin(enumMixinStr__ARGMAX); }))) {
            mixin(enumMixinStr__ARGMAX);
        }
    }
    enum _dpp_impl__CRT_ALIGN_mixin = ` auto _CRT_ALIGN(A0)(A0 arg0) {
        return __declspec ( align ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_ALIGN_mixin); })) {
        mixin(_dpp_impl__CRT_ALIGN_mixin);
    }




    static if(!is(typeof(_WConst_return))) {
        private enum enumMixinStr__WConst_return = `enum _WConst_return = _CONST_RETURN;`;
        static if(is(typeof({ mixin(enumMixinStr__WConst_return); }))) {
            mixin(enumMixinStr__WConst_return);
        }
    }
    static if(!is(typeof(_CRTALLOCATOR))) {
        private enum enumMixinStr__CRTALLOCATOR = `enum _CRTALLOCATOR = __declspec ( allocator );`;
        static if(is(typeof({ mixin(enumMixinStr__CRTALLOCATOR); }))) {
            mixin(enumMixinStr__CRTALLOCATOR);
        }
    }




    static if(!is(typeof(_CRTRESTRICT))) {
        private enum enumMixinStr__CRTRESTRICT = `enum _CRTRESTRICT = __declspec cast( restrict );`;
        static if(is(typeof({ mixin(enumMixinStr__CRTRESTRICT); }))) {
            mixin(enumMixinStr__CRTRESTRICT);
        }
    }






    static if(!is(typeof(_ACRTIMP_ALT))) {
        private enum enumMixinStr__ACRTIMP_ALT = `enum _ACRTIMP_ALT = _ACRTIMP;`;
        static if(is(typeof({ mixin(enumMixinStr__ACRTIMP_ALT); }))) {
            mixin(enumMixinStr__ACRTIMP_ALT);
        }
    }






    static if(!is(typeof(_UCRT_RESTORE_CLANG_WARNINGS))) {
        private enum enumMixinStr__UCRT_RESTORE_CLANG_WARNINGS = `enum _UCRT_RESTORE_CLANG_WARNINGS =;`;
        static if(is(typeof({ mixin(enumMixinStr__UCRT_RESTORE_CLANG_WARNINGS); }))) {
            mixin(enumMixinStr__UCRT_RESTORE_CLANG_WARNINGS);
        }
    }




    static if(!is(typeof(_UCRT_DISABLE_CLANG_WARNINGS))) {
        private enum enumMixinStr__UCRT_DISABLE_CLANG_WARNINGS = `enum _UCRT_DISABLE_CLANG_WARNINGS =
;`;
        static if(is(typeof({ mixin(enumMixinStr__UCRT_DISABLE_CLANG_WARNINGS); }))) {
            mixin(enumMixinStr__UCRT_DISABLE_CLANG_WARNINGS);
        }
    }




    static if(!is(typeof(_UCRT_DISABLED_WARNINGS))) {
        private enum enumMixinStr__UCRT_DISABLED_WARNINGS = `enum _UCRT_DISABLED_WARNINGS = 4324 _UCRT_DISABLED_WARNING_4412 4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 _UCRT_EXTRA_DISABLED_WARNINGS;`;
        static if(is(typeof({ mixin(enumMixinStr__UCRT_DISABLED_WARNINGS); }))) {
            mixin(enumMixinStr__UCRT_DISABLED_WARNINGS);
        }
    }






    enum _dpp_impl_assert__mixin = ` auto assert_(A0)(A0 arg0) {
        return cast( void ) ( ( ! ! ( arg0 ) ) || ( _wassert ( _CRT_WIDE ( "arg0" ) , _CRT_WIDE ( "generated/1.21.1/MSYS_NT-10.0-19044\\mupdf.d.tmp" ) , cast( unsigned ) ( 18569 ) ) , 0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_assert__mixin); })) {
        mixin(_dpp_impl_assert__mixin);
    }
    enum _dpp_impl__CRT_INSECURE_DEPRECATE_MEMORY_mixin = ` auto _CRT_INSECURE_DEPRECATE_MEMORY(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_INSECURE_DEPRECATE_MEMORY_mixin); })) {
        mixin(_dpp_impl__CRT_INSECURE_DEPRECATE_MEMORY_mixin);
    }


    enum _dpp_impl__CRT_INSECURE_DEPRECATE_mixin = ` auto _CRT_INSECURE_DEPRECATE(A0)(A0 arg0) {
        return _CRT_DEPRECATE_TEXT ( "This function or variable may be unsafe. Consider using " "arg0" " instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. " "See online help for details." );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_INSECURE_DEPRECATE_mixin); })) {
        mixin(_dpp_impl__CRT_INSECURE_DEPRECATE_mixin);
    }


    enum _dpp_impl__CRT_DEPRECATE_TEXT_mixin = ` auto _CRT_DEPRECATE_TEXT(A0)(A0 arg0) {
        return __declspec ( deprecated ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_DEPRECATE_TEXT_mixin); })) {
        mixin(_dpp_impl__CRT_DEPRECATE_TEXT_mixin);
    }






    static if(!is(typeof(_HAS_NODISCARD))) {
        private enum enumMixinStr__HAS_NODISCARD = `enum _HAS_NODISCARD = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__HAS_NODISCARD); }))) {
            mixin(enumMixinStr__HAS_NODISCARD);
        }
    }




    static if(!is(typeof(_HAS_CXX20))) {
        private enum enumMixinStr__HAS_CXX20 = `enum _HAS_CXX20 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__HAS_CXX20); }))) {
            mixin(enumMixinStr__HAS_CXX20);
        }
    }




    static if(!is(typeof(_HAS_CXX17))) {
        private enum enumMixinStr__HAS_CXX17 = `enum _HAS_CXX17 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__HAS_CXX17); }))) {
            mixin(enumMixinStr__HAS_CXX17);
        }
    }




    static if(!is(typeof(_STL_LANG))) {
        private enum enumMixinStr__STL_LANG = `enum _STL_LANG = 0L;`;
        static if(is(typeof({ mixin(enumMixinStr__STL_LANG); }))) {
            mixin(enumMixinStr__STL_LANG);
        }
    }






    static if(!is(typeof(_UNALIGNED))) {
        private enum enumMixinStr__UNALIGNED = `enum _UNALIGNED = __unaligned;`;
        static if(is(typeof({ mixin(enumMixinStr__UNALIGNED); }))) {
            mixin(enumMixinStr__UNALIGNED);
        }
    }
    enum _dpp_impl__VCRT_ALIGN_mixin = ` auto _VCRT_ALIGN(A0)(A0 arg0) {
        return __declspec ( align ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__VCRT_ALIGN_mixin); })) {
        mixin(_dpp_impl__VCRT_ALIGN_mixin);
    }






    static if(!is(typeof(_VCRT_ALLOCATOR))) {
        private enum enumMixinStr__VCRT_ALLOCATOR = `enum _VCRT_ALLOCATOR = __declspec ( allocator );`;
        static if(is(typeof({ mixin(enumMixinStr__VCRT_ALLOCATOR); }))) {
            mixin(enumMixinStr__VCRT_ALLOCATOR);
        }
    }




    static if(!is(typeof(_VCRT_RESTRICT))) {
        private enum enumMixinStr__VCRT_RESTRICT = `enum _VCRT_RESTRICT = __declspec cast( restrict );`;
        static if(is(typeof({ mixin(enumMixinStr__VCRT_RESTRICT); }))) {
            mixin(enumMixinStr__VCRT_RESTRICT);
        }
    }




    static if(!is(typeof(_VCRT_NOALIAS))) {
        private enum enumMixinStr__VCRT_NOALIAS = `enum _VCRT_NOALIAS = __declspec ( noalias );`;
        static if(is(typeof({ mixin(enumMixinStr__VCRT_NOALIAS); }))) {
            mixin(enumMixinStr__VCRT_NOALIAS);
        }
    }




    static if(!is(typeof(__CRTDECL))) {
        private enum enumMixinStr___CRTDECL = `enum __CRTDECL = __CLRCALL_PURE_OR_CDECL;`;
        static if(is(typeof({ mixin(enumMixinStr___CRTDECL); }))) {
            mixin(enumMixinStr___CRTDECL);
        }
    }




    static if(!is(typeof(__CLRCALL_PURE_OR_CDECL))) {
        private enum enumMixinStr___CLRCALL_PURE_OR_CDECL = `enum __CLRCALL_PURE_OR_CDECL = __cdecl;`;
        static if(is(typeof({ mixin(enumMixinStr___CLRCALL_PURE_OR_CDECL); }))) {
            mixin(enumMixinStr___CLRCALL_PURE_OR_CDECL);
        }
    }






    static if(!is(typeof(__CLRCALL_OR_CDECL))) {
        private enum enumMixinStr___CLRCALL_OR_CDECL = `enum __CLRCALL_OR_CDECL = __cdecl;`;
        static if(is(typeof({ mixin(enumMixinStr___CLRCALL_OR_CDECL); }))) {
            mixin(enumMixinStr___CLRCALL_OR_CDECL);
        }
    }






    enum _dpp_impl__CRT_UNPARENTHESIZE_mixin = ` auto _CRT_UNPARENTHESIZE(, REST...)(, REST rest) {
        return _CRT_UNPARENTHESIZE_ , rest;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_UNPARENTHESIZE_mixin); })) {
        mixin(_dpp_impl__CRT_UNPARENTHESIZE_mixin);
    }


    enum _dpp_impl__CRT_UNPARENTHESIZE__mixin = ` auto _CRT_UNPARENTHESIZE_(, REST...)(, REST rest) {
        return , rest;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_UNPARENTHESIZE__mixin); })) {
        mixin(_dpp_impl__CRT_UNPARENTHESIZE__mixin);
    }


    enum _dpp_impl__CRT_CONCATENATE_mixin = ` auto _CRT_CONCATENATE(A0, A1)(A0 arg0, A1 arg1) {
        return _CRT_CONCATENATE_ ( arg0 , arg1 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_CONCATENATE_mixin); })) {
        mixin(_dpp_impl__CRT_CONCATENATE_mixin);
    }


    enum _dpp_impl__CRT_CONCATENATE__mixin = ` auto _CRT_CONCATENATE_(A0, A1)(A0 arg0, A1 arg1) {
        return arg0arg1;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_CONCATENATE__mixin); })) {
        mixin(_dpp_impl__CRT_CONCATENATE__mixin);
    }


    enum _dpp_impl__CRT_WIDE_mixin = ` auto _CRT_WIDE(A0)(A0 arg0) {
        return _CRT_WIDE_ ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_WIDE_mixin); })) {
        mixin(_dpp_impl__CRT_WIDE_mixin);
    }


    enum _dpp_impl__CRT_WIDE__mixin = ` auto _CRT_WIDE_(A0)(A0 arg0) {
        return Larg0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_WIDE__mixin); })) {
        mixin(_dpp_impl__CRT_WIDE__mixin);
    }


    enum _dpp_impl__CRT_STRINGIZE_mixin = ` auto _CRT_STRINGIZE(A0)(A0 arg0) {
        return _CRT_STRINGIZE_ ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_STRINGIZE_mixin); })) {
        mixin(_dpp_impl__CRT_STRINGIZE_mixin);
    }


    enum _dpp_impl__CRT_STRINGIZE__mixin = ` auto _CRT_STRINGIZE_(A0)(A0 arg0) {
        return "arg0";
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__CRT_STRINGIZE__mixin); })) {
        mixin(_dpp_impl__CRT_STRINGIZE__mixin);
    }




    static if(!is(typeof(_HAS_EXCEPTIONS))) {
        private enum enumMixinStr__HAS_EXCEPTIONS = `enum _HAS_EXCEPTIONS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__HAS_EXCEPTIONS); }))) {
            mixin(enumMixinStr__HAS_EXCEPTIONS);
        }
    }




    static if(!is(typeof(_CRT_END_C_HEADER))) {
        private enum enumMixinStr__CRT_END_C_HEADER = `enum _CRT_END_C_HEADER =
;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_END_C_HEADER); }))) {
            mixin(enumMixinStr__CRT_END_C_HEADER);
        }
    }




    static if(!is(typeof(_CRT_BEGIN_C_HEADER))) {
        private enum enumMixinStr__CRT_BEGIN_C_HEADER = `enum _CRT_BEGIN_C_HEADER =
;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_BEGIN_C_HEADER); }))) {
            mixin(enumMixinStr__CRT_BEGIN_C_HEADER);
        }
    }
    static if(!is(typeof(MEMENTO_UNDERLYING_MALLOC))) {
        private enum enumMixinStr_MEMENTO_UNDERLYING_MALLOC = `enum MEMENTO_UNDERLYING_MALLOC = malloc;`;
        static if(is(typeof({ mixin(enumMixinStr_MEMENTO_UNDERLYING_MALLOC); }))) {
            mixin(enumMixinStr_MEMENTO_UNDERLYING_MALLOC);
        }
    }




    static if(!is(typeof(MEMENTO_UNDERLYING_FREE))) {
        private enum enumMixinStr_MEMENTO_UNDERLYING_FREE = `enum MEMENTO_UNDERLYING_FREE = free;`;
        static if(is(typeof({ mixin(enumMixinStr_MEMENTO_UNDERLYING_FREE); }))) {
            mixin(enumMixinStr_MEMENTO_UNDERLYING_FREE);
        }
    }




    static if(!is(typeof(MEMENTO_UNDERLYING_REALLOC))) {
        private enum enumMixinStr_MEMENTO_UNDERLYING_REALLOC = `enum MEMENTO_UNDERLYING_REALLOC = realloc;`;
        static if(is(typeof({ mixin(enumMixinStr_MEMENTO_UNDERLYING_REALLOC); }))) {
            mixin(enumMixinStr_MEMENTO_UNDERLYING_REALLOC);
        }
    }




    static if(!is(typeof(MEMENTO_UNDERLYING_CALLOC))) {
        private enum enumMixinStr_MEMENTO_UNDERLYING_CALLOC = `enum MEMENTO_UNDERLYING_CALLOC = calloc;`;
        static if(is(typeof({ mixin(enumMixinStr_MEMENTO_UNDERLYING_CALLOC); }))) {
            mixin(enumMixinStr_MEMENTO_UNDERLYING_CALLOC);
        }
    }




    static if(!is(typeof(MEMENTO_MAXALIGN))) {
        private enum enumMixinStr_MEMENTO_MAXALIGN = `enum MEMENTO_MAXALIGN = ( ( int ) .sizeof );`;
        static if(is(typeof({ mixin(enumMixinStr_MEMENTO_MAXALIGN); }))) {
            mixin(enumMixinStr_MEMENTO_MAXALIGN);
        }
    }




    static if(!is(typeof(MEMENTO_PREFILL))) {
        private enum enumMixinStr_MEMENTO_PREFILL = `enum MEMENTO_PREFILL = 0xa6;`;
        static if(is(typeof({ mixin(enumMixinStr_MEMENTO_PREFILL); }))) {
            mixin(enumMixinStr_MEMENTO_PREFILL);
        }
    }




    static if(!is(typeof(MEMENTO_POSTFILL))) {
        private enum enumMixinStr_MEMENTO_POSTFILL = `enum MEMENTO_POSTFILL = 0xa7;`;
        static if(is(typeof({ mixin(enumMixinStr_MEMENTO_POSTFILL); }))) {
            mixin(enumMixinStr_MEMENTO_POSTFILL);
        }
    }




    static if(!is(typeof(MEMENTO_ALLOCFILL))) {
        private enum enumMixinStr_MEMENTO_ALLOCFILL = `enum MEMENTO_ALLOCFILL = 0xa8;`;
        static if(is(typeof({ mixin(enumMixinStr_MEMENTO_ALLOCFILL); }))) {
            mixin(enumMixinStr_MEMENTO_ALLOCFILL);
        }
    }




    static if(!is(typeof(MEMENTO_FREEFILL))) {
        private enum enumMixinStr_MEMENTO_FREEFILL = `enum MEMENTO_FREEFILL = 0xa9;`;
        static if(is(typeof({ mixin(enumMixinStr_MEMENTO_FREEFILL); }))) {
            mixin(enumMixinStr_MEMENTO_FREEFILL);
        }
    }




    static if(!is(typeof(MEMENTO_FREELIST_MAX))) {
        private enum enumMixinStr_MEMENTO_FREELIST_MAX = `enum MEMENTO_FREELIST_MAX = 0x2000000;`;
        static if(is(typeof({ mixin(enumMixinStr_MEMENTO_FREELIST_MAX); }))) {
            mixin(enumMixinStr_MEMENTO_FREELIST_MAX);
        }
    }
    static if(!is(typeof(_VCRT_COMPILER_PREPROCESSOR))) {
        private enum enumMixinStr__VCRT_COMPILER_PREPROCESSOR = `enum _VCRT_COMPILER_PREPROCESSOR = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__VCRT_COMPILER_PREPROCESSOR); }))) {
            mixin(enumMixinStr__VCRT_COMPILER_PREPROCESSOR);
        }
    }






    enum _dpp_impl__APALIGN_mixin = ` auto _APALIGN(A0, A1)(A0 arg0, A1 arg1) {
        return ( __alignof ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__APALIGN_mixin); })) {
        mixin(_dpp_impl__APALIGN_mixin);
    }


    enum _dpp_impl__SLOTSIZEOF_mixin = ` auto _SLOTSIZEOF(A0)(A0 arg0) {
        return ( ( arg0 ) .sizeof );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__SLOTSIZEOF_mixin); })) {
        mixin(_dpp_impl__SLOTSIZEOF_mixin);
    }


    enum _dpp_impl__ADDRESSOF_mixin = ` auto _ADDRESSOF(A0)(A0 arg0) {
        return ( & ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__ADDRESSOF_mixin); })) {
        mixin(_dpp_impl__ADDRESSOF_mixin);
    }
    static if(!is(typeof(_VCRUNTIME_DISABLED_WARNINGS))) {
        private enum enumMixinStr__VCRUNTIME_DISABLED_WARNINGS = `enum _VCRUNTIME_DISABLED_WARNINGS = _VCRUNTIME_DISABLED_WARNING_4339 _VCRUNTIME_DISABLED_WARNING_4412 4514 4820 _VCRUNTIME_EXTRA_DISABLED_WARNINGS;`;
        static if(is(typeof({ mixin(enumMixinStr__VCRUNTIME_DISABLED_WARNINGS); }))) {
            mixin(enumMixinStr__VCRUNTIME_DISABLED_WARNINGS);
        }
    }
    static if(!is(typeof(_CRT_PACKING))) {
        private enum enumMixinStr__CRT_PACKING = `enum _CRT_PACKING = 8;`;
        static if(is(typeof({ mixin(enumMixinStr__CRT_PACKING); }))) {
            mixin(enumMixinStr__CRT_PACKING);
        }
    }




    enum _dpp_impl_UINTMAX_C_mixin = ` auto UINTMAX_C(A0)(A0 arg0) {
        return UINT64_C ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_UINTMAX_C_mixin); })) {
        mixin(_dpp_impl_UINTMAX_C_mixin);
    }


    enum _dpp_impl_INTMAX_C_mixin = ` auto INTMAX_C(A0)(A0 arg0) {
        return INT64_C ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_INTMAX_C_mixin); })) {
        mixin(_dpp_impl_INTMAX_C_mixin);
    }


    enum _dpp_impl_UINT64_C_mixin = ` auto UINT64_C(A0)(A0 arg0) {
        return ( arg0ULL );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_UINT64_C_mixin); })) {
        mixin(_dpp_impl_UINT64_C_mixin);
    }


    enum _dpp_impl_UINT32_C_mixin = ` auto UINT32_C(A0)(A0 arg0) {
        return ( arg0U );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_UINT32_C_mixin); })) {
        mixin(_dpp_impl_UINT32_C_mixin);
    }


    enum _dpp_impl_UINT16_C_mixin = ` auto UINT16_C(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_UINT16_C_mixin); })) {
        mixin(_dpp_impl_UINT16_C_mixin);
    }


    enum _dpp_impl_UINT8_C_mixin = ` auto UINT8_C(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_UINT8_C_mixin); })) {
        mixin(_dpp_impl_UINT8_C_mixin);
    }


    enum _dpp_impl_INT64_C_mixin = ` auto INT64_C(A0)(A0 arg0) {
        return ( arg0LL );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_INT64_C_mixin); })) {
        mixin(_dpp_impl_INT64_C_mixin);
    }


    enum _dpp_impl_INT32_C_mixin = ` auto INT32_C(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_INT32_C_mixin); })) {
        mixin(_dpp_impl_INT32_C_mixin);
    }


    enum _dpp_impl_INT16_C_mixin = ` auto INT16_C(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_INT16_C_mixin); })) {
        mixin(_dpp_impl_INT16_C_mixin);
    }


    enum _dpp_impl_INT8_C_mixin = ` auto INT8_C(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_INT8_C_mixin); })) {
        mixin(_dpp_impl_INT8_C_mixin);
    }




    static if(!is(typeof(WINT_MAX))) {
        private enum enumMixinStr_WINT_MAX = `enum WINT_MAX = 0xffff;`;
        static if(is(typeof({ mixin(enumMixinStr_WINT_MAX); }))) {
            mixin(enumMixinStr_WINT_MAX);
        }
    }




    static if(!is(typeof(WINT_MIN))) {
        private enum enumMixinStr_WINT_MIN = `enum WINT_MIN = 0x0000;`;
        static if(is(typeof({ mixin(enumMixinStr_WINT_MIN); }))) {
            mixin(enumMixinStr_WINT_MIN);
        }
    }




    static if(!is(typeof(WCHAR_MAX))) {
        private enum enumMixinStr_WCHAR_MAX = `enum WCHAR_MAX = 0xffff;`;
        static if(is(typeof({ mixin(enumMixinStr_WCHAR_MAX); }))) {
            mixin(enumMixinStr_WCHAR_MAX);
        }
    }




    static if(!is(typeof(WCHAR_MIN))) {
        private enum enumMixinStr_WCHAR_MIN = `enum WCHAR_MIN = 0x0000;`;
        static if(is(typeof({ mixin(enumMixinStr_WCHAR_MIN); }))) {
            mixin(enumMixinStr_WCHAR_MIN);
        }
    }




    static if(!is(typeof(SIG_ATOMIC_MAX))) {
        private enum enumMixinStr_SIG_ATOMIC_MAX = `enum SIG_ATOMIC_MAX = INT32_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_SIG_ATOMIC_MAX); }))) {
            mixin(enumMixinStr_SIG_ATOMIC_MAX);
        }
    }




    static if(!is(typeof(SIG_ATOMIC_MIN))) {
        private enum enumMixinStr_SIG_ATOMIC_MIN = `enum SIG_ATOMIC_MIN = INT32_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_SIG_ATOMIC_MIN); }))) {
            mixin(enumMixinStr_SIG_ATOMIC_MIN);
        }
    }




    static if(!is(typeof(SIZE_MAX))) {
        private enum enumMixinStr_SIZE_MAX = `enum SIZE_MAX = 0xffffffffffffffffuL;`;
        static if(is(typeof({ mixin(enumMixinStr_SIZE_MAX); }))) {
            mixin(enumMixinStr_SIZE_MAX);
        }
    }




    static if(!is(typeof(PTRDIFF_MAX))) {
        private enum enumMixinStr_PTRDIFF_MAX = `enum PTRDIFF_MAX = INTPTR_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_PTRDIFF_MAX); }))) {
            mixin(enumMixinStr_PTRDIFF_MAX);
        }
    }




    static if(!is(typeof(PTRDIFF_MIN))) {
        private enum enumMixinStr_PTRDIFF_MIN = `enum PTRDIFF_MIN = INTPTR_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_PTRDIFF_MIN); }))) {
            mixin(enumMixinStr_PTRDIFF_MIN);
        }
    }




    static if(!is(typeof(UINTMAX_MAX))) {
        private enum enumMixinStr_UINTMAX_MAX = `enum UINTMAX_MAX = UINT64_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_UINTMAX_MAX); }))) {
            mixin(enumMixinStr_UINTMAX_MAX);
        }
    }




    static if(!is(typeof(INTMAX_MAX))) {
        private enum enumMixinStr_INTMAX_MAX = `enum INTMAX_MAX = INT64_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_INTMAX_MAX); }))) {
            mixin(enumMixinStr_INTMAX_MAX);
        }
    }




    static if(!is(typeof(INTMAX_MIN))) {
        private enum enumMixinStr_INTMAX_MIN = `enum INTMAX_MIN = INT64_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_INTMAX_MIN); }))) {
            mixin(enumMixinStr_INTMAX_MIN);
        }
    }




    static if(!is(typeof(UINTPTR_MAX))) {
        private enum enumMixinStr_UINTPTR_MAX = `enum UINTPTR_MAX = UINT64_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_UINTPTR_MAX); }))) {
            mixin(enumMixinStr_UINTPTR_MAX);
        }
    }




    static if(!is(typeof(INTPTR_MAX))) {
        private enum enumMixinStr_INTPTR_MAX = `enum INTPTR_MAX = INT64_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_INTPTR_MAX); }))) {
            mixin(enumMixinStr_INTPTR_MAX);
        }
    }




    static if(!is(typeof(INTPTR_MIN))) {
        private enum enumMixinStr_INTPTR_MIN = `enum INTPTR_MIN = INT64_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_INTPTR_MIN); }))) {
            mixin(enumMixinStr_INTPTR_MIN);
        }
    }




    static if(!is(typeof(UINT_FAST64_MAX))) {
        private enum enumMixinStr_UINT_FAST64_MAX = `enum UINT_FAST64_MAX = UINT64_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST64_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST64_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST32_MAX))) {
        private enum enumMixinStr_UINT_FAST32_MAX = `enum UINT_FAST32_MAX = UINT32_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST32_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST32_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST16_MAX))) {
        private enum enumMixinStr_UINT_FAST16_MAX = `enum UINT_FAST16_MAX = UINT32_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST16_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST16_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST8_MAX))) {
        private enum enumMixinStr_UINT_FAST8_MAX = `enum UINT_FAST8_MAX = UINT8_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST8_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST8_MAX);
        }
    }




    static if(!is(typeof(INT_FAST64_MAX))) {
        private enum enumMixinStr_INT_FAST64_MAX = `enum INT_FAST64_MAX = INT64_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST64_MAX); }))) {
            mixin(enumMixinStr_INT_FAST64_MAX);
        }
    }




    static if(!is(typeof(INT_FAST32_MAX))) {
        private enum enumMixinStr_INT_FAST32_MAX = `enum INT_FAST32_MAX = INT32_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST32_MAX); }))) {
            mixin(enumMixinStr_INT_FAST32_MAX);
        }
    }




    static if(!is(typeof(INT_FAST16_MAX))) {
        private enum enumMixinStr_INT_FAST16_MAX = `enum INT_FAST16_MAX = INT32_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST16_MAX); }))) {
            mixin(enumMixinStr_INT_FAST16_MAX);
        }
    }




    static if(!is(typeof(INT_FAST8_MAX))) {
        private enum enumMixinStr_INT_FAST8_MAX = `enum INT_FAST8_MAX = INT8_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST8_MAX); }))) {
            mixin(enumMixinStr_INT_FAST8_MAX);
        }
    }




    static if(!is(typeof(INT_FAST64_MIN))) {
        private enum enumMixinStr_INT_FAST64_MIN = `enum INT_FAST64_MIN = INT64_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST64_MIN); }))) {
            mixin(enumMixinStr_INT_FAST64_MIN);
        }
    }




    static if(!is(typeof(INT_FAST32_MIN))) {
        private enum enumMixinStr_INT_FAST32_MIN = `enum INT_FAST32_MIN = INT32_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST32_MIN); }))) {
            mixin(enumMixinStr_INT_FAST32_MIN);
        }
    }




    static if(!is(typeof(Memento_malloc))) {
        private enum enumMixinStr_Memento_malloc = `enum Memento_malloc = malloc;`;
        static if(is(typeof({ mixin(enumMixinStr_Memento_malloc); }))) {
            mixin(enumMixinStr_Memento_malloc);
        }
    }




    static if(!is(typeof(Memento_free))) {
        private enum enumMixinStr_Memento_free = `enum Memento_free = free;`;
        static if(is(typeof({ mixin(enumMixinStr_Memento_free); }))) {
            mixin(enumMixinStr_Memento_free);
        }
    }




    static if(!is(typeof(Memento_realloc))) {
        private enum enumMixinStr_Memento_realloc = `enum Memento_realloc = realloc;`;
        static if(is(typeof({ mixin(enumMixinStr_Memento_realloc); }))) {
            mixin(enumMixinStr_Memento_realloc);
        }
    }




    static if(!is(typeof(Memento_calloc))) {
        private enum enumMixinStr_Memento_calloc = `enum Memento_calloc = calloc;`;
        static if(is(typeof({ mixin(enumMixinStr_Memento_calloc); }))) {
            mixin(enumMixinStr_Memento_calloc);
        }
    }




    static if(!is(typeof(Memento_strdup))) {
        private enum enumMixinStr_Memento_strdup = `enum Memento_strdup = strdup;`;
        static if(is(typeof({ mixin(enumMixinStr_Memento_strdup); }))) {
            mixin(enumMixinStr_Memento_strdup);
        }
    }




    static if(!is(typeof(Memento_asprintf))) {
        private enum enumMixinStr_Memento_asprintf = `enum Memento_asprintf = asprintf;`;
        static if(is(typeof({ mixin(enumMixinStr_Memento_asprintf); }))) {
            mixin(enumMixinStr_Memento_asprintf);
        }
    }




    static if(!is(typeof(Memento_vasprintf))) {
        private enum enumMixinStr_Memento_vasprintf = `enum Memento_vasprintf = vasprintf;`;
        static if(is(typeof({ mixin(enumMixinStr_Memento_vasprintf); }))) {
            mixin(enumMixinStr_Memento_vasprintf);
        }
    }


    enum _dpp_impl_Memento_checkBlock_mixin = ` auto Memento_checkBlock(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_checkBlock_mixin); })) {
        mixin(_dpp_impl_Memento_checkBlock_mixin);
    }


    enum _dpp_impl_Memento_checkAllMemory_mixin = ` auto Memento_checkAllMemory()() {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_checkAllMemory_mixin); })) {
        mixin(_dpp_impl_Memento_checkAllMemory_mixin);
    }


    enum _dpp_impl_Memento_check_mixin = ` auto Memento_check()() {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_check_mixin); })) {
        mixin(_dpp_impl_Memento_check_mixin);
    }


    enum _dpp_impl_Memento_setParanoia_mixin = ` auto Memento_setParanoia(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_setParanoia_mixin); })) {
        mixin(_dpp_impl_Memento_setParanoia_mixin);
    }


    enum _dpp_impl_Memento_paranoidAt_mixin = ` auto Memento_paranoidAt(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_paranoidAt_mixin); })) {
        mixin(_dpp_impl_Memento_paranoidAt_mixin);
    }


    enum _dpp_impl_Memento_breakAt_mixin = ` auto Memento_breakAt(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_breakAt_mixin); })) {
        mixin(_dpp_impl_Memento_breakAt_mixin);
    }


    enum _dpp_impl_Memento_breakOnFree_mixin = ` auto Memento_breakOnFree(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_breakOnFree_mixin); })) {
        mixin(_dpp_impl_Memento_breakOnFree_mixin);
    }


    enum _dpp_impl_Memento_breakOnRealloc_mixin = ` auto Memento_breakOnRealloc(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_breakOnRealloc_mixin); })) {
        mixin(_dpp_impl_Memento_breakOnRealloc_mixin);
    }


    enum _dpp_impl_Memento_getBlockNum_mixin = ` auto Memento_getBlockNum(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_getBlockNum_mixin); })) {
        mixin(_dpp_impl_Memento_getBlockNum_mixin);
    }


    enum _dpp_impl_Memento_find_mixin = ` auto Memento_find(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_find_mixin); })) {
        mixin(_dpp_impl_Memento_find_mixin);
    }


    enum _dpp_impl_Memento_breakpoint_mixin = ` auto Memento_breakpoint()() {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_breakpoint_mixin); })) {
        mixin(_dpp_impl_Memento_breakpoint_mixin);
    }


    enum _dpp_impl_Memento_failAt_mixin = ` auto Memento_failAt(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_failAt_mixin); })) {
        mixin(_dpp_impl_Memento_failAt_mixin);
    }


    enum _dpp_impl_Memento_failThisEvent_mixin = ` auto Memento_failThisEvent()() {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_failThisEvent_mixin); })) {
        mixin(_dpp_impl_Memento_failThisEvent_mixin);
    }


    enum _dpp_impl_Memento_listBlocks_mixin = ` auto Memento_listBlocks()() {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_listBlocks_mixin); })) {
        mixin(_dpp_impl_Memento_listBlocks_mixin);
    }


    enum _dpp_impl_Memento_listNewBlocks_mixin = ` auto Memento_listNewBlocks()() {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_listNewBlocks_mixin); })) {
        mixin(_dpp_impl_Memento_listNewBlocks_mixin);
    }


    enum _dpp_impl_Memento_setMax_mixin = ` auto Memento_setMax(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_setMax_mixin); })) {
        mixin(_dpp_impl_Memento_setMax_mixin);
    }


    enum _dpp_impl_Memento_stats_mixin = ` auto Memento_stats()() {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_stats_mixin); })) {
        mixin(_dpp_impl_Memento_stats_mixin);
    }


    enum _dpp_impl_Memento_label_mixin = ` auto Memento_label(A0, A1)(A0 arg0, A1 arg1) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_label_mixin); })) {
        mixin(_dpp_impl_Memento_label_mixin);
    }


    enum _dpp_impl_Memento_info_mixin = ` auto Memento_info(A0)(A0 arg0) {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_info_mixin); })) {
        mixin(_dpp_impl_Memento_info_mixin);
    }


    enum _dpp_impl_Memento_listBlockInfo_mixin = ` auto Memento_listBlockInfo()() {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_listBlockInfo_mixin); })) {
        mixin(_dpp_impl_Memento_listBlockInfo_mixin);
    }


    enum _dpp_impl_Memento_blockInfo_mixin = ` auto Memento_blockInfo(A0)(A0 arg0) {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_blockInfo_mixin); })) {
        mixin(_dpp_impl_Memento_blockInfo_mixin);
    }


    enum _dpp_impl_Memento_takeByteRef_mixin = ` auto Memento_takeByteRef(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_takeByteRef_mixin); })) {
        mixin(_dpp_impl_Memento_takeByteRef_mixin);
    }


    enum _dpp_impl_Memento_dropByteRef_mixin = ` auto Memento_dropByteRef(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_dropByteRef_mixin); })) {
        mixin(_dpp_impl_Memento_dropByteRef_mixin);
    }


    enum _dpp_impl_Memento_takeShortRef_mixin = ` auto Memento_takeShortRef(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_takeShortRef_mixin); })) {
        mixin(_dpp_impl_Memento_takeShortRef_mixin);
    }


    enum _dpp_impl_Memento_dropShortRef_mixin = ` auto Memento_dropShortRef(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_dropShortRef_mixin); })) {
        mixin(_dpp_impl_Memento_dropShortRef_mixin);
    }


    enum _dpp_impl_Memento_takeIntRef_mixin = ` auto Memento_takeIntRef(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_takeIntRef_mixin); })) {
        mixin(_dpp_impl_Memento_takeIntRef_mixin);
    }


    enum _dpp_impl_Memento_dropIntRef_mixin = ` auto Memento_dropIntRef(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_dropIntRef_mixin); })) {
        mixin(_dpp_impl_Memento_dropIntRef_mixin);
    }


    enum _dpp_impl_Memento_takeRef_mixin = ` auto Memento_takeRef(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_takeRef_mixin); })) {
        mixin(_dpp_impl_Memento_takeRef_mixin);
    }


    enum _dpp_impl_Memento_dropRef_mixin = ` auto Memento_dropRef(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_dropRef_mixin); })) {
        mixin(_dpp_impl_Memento_dropRef_mixin);
    }


    enum _dpp_impl_Memento_adjustRef_mixin = ` auto Memento_adjustRef(A0, A1)(A0 arg0, A1 arg1) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_adjustRef_mixin); })) {
        mixin(_dpp_impl_Memento_adjustRef_mixin);
    }


    enum _dpp_impl_Memento_reference_mixin = ` auto Memento_reference(A0)(A0 arg0) {
        return ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_reference_mixin); })) {
        mixin(_dpp_impl_Memento_reference_mixin);
    }


    enum _dpp_impl_Memento_checkPointerOrNull_mixin = ` auto Memento_checkPointerOrNull(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_checkPointerOrNull_mixin); })) {
        mixin(_dpp_impl_Memento_checkPointerOrNull_mixin);
    }


    enum _dpp_impl_Memento_checkBytePointerOrNull_mixin = ` auto Memento_checkBytePointerOrNull(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_checkBytePointerOrNull_mixin); })) {
        mixin(_dpp_impl_Memento_checkBytePointerOrNull_mixin);
    }


    enum _dpp_impl_Memento_checkShortPointerOrNull_mixin = ` auto Memento_checkShortPointerOrNull(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_checkShortPointerOrNull_mixin); })) {
        mixin(_dpp_impl_Memento_checkShortPointerOrNull_mixin);
    }


    enum _dpp_impl_Memento_checkIntPointerOrNull_mixin = ` auto Memento_checkIntPointerOrNull(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_checkIntPointerOrNull_mixin); })) {
        mixin(_dpp_impl_Memento_checkIntPointerOrNull_mixin);
    }


    enum _dpp_impl_Memento_setVerbose_mixin = ` auto Memento_setVerbose(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_setVerbose_mixin); })) {
        mixin(_dpp_impl_Memento_setVerbose_mixin);
    }


    enum _dpp_impl_Memento_setIgnoreNewDelete_mixin = ` auto Memento_setIgnoreNewDelete(A0)(A0 arg0) {
        return 0;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_setIgnoreNewDelete_mixin); })) {
        mixin(_dpp_impl_Memento_setIgnoreNewDelete_mixin);
    }


    enum _dpp_impl_Memento_tick_mixin = ` auto Memento_tick()() {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_tick_mixin); })) {
        mixin(_dpp_impl_Memento_tick_mixin);
    }


    enum _dpp_impl_Memento_startLeaking_mixin = ` auto Memento_startLeaking()() {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_startLeaking_mixin); })) {
        mixin(_dpp_impl_Memento_startLeaking_mixin);
    }


    enum _dpp_impl_Memento_stopLeaking_mixin = ` auto Memento_stopLeaking()() {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_stopLeaking_mixin); })) {
        mixin(_dpp_impl_Memento_stopLeaking_mixin);
    }


    enum _dpp_impl_Memento_fin_mixin = ` auto Memento_fin()() {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_fin_mixin); })) {
        mixin(_dpp_impl_Memento_fin_mixin);
    }


    enum _dpp_impl_Memento_bt_mixin = ` auto Memento_bt()() {
        return do { } while ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_bt_mixin); })) {
        mixin(_dpp_impl_Memento_bt_mixin);
    }


    enum _dpp_impl_Memento_sequence_mixin = ` auto Memento_sequence()() {
        return ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_sequence_mixin); })) {
        mixin(_dpp_impl_Memento_sequence_mixin);
    }


    enum _dpp_impl_Memento_squeezing_mixin = ` auto Memento_squeezing()() {
        return ( 0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_Memento_squeezing_mixin); })) {
        mixin(_dpp_impl_Memento_squeezing_mixin);
    }






    static if(!is(typeof(INT_FAST16_MIN))) {
        private enum enumMixinStr_INT_FAST16_MIN = `enum INT_FAST16_MIN = INT32_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST16_MIN); }))) {
            mixin(enumMixinStr_INT_FAST16_MIN);
        }
    }




    static if(!is(typeof(INT_FAST8_MIN))) {
        private enum enumMixinStr_INT_FAST8_MIN = `enum INT_FAST8_MIN = INT8_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST8_MIN); }))) {
            mixin(enumMixinStr_INT_FAST8_MIN);
        }
    }




    static if(!is(typeof(UINT_LEAST64_MAX))) {
        private enum enumMixinStr_UINT_LEAST64_MAX = `enum UINT_LEAST64_MAX = UINT64_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST64_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST64_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST32_MAX))) {
        private enum enumMixinStr_UINT_LEAST32_MAX = `enum UINT_LEAST32_MAX = UINT32_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST32_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST32_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST16_MAX))) {
        private enum enumMixinStr_UINT_LEAST16_MAX = `enum UINT_LEAST16_MAX = UINT16_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST16_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST16_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST8_MAX))) {
        private enum enumMixinStr_UINT_LEAST8_MAX = `enum UINT_LEAST8_MAX = UINT8_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST8_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST8_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST64_MAX))) {
        private enum enumMixinStr_INT_LEAST64_MAX = `enum INT_LEAST64_MAX = INT64_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST64_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST64_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST32_MAX))) {
        private enum enumMixinStr_INT_LEAST32_MAX = `enum INT_LEAST32_MAX = INT32_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST32_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST32_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST16_MAX))) {
        private enum enumMixinStr_INT_LEAST16_MAX = `enum INT_LEAST16_MAX = INT16_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST16_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST16_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST8_MAX))) {
        private enum enumMixinStr_INT_LEAST8_MAX = `enum INT_LEAST8_MAX = INT8_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST8_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST8_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST64_MIN))) {
        private enum enumMixinStr_INT_LEAST64_MIN = `enum INT_LEAST64_MIN = INT64_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST64_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST64_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST32_MIN))) {
        private enum enumMixinStr_INT_LEAST32_MIN = `enum INT_LEAST32_MIN = INT32_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST32_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST32_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST16_MIN))) {
        private enum enumMixinStr_INT_LEAST16_MIN = `enum INT_LEAST16_MIN = INT16_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST16_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST16_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST8_MIN))) {
        private enum enumMixinStr_INT_LEAST8_MIN = `enum INT_LEAST8_MIN = INT8_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST8_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST8_MIN);
        }
    }




    static if(!is(typeof(UINT64_MAX))) {
        private enum enumMixinStr_UINT64_MAX = `enum UINT64_MAX = 0xffffffffffffffffuL;`;
        static if(is(typeof({ mixin(enumMixinStr_UINT64_MAX); }))) {
            mixin(enumMixinStr_UINT64_MAX);
        }
    }




    static if(!is(typeof(UINT32_MAX))) {
        private enum enumMixinStr_UINT32_MAX = `enum UINT32_MAX = 0xffffffffu;`;
        static if(is(typeof({ mixin(enumMixinStr_UINT32_MAX); }))) {
            mixin(enumMixinStr_UINT32_MAX);
        }
    }






    static if(!is(typeof(UINT16_MAX))) {
        private enum enumMixinStr_UINT16_MAX = `enum UINT16_MAX = 0xffffu;`;
        static if(is(typeof({ mixin(enumMixinStr_UINT16_MAX); }))) {
            mixin(enumMixinStr_UINT16_MAX);
        }
    }




    static if(!is(typeof(UINT8_MAX))) {
        private enum enumMixinStr_UINT8_MAX = `enum UINT8_MAX = 0xff;`;
        static if(is(typeof({ mixin(enumMixinStr_UINT8_MAX); }))) {
            mixin(enumMixinStr_UINT8_MAX);
        }
    }




    static if(!is(typeof(INT64_MAX))) {
        private enum enumMixinStr_INT64_MAX = `enum INT64_MAX = 9223372036854775807L;`;
        static if(is(typeof({ mixin(enumMixinStr_INT64_MAX); }))) {
            mixin(enumMixinStr_INT64_MAX);
        }
    }




    static if(!is(typeof(INT32_MAX))) {
        private enum enumMixinStr_INT32_MAX = `enum INT32_MAX = 2147483647;`;
        static if(is(typeof({ mixin(enumMixinStr_INT32_MAX); }))) {
            mixin(enumMixinStr_INT32_MAX);
        }
    }




    static if(!is(typeof(INT16_MAX))) {
        private enum enumMixinStr_INT16_MAX = `enum INT16_MAX = 32767;`;
        static if(is(typeof({ mixin(enumMixinStr_INT16_MAX); }))) {
            mixin(enumMixinStr_INT16_MAX);
        }
    }




    static if(!is(typeof(INT8_MAX))) {
        private enum enumMixinStr_INT8_MAX = `enum INT8_MAX = 12;`;
        static if(is(typeof({ mixin(enumMixinStr_INT8_MAX); }))) {
            mixin(enumMixinStr_INT8_MAX);
        }
    }




    static if(!is(typeof(INT64_MIN))) {
        private enum enumMixinStr_INT64_MIN = `enum INT64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT64_MIN); }))) {
            mixin(enumMixinStr_INT64_MIN);
        }
    }




    static if(!is(typeof(INT32_MIN))) {
        private enum enumMixinStr_INT32_MIN = `enum INT32_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT32_MIN); }))) {
            mixin(enumMixinStr_INT32_MIN);
        }
    }




    static if(!is(typeof(INT16_MIN))) {
        private enum enumMixinStr_INT16_MIN = `enum INT16_MIN = ( - 32767 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT16_MIN); }))) {
            mixin(enumMixinStr_INT16_MIN);
        }
    }




    static if(!is(typeof(INT8_MIN))) {
        private enum enumMixinStr_INT8_MIN = `enum INT8_MIN = ( - 12 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT8_MIN); }))) {
            mixin(enumMixinStr_INT8_MIN);
        }
    }






    static if(!is(typeof(setjmp))) {
        private enum enumMixinStr_setjmp = `enum setjmp = _setjmp;`;
        static if(is(typeof({ mixin(enumMixinStr_setjmp); }))) {
            mixin(enumMixinStr_setjmp);
        }
    }






    static if(!is(typeof(_JBLEN))) {
        private enum enumMixinStr__JBLEN = `enum _JBLEN = 16;`;
        static if(is(typeof({ mixin(enumMixinStr__JBLEN); }))) {
            mixin(enumMixinStr__JBLEN);
        }
    }






    static if(!is(typeof(_Raises_SEH_exception_))) {
        private enum enumMixinStr__Raises_SEH_exception_ = `enum _Raises_SEH_exception_ = _SAL2_Source_ ( _Raises_SEH_exception_ , ( x ) , _Maybe_raises_SEH_exception_ _Analysis_noreturn_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Raises_SEH_exception_); }))) {
            mixin(enumMixinStr__Raises_SEH_exception_);
        }
    }




    static if(!is(typeof(_Maybe_raises_SEH_exception_))) {
        private enum enumMixinStr__Maybe_raises_SEH_exception_ = `enum _Maybe_raises_SEH_exception_ = _SAL2_Source_ ( _Maybe_raises_SEH_exception_ , ( x ) , _Pre_ _SA_annotes1 ( SAL_inTry , __yes ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Maybe_raises_SEH_exception_); }))) {
            mixin(enumMixinStr__Maybe_raises_SEH_exception_);
        }
    }




    static if(!is(typeof(_Strict_type_match_))) {
        private enum enumMixinStr__Strict_type_match_ = `enum _Strict_type_match_ = _SAL2_Source_ ( _Strict_type_match , ( ) , _SA_annotes0 ( SAL_strictType2 ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Strict_type_match_); }))) {
            mixin(enumMixinStr__Strict_type_match_);
        }
    }




    static if(!is(typeof(_Enum_is_bitflag_))) {
        private enum enumMixinStr__Enum_is_bitflag_ = `enum _Enum_is_bitflag_ = _SAL2_Source_ ( _Enum_is_bitflag_ , ( ) , _SA_annotes0 ( SAL_enumIsBitflag ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Enum_is_bitflag_); }))) {
            mixin(enumMixinStr__Enum_is_bitflag_);
        }
    }


    enum _dpp_impl__Function_class__mixin = ` auto _Function_class_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Function_class_ , ( arg0 ) , _SA_annotes1 ( SAL_functionClassNew , _SA_SPECSTRIZE ( arg0 ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Function_class__mixin); })) {
        mixin(_dpp_impl__Function_class__mixin);
    }


    enum _dpp_impl__Called_from_function_class__mixin = ` auto _Called_from_function_class_(A0)(A0 arg0) {
        return _In_function_class_ ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Called_from_function_class__mixin); })) {
        mixin(_dpp_impl__Called_from_function_class__mixin);
    }


    enum _dpp_impl__In_function_class__mixin = ` auto _In_function_class_(A0)(A0 arg0) {
        return _In_function_class_ ( "arg0" );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_function_class__mixin); })) {
        mixin(_dpp_impl__In_function_class__mixin);
    }


    enum _dpp_impl__Analysis_mode__mixin = ` auto _Analysis_mode_(A0)(A0 arg0) {
        return
 typedef _Analysis_mode_impl_ ( arg0 ) int __GENSYM ( __prefast_analysis_mode_flag ) ;;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Analysis_mode__mixin); })) {
        mixin(_dpp_impl__Analysis_mode__mixin);
    }


    enum _dpp_impl__Analysis_mode_impl__mixin = ` auto _Analysis_mode_impl_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Analysis_mode_impl_ , ( arg0 ) , _SA_annotes1 ( SAL_analysisMode , "arg0" ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Analysis_mode_impl__mixin); })) {
        mixin(_dpp_impl__Analysis_mode_impl__mixin);
    }
    enum _dpp_impl__Analysis_assume_nullterminated__mixin = ` auto _Analysis_assume_nullterminated_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Analysis_assume_nullterminated__mixin); })) {
        mixin(_dpp_impl__Analysis_assume_nullterminated__mixin);
    }




    static if(!is(typeof(_Analysis_noreturn_))) {
        private enum enumMixinStr__Analysis_noreturn_ = `enum _Analysis_noreturn_ = _SAL2_Source_ ( _Analysis_noreturn_ , ( ) , _SA_annotes0 ( SAL_terminates ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Analysis_noreturn_); }))) {
            mixin(enumMixinStr__Analysis_noreturn_);
        }
    }


    enum _dpp_impl__Analysis_assume__mixin = ` auto _Analysis_assume_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Analysis_assume__mixin); })) {
        mixin(_dpp_impl__Analysis_assume__mixin);
    }






    static if(!is(typeof(__fallthrough))) {
        private enum enumMixinStr___fallthrough = `enum __fallthrough = __inner_fallthrough;`;
        static if(is(typeof({ mixin(enumMixinStr___fallthrough); }))) {
            mixin(enumMixinStr___fallthrough);
        }
    }






    static if(!is(typeof(__useHeader))) {
        private enum enumMixinStr___useHeader = `enum __useHeader = _Use_decl_anno_impl_;`;
        static if(is(typeof({ mixin(enumMixinStr___useHeader); }))) {
            mixin(enumMixinStr___useHeader);
        }
    }
    static if(!is(typeof(__format_string))) {
        private enum enumMixinStr___format_string = `enum __format_string = _SAL1_1_Source_ ( __format_string , ( ) , _Printf_format_string_ );`;
        static if(is(typeof({ mixin(enumMixinStr___format_string); }))) {
            mixin(enumMixinStr___format_string);
        }
    }




    static if(!is(typeof(__callback))) {
        private enum enumMixinStr___callback = `enum __callback = __inner_callback;`;
        static if(is(typeof({ mixin(enumMixinStr___callback); }))) {
            mixin(enumMixinStr___callback);
        }
    }




    static if(!is(typeof(__override))) {
        private enum enumMixinStr___override = `enum __override = __inner_override;`;
        static if(is(typeof({ mixin(enumMixinStr___override); }))) {
            mixin(enumMixinStr___override);
        }
    }






    static if(!is(typeof(__checkReturn))) {
        private enum enumMixinStr___checkReturn = `enum __checkReturn = _SAL1_Source_ ( __checkReturn , ( ) , _Check_return_ );`;
        static if(is(typeof({ mixin(enumMixinStr___checkReturn); }))) {
            mixin(enumMixinStr___checkReturn);
        }
    }




    static if(!is(typeof(__reserved))) {
        private enum enumMixinStr___reserved = `enum __reserved = _SAL1_Source_ ( __reserved , ( ) , _Reserved_ );`;
        static if(is(typeof({ mixin(enumMixinStr___reserved); }))) {
            mixin(enumMixinStr___reserved);
        }
    }




    static if(!is(typeof(__nullnullterminated))) {
        private enum enumMixinStr___nullnullterminated = `enum __nullnullterminated = _SAL1_Source_ ( __nullnulltermiated , ( ) , _SAL_nop_impl_ );`;
        static if(is(typeof({ mixin(enumMixinStr___nullnullterminated); }))) {
            mixin(enumMixinStr___nullnullterminated);
        }
    }




    static if(!is(typeof(__nullterminated))) {
        private enum enumMixinStr___nullterminated = `enum __nullterminated = _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ );`;
        static if(is(typeof({ mixin(enumMixinStr___nullterminated); }))) {
            mixin(enumMixinStr___nullterminated);
        }
    }
    static if(!is(typeof(__deref_opt_inout_nz_opt))) {
        private enum enumMixinStr___deref_opt_inout_nz_opt = `enum __deref_opt_inout_nz_opt = _SAL1_Source_ ( __deref_opt_inout_nz_opt , ( ) , __deref_opt_inout_opt );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_opt_inout_nz_opt); }))) {
            mixin(enumMixinStr___deref_opt_inout_nz_opt);
        }
    }
    static if(!is(typeof(__deref_opt_inout_z_opt))) {
        private enum enumMixinStr___deref_opt_inout_z_opt = `enum __deref_opt_inout_z_opt = _SAL1_Source_ ( __deref_opt_inout_z_opt , ( ) , __deref_opt_inout_opt __pre __deref _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ ) __post __deref _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_opt_inout_z_opt); }))) {
            mixin(enumMixinStr___deref_opt_inout_z_opt);
        }
    }
    static if(!is(typeof(__deref_opt_inout_opt))) {
        private enum enumMixinStr___deref_opt_inout_opt = `enum __deref_opt_inout_opt = _SAL1_Source_ ( __deref_opt_inout_opt , ( ) , __deref_inout_opt __pre_except_maybenull );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_opt_inout_opt); }))) {
            mixin(enumMixinStr___deref_opt_inout_opt);
        }
    }
    static if(!is(typeof(__deref_opt_out_nz_opt))) {
        private enum enumMixinStr___deref_opt_out_nz_opt = `enum __deref_opt_out_nz_opt = _SAL1_Source_ ( __deref_opt_out_nz_opt , ( ) , __deref_opt_out_opt );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_opt_out_nz_opt); }))) {
            mixin(enumMixinStr___deref_opt_out_nz_opt);
        }
    }
    static if(!is(typeof(__deref_opt_out_z_opt))) {
        private enum enumMixinStr___deref_opt_out_z_opt = `enum __deref_opt_out_z_opt = _SAL1_Source_ ( __deref_opt_out_z_opt , ( ) , __post __deref __valid __refparam __pre_except_maybenull __pre_deref_except_maybenull __post_deref_except_maybenull __post __deref _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_opt_out_z_opt); }))) {
            mixin(enumMixinStr___deref_opt_out_z_opt);
        }
    }
    static if(!is(typeof(__deref_opt_out_opt))) {
        private enum enumMixinStr___deref_opt_out_opt = `enum __deref_opt_out_opt = _SAL1_Source_ ( __deref_opt_out_opt , ( ) , _Outptr_opt_result_maybenull_ );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_opt_out_opt); }))) {
            mixin(enumMixinStr___deref_opt_out_opt);
        }
    }
    static if(!is(typeof(__deref_opt_inout_nz))) {
        private enum enumMixinStr___deref_opt_inout_nz = `enum __deref_opt_inout_nz = _SAL1_Source_ ( __deref_opt_inout_nz , ( ) , __deref_opt_inout );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_opt_inout_nz); }))) {
            mixin(enumMixinStr___deref_opt_inout_nz);
        }
    }
    static if(!is(typeof(__deref_opt_inout_z))) {
        private enum enumMixinStr___deref_opt_inout_z = `enum __deref_opt_inout_z = _SAL1_Source_ ( __deref_opt_inout_z , ( ) , __deref_opt_inout __pre __deref _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ ) __post __deref _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_opt_inout_z); }))) {
            mixin(enumMixinStr___deref_opt_inout_z);
        }
    }
    static if(!is(typeof(__deref_opt_inout))) {
        private enum enumMixinStr___deref_opt_inout = `enum __deref_opt_inout = _SAL1_Source_ ( __deref_opt_inout , ( ) , _Inout_opt_ );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_opt_inout); }))) {
            mixin(enumMixinStr___deref_opt_inout);
        }
    }
    static if(!is(typeof(__deref_opt_out_z))) {
        private enum enumMixinStr___deref_opt_out_z = `enum __deref_opt_out_z = _SAL1_Source_ ( __deref_opt_out_z , ( ) , _Outptr_opt_result_z_ );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_opt_out_z); }))) {
            mixin(enumMixinStr___deref_opt_out_z);
        }
    }




    static if(!is(typeof(__deref_opt_out))) {
        private enum enumMixinStr___deref_opt_out = `enum __deref_opt_out = _SAL1_Source_ ( __deref_opt_out , ( ) , _Outptr_opt_ );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_opt_out); }))) {
            mixin(enumMixinStr___deref_opt_out);
        }
    }
    static if(!is(typeof(__deref_inout_nz_opt))) {
        private enum enumMixinStr___deref_inout_nz_opt = `enum __deref_inout_nz_opt = _SAL1_Source_ ( __deref_inout_nz_opt , ( ) , __deref_inout_opt );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_inout_nz_opt); }))) {
            mixin(enumMixinStr___deref_inout_nz_opt);
        }
    }
    static if(!is(typeof(__deref_inout_z_opt))) {
        private enum enumMixinStr___deref_inout_z_opt = `enum __deref_inout_z_opt = _SAL1_Source_ ( __deref_inout_z_opt , ( ) , __deref_inout_opt __pre __deref _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ ) __post __deref _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_inout_z_opt); }))) {
            mixin(enumMixinStr___deref_inout_z_opt);
        }
    }
    static if(!is(typeof(__deref_inout_opt))) {
        private enum enumMixinStr___deref_inout_opt = `enum __deref_inout_opt = _SAL1_Source_ ( __deref_inout_opt , ( ) , __deref_inout __pre_deref_except_maybenull __post_deref_except_maybenull );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_inout_opt); }))) {
            mixin(enumMixinStr___deref_inout_opt);
        }
    }
    static if(!is(typeof(__deref_out_nz_opt))) {
        private enum enumMixinStr___deref_out_nz_opt = `enum __deref_out_nz_opt = _SAL1_Source_ ( __deref_out_nz_opt , ( ) , __deref_out_opt );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_out_nz_opt); }))) {
            mixin(enumMixinStr___deref_out_nz_opt);
        }
    }
    static if(!is(typeof(__deref_out_z_opt))) {
        private enum enumMixinStr___deref_out_z_opt = `enum __deref_out_z_opt = _SAL1_Source_ ( __deref_out_z_opt , ( ) , _Outptr_result_maybenull_z_ );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_out_z_opt); }))) {
            mixin(enumMixinStr___deref_out_z_opt);
        }
    }
    static if(!is(typeof(__deref_out_opt))) {
        private enum enumMixinStr___deref_out_opt = `enum __deref_out_opt = _SAL1_Source_ ( __deref_out_opt , ( ) , __deref_out __post_deref_except_maybenull );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_out_opt); }))) {
            mixin(enumMixinStr___deref_out_opt);
        }
    }
    static if(!is(typeof(__deref_inout_nz))) {
        private enum enumMixinStr___deref_inout_nz = `enum __deref_inout_nz = _SAL1_Source_ ( __deref_inout_nz , ( ) , __deref_inout );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_inout_nz); }))) {
            mixin(enumMixinStr___deref_inout_nz);
        }
    }
    static if(!is(typeof(__deref_inout_z))) {
        private enum enumMixinStr___deref_inout_z = `enum __deref_inout_z = _SAL1_Source_ ( __deref_inout_z , ( ) , __deref_inout __pre __deref _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ ) __post _Notref_ __deref _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_inout_z); }))) {
            mixin(enumMixinStr___deref_inout_z);
        }
    }




    static if(!is(typeof(__deref_inout))) {
        private enum enumMixinStr___deref_inout = `enum __deref_inout = _SAL1_Source_ ( __deref_inout , ( ) , _Notref_ __notnull _Notref_ __elem_readableTo ( 1 ) __pre __deref __valid __post _Notref_ __deref __valid __refparam );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_inout); }))) {
            mixin(enumMixinStr___deref_inout);
        }
    }
    static if(!is(typeof(__deref_out_nz))) {
        private enum enumMixinStr___deref_out_nz = `enum __deref_out_nz = _SAL1_Source_ ( __deref_out_nz , ( ) , __deref_out );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_out_nz); }))) {
            mixin(enumMixinStr___deref_out_nz);
        }
    }
    static if(!is(typeof(__deref_out_z))) {
        private enum enumMixinStr___deref_out_z = `enum __deref_out_z = _SAL1_Source_ ( __deref_out_z , ( ) , _Outptr_result_z_ );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_out_z); }))) {
            mixin(enumMixinStr___deref_out_z);
        }
    }
    static if(!is(typeof(__deref_out))) {
        private enum enumMixinStr___deref_out = `enum __deref_out = _SAL1_Source_ ( __deref_out , ( ) , _Outptr_ );`;
        static if(is(typeof({ mixin(enumMixinStr___deref_out); }))) {
            mixin(enumMixinStr___deref_out);
        }
    }
    static if(!is(typeof(__inout_nz_opt))) {
        private enum enumMixinStr___inout_nz_opt = `enum __inout_nz_opt = _SAL1_Source_ ( __inout_nz_opt , ( ) , __inout_opt );`;
        static if(is(typeof({ mixin(enumMixinStr___inout_nz_opt); }))) {
            mixin(enumMixinStr___inout_nz_opt);
        }
    }
    static if(!is(typeof(__inout_z_opt))) {
        private enum enumMixinStr___inout_z_opt = `enum __inout_z_opt = _SAL1_Source_ ( __inout_z_opt , ( ) , __inout_opt __pre _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ ) __post _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___inout_z_opt); }))) {
            mixin(enumMixinStr___inout_z_opt);
        }
    }
    static if(!is(typeof(PDF_MRANGE_CAP))) {
        private enum enumMixinStr_PDF_MRANGE_CAP = `enum PDF_MRANGE_CAP = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_PDF_MRANGE_CAP); }))) {
            mixin(enumMixinStr_PDF_MRANGE_CAP);
        }
    }
    static if(!is(typeof(__inout_opt))) {
        private enum enumMixinStr___inout_opt = `enum __inout_opt = _SAL1_Source_ ( __inout_opt , ( ) , _Inout_opt_ );`;
        static if(is(typeof({ mixin(enumMixinStr___inout_opt); }))) {
            mixin(enumMixinStr___inout_opt);
        }
    }
    static if(!is(typeof(__out_opt))) {
        private enum enumMixinStr___out_opt = `enum __out_opt = _SAL1_Source_ ( __out_opt , ( ) , _Out_opt_ );`;
        static if(is(typeof({ mixin(enumMixinStr___out_opt); }))) {
            mixin(enumMixinStr___out_opt);
        }
    }
    static if(!is(typeof(__in_nz_opt))) {
        private enum enumMixinStr___in_nz_opt = `enum __in_nz_opt = _SAL1_Source_ ( __in_nz_opt , ( ) , __in_opt );`;
        static if(is(typeof({ mixin(enumMixinStr___in_nz_opt); }))) {
            mixin(enumMixinStr___in_nz_opt);
        }
    }
    static if(!is(typeof(__in_z_opt))) {
        private enum enumMixinStr___in_z_opt = `enum __in_z_opt = _SAL1_Source_ ( __in_z_opt , ( ) , _In_opt_z_ );`;
        static if(is(typeof({ mixin(enumMixinStr___in_z_opt); }))) {
            mixin(enumMixinStr___in_z_opt);
        }
    }
    static if(!is(typeof(__in_opt))) {
        private enum enumMixinStr___in_opt = `enum __in_opt = _SAL1_Source_ ( __in_opt , ( ) , _In_opt_ );`;
        static if(is(typeof({ mixin(enumMixinStr___in_opt); }))) {
            mixin(enumMixinStr___in_opt);
        }
    }
    static if(!is(typeof(__inout_nz))) {
        private enum enumMixinStr___inout_nz = `enum __inout_nz = _SAL1_Source_ ( __inout_nz , ( ) , __inout );`;
        static if(is(typeof({ mixin(enumMixinStr___inout_nz); }))) {
            mixin(enumMixinStr___inout_nz);
        }
    }
    static if(!is(typeof(__inout_z))) {
        private enum enumMixinStr___inout_z = `enum __inout_z = _SAL1_Source_ ( __inout_z , ( ) , _Inout_z_ );`;
        static if(is(typeof({ mixin(enumMixinStr___inout_z); }))) {
            mixin(enumMixinStr___inout_z);
        }
    }
    static if(!is(typeof(__inout))) {
        private enum enumMixinStr___inout = `enum __inout = _SAL1_Source_ ( __inout , ( ) , _Inout_ );`;
        static if(is(typeof({ mixin(enumMixinStr___inout); }))) {
            mixin(enumMixinStr___inout);
        }
    }
    static if(!is(typeof(__out_nz_opt))) {
        private enum enumMixinStr___out_nz_opt = `enum __out_nz_opt = _SAL1_Source_ ( __out_nz_opt , ( ) , __post __valid __refparam __post_except_maybenull_ );`;
        static if(is(typeof({ mixin(enumMixinStr___out_nz_opt); }))) {
            mixin(enumMixinStr___out_nz_opt);
        }
    }




    static if(!is(typeof(__out_nz))) {
        private enum enumMixinStr___out_nz = `enum __out_nz = _SAL1_Source_ ( __out_nz , ( ) , __post __valid __refparam );`;
        static if(is(typeof({ mixin(enumMixinStr___out_nz); }))) {
            mixin(enumMixinStr___out_nz);
        }
    }
    static if(!is(typeof(__out_z_opt))) {
        private enum enumMixinStr___out_z_opt = `enum __out_z_opt = _SAL1_Source_ ( __out_z_opt , ( ) , __post __valid __refparam __post _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ ) __pre_except_maybenull );`;
        static if(is(typeof({ mixin(enumMixinStr___out_z_opt); }))) {
            mixin(enumMixinStr___out_z_opt);
        }
    }




    static if(!is(typeof(__out_z))) {
        private enum enumMixinStr___out_z = `enum __out_z = _SAL1_Source_ ( __out_z , ( ) , __post __valid __refparam __post _SAL1_Source_ ( __nullterminated , ( ) , _Null_terminated_ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___out_z); }))) {
            mixin(enumMixinStr___out_z);
        }
    }
    static if(!is(typeof(__out))) {
        private enum enumMixinStr___out = `enum __out = _SAL1_Source_ ( __out , ( ) , _Out_ );`;
        static if(is(typeof({ mixin(enumMixinStr___out); }))) {
            mixin(enumMixinStr___out);
        }
    }
    static if(!is(typeof(__in_nz))) {
        private enum enumMixinStr___in_nz = `enum __in_nz = _SAL1_Source_ ( __in_nz , ( ) , __in );`;
        static if(is(typeof({ mixin(enumMixinStr___in_nz); }))) {
            mixin(enumMixinStr___in_nz);
        }
    }
    static if(!is(typeof(__in_z))) {
        private enum enumMixinStr___in_z = `enum __in_z = _SAL1_Source_ ( __in_z , ( ) , _In_z_ );`;
        static if(is(typeof({ mixin(enumMixinStr___in_z); }))) {
            mixin(enumMixinStr___in_z);
        }
    }
    static if(!is(typeof(__in))) {
        private enum enumMixinStr___in = `enum __in = _SAL1_Source_ ( __in , ( ) , _In_ );`;
        static if(is(typeof({ mixin(enumMixinStr___in); }))) {
            mixin(enumMixinStr___in);
        }
    }
    enum _dpp_impl__Writable_elements_impl__mixin = ` auto _Writable_elements_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Writable_elements_impl__mixin); })) {
        mixin(_dpp_impl__Writable_elements_impl__mixin);
    }


    enum _dpp_impl__Writable_bytes_impl__mixin = ` auto _Writable_bytes_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Writable_bytes_impl__mixin); })) {
        mixin(_dpp_impl__Writable_bytes_impl__mixin);
    }


    enum _dpp_impl__Readable_elements_impl__mixin = ` auto _Readable_elements_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Readable_elements_impl__mixin); })) {
        mixin(_dpp_impl__Readable_elements_impl__mixin);
    }


    enum _dpp_impl__Readable_bytes_impl__mixin = ` auto _Readable_bytes_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Readable_bytes_impl__mixin); })) {
        mixin(_dpp_impl__Readable_bytes_impl__mixin);
    }


    enum _dpp_impl__Deref2_ret1_impl__mixin = ` auto _Deref2_ret1_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref2_ret1_impl__mixin); })) {
        mixin(_dpp_impl__Deref2_ret1_impl__mixin);
    }


    enum _dpp_impl__Deref2_post1_impl__mixin = ` auto _Deref2_post1_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref2_post1_impl__mixin); })) {
        mixin(_dpp_impl__Deref2_post1_impl__mixin);
    }


    enum _dpp_impl__Deref2_pre1_impl__mixin = ` auto _Deref2_pre1_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref2_pre1_impl__mixin); })) {
        mixin(_dpp_impl__Deref2_pre1_impl__mixin);
    }


    enum _dpp_impl__Deref_ret3_impl__mixin = ` auto _Deref_ret3_impl_(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_ret3_impl__mixin); })) {
        mixin(_dpp_impl__Deref_ret3_impl__mixin);
    }


    enum _dpp_impl__Deref_ret2_impl__mixin = ` auto _Deref_ret2_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_ret2_impl__mixin); })) {
        mixin(_dpp_impl__Deref_ret2_impl__mixin);
    }


    enum _dpp_impl__Deref_ret1_impl__mixin = ` auto _Deref_ret1_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_ret1_impl__mixin); })) {
        mixin(_dpp_impl__Deref_ret1_impl__mixin);
    }


    enum _dpp_impl__Deref_post3_impl__mixin = ` auto _Deref_post3_impl_(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post3_impl__mixin); })) {
        mixin(_dpp_impl__Deref_post3_impl__mixin);
    }


    enum _dpp_impl__Deref_post2_impl__mixin = ` auto _Deref_post2_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post2_impl__mixin); })) {
        mixin(_dpp_impl__Deref_post2_impl__mixin);
    }


    enum _dpp_impl__Deref_post1_impl__mixin = ` auto _Deref_post1_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post1_impl__mixin); })) {
        mixin(_dpp_impl__Deref_post1_impl__mixin);
    }


    enum _dpp_impl__Deref_pre3_impl__mixin = ` auto _Deref_pre3_impl_(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre3_impl__mixin); })) {
        mixin(_dpp_impl__Deref_pre3_impl__mixin);
    }


    enum _dpp_impl__Deref_pre2_impl__mixin = ` auto _Deref_pre2_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre2_impl__mixin); })) {
        mixin(_dpp_impl__Deref_pre2_impl__mixin);
    }


    enum _dpp_impl__Deref_pre1_impl__mixin = ` auto _Deref_pre1_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre1_impl__mixin); })) {
        mixin(_dpp_impl__Deref_pre1_impl__mixin);
    }


    enum _dpp_impl__Ret3_impl__mixin = ` auto _Ret3_impl_(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret3_impl__mixin); })) {
        mixin(_dpp_impl__Ret3_impl__mixin);
    }


    enum _dpp_impl__Ret2_impl__mixin = ` auto _Ret2_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret2_impl__mixin); })) {
        mixin(_dpp_impl__Ret2_impl__mixin);
    }


    enum _dpp_impl__Ret1_impl__mixin = ` auto _Ret1_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret1_impl__mixin); })) {
        mixin(_dpp_impl__Ret1_impl__mixin);
    }


    enum _dpp_impl__Post3_impl__mixin = ` auto _Post3_impl_(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post3_impl__mixin); })) {
        mixin(_dpp_impl__Post3_impl__mixin);
    }


    enum _dpp_impl__Post2_impl__mixin = ` auto _Post2_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post2_impl__mixin); })) {
        mixin(_dpp_impl__Post2_impl__mixin);
    }


    enum _dpp_impl__Post1_impl__mixin = ` auto _Post1_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post1_impl__mixin); })) {
        mixin(_dpp_impl__Post1_impl__mixin);
    }




    enum _dpp_impl__Pre3_impl__mixin = ` auto _Pre3_impl_(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre3_impl__mixin); })) {
        mixin(_dpp_impl__Pre3_impl__mixin);
    }


    enum _dpp_impl__Pre2_impl__mixin = ` auto _Pre2_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre2_impl__mixin); })) {
        mixin(_dpp_impl__Pre2_impl__mixin);
    }


    enum _dpp_impl__Pre1_impl__mixin = ` auto _Pre1_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre1_impl__mixin); })) {
        mixin(_dpp_impl__Pre1_impl__mixin);
    }




    enum _dpp_impl__Field_range_impl__mixin = ` auto _Field_range_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_range_impl__mixin); })) {
        mixin(_dpp_impl__Field_range_impl__mixin);
    }
    enum _dpp_impl__Post_satisfies_impl__mixin = ` auto _Post_satisfies_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_satisfies_impl__mixin); })) {
        mixin(_dpp_impl__Post_satisfies_impl__mixin);
    }


    enum _dpp_impl__Pre_satisfies_impl__mixin = ` auto _Pre_satisfies_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_satisfies_impl__mixin); })) {
        mixin(_dpp_impl__Pre_satisfies_impl__mixin);
    }


    enum _dpp_impl__Satisfies_impl__mixin = ` auto _Satisfies_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Satisfies_impl__mixin); })) {
        mixin(_dpp_impl__Satisfies_impl__mixin);
    }


    enum _dpp_impl__Deref_ret_range_impl__mixin = ` auto _Deref_ret_range_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_ret_range_impl__mixin); })) {
        mixin(_dpp_impl__Deref_ret_range_impl__mixin);
    }


    enum _dpp_impl__Deref_out_range_impl__mixin = ` auto _Deref_out_range_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_out_range_impl__mixin); })) {
        mixin(_dpp_impl__Deref_out_range_impl__mixin);
    }


    enum _dpp_impl__Deref_in_range_impl__mixin = ` auto _Deref_in_range_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_in_range_impl__mixin); })) {
        mixin(_dpp_impl__Deref_in_range_impl__mixin);
    }


    enum _dpp_impl__Ret_range_impl__mixin = ` auto _Ret_range_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_range_impl__mixin); })) {
        mixin(_dpp_impl__Ret_range_impl__mixin);
    }


    enum _dpp_impl__Out_range_impl__mixin = ` auto _Out_range_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_range_impl__mixin); })) {
        mixin(_dpp_impl__Out_range_impl__mixin);
    }


    enum _dpp_impl__In_range_impl__mixin = ` auto _In_range_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_range_impl__mixin); })) {
        mixin(_dpp_impl__In_range_impl__mixin);
    }


    enum _dpp_impl__Range_impl__mixin = ` auto _Range_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Range_impl__mixin); })) {
        mixin(_dpp_impl__Range_impl__mixin);
    }
    enum _dpp_impl__Always_impl__mixin = ` auto _Always_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Always_impl__mixin); })) {
        mixin(_dpp_impl__Always_impl__mixin);
    }


    enum _dpp_impl__On_failure_impl__mixin = ` auto _On_failure_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__On_failure_impl__mixin); })) {
        mixin(_dpp_impl__On_failure_impl__mixin);
    }


    enum _dpp_impl__Success_impl__mixin = ` auto _Success_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Success_impl__mixin); })) {
        mixin(_dpp_impl__Success_impl__mixin);
    }
    enum _dpp_impl__At_buffer_impl__mixin = ` auto _At_buffer_impl_(A0, A1, A2, A3)(A0 arg0, A1 arg1, A2 arg2, A3 arg3) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__At_buffer_impl__mixin); })) {
        mixin(_dpp_impl__At_buffer_impl__mixin);
    }


    enum _dpp_impl__GrouP_impl__mixin = ` auto _GrouP_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__GrouP_impl__mixin); })) {
        mixin(_dpp_impl__GrouP_impl__mixin);
    }


    enum _dpp_impl__Group_impl__mixin = ` auto _Group_impl_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Group_impl__mixin); })) {
        mixin(_dpp_impl__Group_impl__mixin);
    }


    enum _dpp_impl__When_impl__mixin = ` auto _When_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__When_impl__mixin); })) {
        mixin(_dpp_impl__When_impl__mixin);
    }


    enum _dpp_impl__At_impl__mixin = ` auto _At_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__At_impl__mixin); })) {
        mixin(_dpp_impl__At_impl__mixin);
    }




    static if(!is(typeof(_SAL_nop_impl_))) {
        private enum enumMixinStr__SAL_nop_impl_ = `enum _SAL_nop_impl_ = X;`;
        static if(is(typeof({ mixin(enumMixinStr__SAL_nop_impl_); }))) {
            mixin(enumMixinStr__SAL_nop_impl_);
        }
    }
    enum _dpp_impl__SA_annotes3_mixin = ` auto _SA_annotes3(A0, A1, A2, A3)(A0 arg0, A1 arg1, A2 arg2, A3 arg3) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__SA_annotes3_mixin); })) {
        mixin(_dpp_impl__SA_annotes3_mixin);
    }


    enum _dpp_impl__SA_annotes2_mixin = ` auto _SA_annotes2(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__SA_annotes2_mixin); })) {
        mixin(_dpp_impl__SA_annotes2_mixin);
    }


    enum _dpp_impl__SA_annotes1_mixin = ` auto _SA_annotes1(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__SA_annotes1_mixin); })) {
        mixin(_dpp_impl__SA_annotes1_mixin);
    }


    enum _dpp_impl__SA_annotes0_mixin = ` auto _SA_annotes0(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__SA_annotes0_mixin); })) {
        mixin(_dpp_impl__SA_annotes0_mixin);
    }




    static if(!is(typeof(_Deref_inout_z_))) {
        private enum enumMixinStr__Deref_inout_z_ = `enum _Deref_inout_z_ = _SAL1_1_Source_ ( _Deref_inout_z_ , ( ) , _Deref_prepost_z_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_inout_z_); }))) {
            mixin(enumMixinStr__Deref_inout_z_);
        }
    }


    enum _dpp_impl__Deref_inout_z_bytecap_c__mixin = ` auto _Deref_inout_z_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_inout_z_bytecap_c_ , ( arg0 ) , _Deref_pre_z_bytecap_c_ ( arg0 ) _Deref_post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_inout_z_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_inout_z_bytecap_c__mixin);
    }


    enum _dpp_impl__Deref_out_z_bytecap_c__mixin = ` auto _Deref_out_z_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_out_z_bytecap_c_ , ( arg0 ) , _Deref_pre_bytecap_c_ ( arg0 ) _Deref_post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_out_z_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_out_z_bytecap_c__mixin);
    }


    enum _dpp_impl__Deref_inout_z_cap_c__mixin = ` auto _Deref_inout_z_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_inout_z_cap_c_ , ( arg0 ) , _Deref_pre_z_cap_c_ ( arg0 ) _Deref_post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_inout_z_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_inout_z_cap_c__mixin);
    }




    enum _dpp_impl__Deref_out_z_cap_c__mixin = ` auto _Deref_out_z_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_out_z_cap_c_ , ( arg0 ) , _Deref_pre_cap_c_ ( arg0 ) _Deref_post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_out_z_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_out_z_cap_c__mixin);
    }




    static if(!is(typeof(_Deref_prepost_opt_valid_))) {
        private enum enumMixinStr__Deref_prepost_opt_valid_ = `enum _Deref_prepost_opt_valid_ = _SAL1_1_Source_ ( _Deref_prepost_opt_valid_ , ( ) , _Deref_pre_opt_valid_ _Deref_post_opt_valid_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_prepost_opt_valid_); }))) {
            mixin(enumMixinStr__Deref_prepost_opt_valid_);
        }
    }




    static if(!is(typeof(_Deref_prepost_valid_))) {
        private enum enumMixinStr__Deref_prepost_valid_ = `enum _Deref_prepost_valid_ = _SAL1_1_Source_ ( _Deref_prepost_valid_ , ( ) , _Deref_pre_valid_ _Deref_post_valid_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_prepost_valid_); }))) {
            mixin(enumMixinStr__Deref_prepost_valid_);
        }
    }


    enum _dpp_impl__Deref_prepost_opt_bytecount_x__mixin = ` auto _Deref_prepost_opt_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_bytecount_x_ , ( arg0 ) , _Deref_pre_opt_bytecount_x_ ( arg0 ) _Deref_post_opt_bytecount_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_bytecount_x__mixin);
    }


    enum _dpp_impl__Deref_prepost_bytecount_x__mixin = ` auto _Deref_prepost_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_bytecount_x_ , ( arg0 ) , _Deref_pre_bytecount_x_ ( arg0 ) _Deref_post_bytecount_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_bytecount_x__mixin);
    }


    enum _dpp_impl__Deref_prepost_opt_count_x__mixin = ` auto _Deref_prepost_opt_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_count_x_ , ( arg0 ) , _Deref_pre_opt_count_x_ ( arg0 ) _Deref_post_opt_count_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_count_x__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_count_x__mixin);
    }


    enum _dpp_impl__Deref_prepost_count_x__mixin = ` auto _Deref_prepost_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_count_x_ , ( arg0 ) , _Deref_pre_count_x_ ( arg0 ) _Deref_post_count_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_count_x__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_count_x__mixin);
    }


    enum _dpp_impl__Deref_prepost_opt_bytecount__mixin = ` auto _Deref_prepost_opt_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_bytecount_ , ( arg0 ) , _Deref_pre_opt_bytecount_ ( arg0 ) _Deref_post_opt_bytecount_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_bytecount__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_bytecount__mixin);
    }


    enum _dpp_impl__Deref_prepost_bytecount__mixin = ` auto _Deref_prepost_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_bytecount_ , ( arg0 ) , _Deref_pre_bytecount_ ( arg0 ) _Deref_post_bytecount_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_bytecount__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_bytecount__mixin);
    }


    enum _dpp_impl__Deref_prepost_opt_count__mixin = ` auto _Deref_prepost_opt_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_count_ , ( arg0 ) , _Deref_pre_opt_count_ ( arg0 ) _Deref_post_opt_count_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_count__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_count__mixin);
    }


    enum _dpp_impl__Deref_prepost_count__mixin = ` auto _Deref_prepost_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_count_ , ( arg0 ) , _Deref_pre_count_ ( arg0 ) _Deref_post_count_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_count__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_count__mixin);
    }


    enum _dpp_impl__Deref_prepost_opt_valid_bytecap_x__mixin = ` auto _Deref_prepost_opt_valid_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_valid_bytecap_x_ , ( arg0 ) , _Deref_pre_opt_valid_bytecap_x_ ( arg0 ) _Deref_post_opt_valid_bytecap_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_valid_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_valid_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_prepost_valid_bytecap_x__mixin = ` auto _Deref_prepost_valid_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_valid_bytecap_x_ , ( arg0 ) , _Deref_pre_valid_bytecap_x_ ( arg0 ) _Deref_post_valid_bytecap_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_valid_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_valid_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_prepost_opt_valid_cap_x__mixin = ` auto _Deref_prepost_opt_valid_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_valid_cap_x_ , ( arg0 ) , _Deref_pre_opt_valid_cap_x_ ( arg0 ) _Deref_post_opt_valid_cap_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_valid_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_valid_cap_x__mixin);
    }


    enum _dpp_impl__Deref_prepost_valid_cap_x__mixin = ` auto _Deref_prepost_valid_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_valid_cap_x_ , ( arg0 ) , _Deref_pre_valid_cap_x_ ( arg0 ) _Deref_post_valid_cap_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_valid_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_valid_cap_x__mixin);
    }


    enum _dpp_impl__Deref_prepost_opt_valid_bytecap__mixin = ` auto _Deref_prepost_opt_valid_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_valid_bytecap_ , ( arg0 ) , _Deref_pre_opt_valid_bytecap_ ( arg0 ) _Deref_post_opt_valid_bytecap_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_valid_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_valid_bytecap__mixin);
    }


    enum _dpp_impl__Deref_prepost_valid_bytecap__mixin = ` auto _Deref_prepost_valid_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_valid_bytecap_ , ( arg0 ) , _Deref_pre_valid_bytecap_ ( arg0 ) _Deref_post_valid_bytecap_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_valid_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_valid_bytecap__mixin);
    }


    enum _dpp_impl__Deref_prepost_opt_valid_cap__mixin = ` auto _Deref_prepost_opt_valid_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_valid_cap_ , ( arg0 ) , _Deref_pre_opt_valid_cap_ ( arg0 ) _Deref_post_opt_valid_cap_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_valid_cap__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_valid_cap__mixin);
    }


    enum _dpp_impl__Deref_prepost_valid_cap__mixin = ` auto _Deref_prepost_valid_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_valid_cap_ , ( arg0 ) , _Deref_pre_valid_cap_ ( arg0 ) _Deref_post_valid_cap_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_valid_cap__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_valid_cap__mixin);
    }


    enum _dpp_impl__Deref_prepost_opt_z_bytecap__mixin = ` auto _Deref_prepost_opt_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_z_bytecap_ , ( arg0 ) , _Deref_pre_opt_z_bytecap_ ( arg0 ) _Deref_post_opt_z_bytecap_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_z_bytecap__mixin);
    }


    enum _dpp_impl__Deref_prepost_z_bytecap__mixin = ` auto _Deref_prepost_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_z_bytecap_ , ( arg0 ) , _Deref_pre_z_bytecap_ ( arg0 ) _Deref_post_z_bytecap_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_z_bytecap__mixin);
    }


    enum _dpp_impl__Deref_prepost_opt_z_cap__mixin = ` auto _Deref_prepost_opt_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_z_cap_ , ( arg0 ) , _Deref_pre_opt_z_cap_ ( arg0 ) _Deref_post_opt_z_cap_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_z_cap__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_z_cap__mixin);
    }


    enum _dpp_impl__Deref_prepost_z_cap__mixin = ` auto _Deref_prepost_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_z_cap_ , ( arg0 ) , _Deref_pre_z_cap_ ( arg0 ) _Deref_post_z_cap_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_z_cap__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_z_cap__mixin);
    }


    enum _dpp_impl__Deref_prepost_opt_bytecap_x__mixin = ` auto _Deref_prepost_opt_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_bytecap_x_ , ( arg0 ) , _Deref_pre_opt_bytecap_x_ ( arg0 ) _Deref_post_opt_bytecap_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_prepost_bytecap_x__mixin = ` auto _Deref_prepost_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_bytecap_x_ , ( arg0 ) , _Deref_pre_bytecap_x_ ( arg0 ) _Deref_post_bytecap_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_prepost_opt_cap_x__mixin = ` auto _Deref_prepost_opt_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_cap_x_ , ( arg0 ) , _Deref_pre_opt_cap_x_ ( arg0 ) _Deref_post_opt_cap_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_cap_x__mixin);
    }


    enum _dpp_impl__Deref_prepost_cap_x__mixin = ` auto _Deref_prepost_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_cap_x_ , ( arg0 ) , _Deref_pre_cap_x_ ( arg0 ) _Deref_post_cap_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_cap_x__mixin);
    }


    enum _dpp_impl__Deref_prepost_opt_bytecap__mixin = ` auto _Deref_prepost_opt_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_bytecap_ , ( arg0 ) , _Deref_pre_opt_bytecap_ ( arg0 ) _Deref_post_opt_bytecap_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_bytecap__mixin);
    }


    enum _dpp_impl__Deref_prepost_bytecap__mixin = ` auto _Deref_prepost_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_bytecap_ , ( arg0 ) , _Deref_pre_bytecap_ ( arg0 ) _Deref_post_bytecap_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_bytecap__mixin);
    }


    enum _dpp_impl__Deref_prepost_opt_cap__mixin = ` auto _Deref_prepost_opt_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_opt_cap_ , ( arg0 ) , _Deref_pre_opt_cap_ ( arg0 ) _Deref_post_opt_cap_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_opt_cap__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_opt_cap__mixin);
    }


    enum _dpp_impl__Deref_prepost_cap__mixin = ` auto _Deref_prepost_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_prepost_cap_ , ( arg0 ) , _Deref_pre_cap_ ( arg0 ) _Deref_post_cap_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_prepost_cap__mixin); })) {
        mixin(_dpp_impl__Deref_prepost_cap__mixin);
    }




    static if(!is(typeof(_Deref_prepost_opt_z_))) {
        private enum enumMixinStr__Deref_prepost_opt_z_ = `enum _Deref_prepost_opt_z_ = _SAL1_1_Source_ ( _Deref_prepost_opt_z_ , ( ) , _Deref_pre_opt_z_ _Deref_post_opt_z_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_prepost_opt_z_); }))) {
            mixin(enumMixinStr__Deref_prepost_opt_z_);
        }
    }




    static if(!is(typeof(_Deref_prepost_z_))) {
        private enum enumMixinStr__Deref_prepost_z_ = `enum _Deref_prepost_z_ = _SAL1_1_Source_ ( _Deref_prepost_z_ , ( ) , _Deref_pre_z_ _Deref_post_z_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_prepost_z_); }))) {
            mixin(enumMixinStr__Deref_prepost_z_);
        }
    }




    static if(!is(typeof(_Prepost_opt_valid_))) {
        private enum enumMixinStr__Prepost_opt_valid_ = `enum _Prepost_opt_valid_ = _SAL1_1_Source_ ( _Prepost_opt_valid_ , ( ) , _Pre_opt_valid_ _Post_valid_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Prepost_opt_valid_); }))) {
            mixin(enumMixinStr__Prepost_opt_valid_);
        }
    }




    static if(!is(typeof(_Prepost_valid_))) {
        private enum enumMixinStr__Prepost_valid_ = `enum _Prepost_valid_ = _SAL1_1_Source_ ( _Prepost_valid_ , ( ) , _Pre_valid_ _Post_valid_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Prepost_valid_); }))) {
            mixin(enumMixinStr__Prepost_valid_);
        }
    }


    enum _dpp_impl__Prepost_opt_bytecount_x__mixin = ` auto _Prepost_opt_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Prepost_opt_bytecount_x_ , ( arg0 ) , _Pre_opt_bytecount_x_ ( arg0 ) _Post_bytecount_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Prepost_opt_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Prepost_opt_bytecount_x__mixin);
    }


    enum _dpp_impl__Prepost_bytecount_x__mixin = ` auto _Prepost_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Prepost_bytecount_x_ , ( arg0 ) , _Pre_bytecount_x_ ( arg0 ) _Post_bytecount_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Prepost_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Prepost_bytecount_x__mixin);
    }


    enum _dpp_impl__Prepost_opt_count_x__mixin = ` auto _Prepost_opt_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Prepost_opt_count_x_ , ( arg0 ) , _Pre_opt_count_x_ ( arg0 ) _Post_count_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Prepost_opt_count_x__mixin); })) {
        mixin(_dpp_impl__Prepost_opt_count_x__mixin);
    }




    enum _dpp_impl__Prepost_count_x__mixin = ` auto _Prepost_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Prepost_count_x_ , ( arg0 ) , _Pre_count_x_ ( arg0 ) _Post_count_x_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Prepost_count_x__mixin); })) {
        mixin(_dpp_impl__Prepost_count_x__mixin);
    }


    enum _dpp_impl__Prepost_opt_bytecount_c__mixin = ` auto _Prepost_opt_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Prepost_opt_bytecount_c_ , ( arg0 ) , _Pre_opt_bytecount_c_ ( arg0 ) _Post_bytecount_c_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Prepost_opt_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Prepost_opt_bytecount_c__mixin);
    }


    enum _dpp_impl__Prepost_bytecount_c__mixin = ` auto _Prepost_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Prepost_bytecount_c_ , ( arg0 ) , _Pre_bytecount_c_ ( arg0 ) _Post_bytecount_c_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Prepost_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Prepost_bytecount_c__mixin);
    }


    enum _dpp_impl__Prepost_opt_count_c__mixin = ` auto _Prepost_opt_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Prepost_opt_count_c_ , ( arg0 ) , _Pre_opt_count_c_ ( arg0 ) _Post_count_c_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Prepost_opt_count_c__mixin); })) {
        mixin(_dpp_impl__Prepost_opt_count_c__mixin);
    }


    enum _dpp_impl__Prepost_count_c__mixin = ` auto _Prepost_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Prepost_count_c_ , ( arg0 ) , _Pre_count_c_ ( arg0 ) _Post_count_c_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Prepost_count_c__mixin); })) {
        mixin(_dpp_impl__Prepost_count_c__mixin);
    }


    enum _dpp_impl__Prepost_opt_bytecount__mixin = ` auto _Prepost_opt_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Prepost_opt_bytecount_ , ( arg0 ) , _Pre_opt_bytecount_ ( arg0 ) _Post_bytecount_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Prepost_opt_bytecount__mixin); })) {
        mixin(_dpp_impl__Prepost_opt_bytecount__mixin);
    }


    enum _dpp_impl__Prepost_bytecount__mixin = ` auto _Prepost_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Prepost_bytecount_ , ( arg0 ) , _Pre_bytecount_ ( arg0 ) _Post_bytecount_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Prepost_bytecount__mixin); })) {
        mixin(_dpp_impl__Prepost_bytecount__mixin);
    }


    enum _dpp_impl__Prepost_opt_count__mixin = ` auto _Prepost_opt_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Prepost_opt_count_ , ( arg0 ) , _Pre_opt_count_ ( arg0 ) _Post_count_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Prepost_opt_count__mixin); })) {
        mixin(_dpp_impl__Prepost_opt_count__mixin);
    }


    enum _dpp_impl__Prepost_count__mixin = ` auto _Prepost_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Prepost_count_ , ( arg0 ) , _Pre_count_ ( arg0 ) _Post_count_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Prepost_count__mixin); })) {
        mixin(_dpp_impl__Prepost_count__mixin);
    }




    static if(!is(typeof(_Prepost_opt_z_))) {
        private enum enumMixinStr__Prepost_opt_z_ = `enum _Prepost_opt_z_ = _SAL1_1_Source_ ( _Prepost_opt_z_ , ( ) , _Pre_opt_z_ _Post_z_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Prepost_opt_z_); }))) {
            mixin(enumMixinStr__Prepost_opt_z_);
        }
    }


    enum _dpp_impl__Post_z_bytecount_x__mixin = ` auto _Post_z_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_z_bytecount_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_z_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Post_z_bytecount_x__mixin);
    }


    enum _dpp_impl__Post_z_count_x__mixin = ` auto _Post_z_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_z_count_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_z_count_x__mixin); })) {
        mixin(_dpp_impl__Post_z_count_x__mixin);
    }


    enum _dpp_impl__Post_z_bytecount_c__mixin = ` auto _Post_z_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_z_bytecount_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_z_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Post_z_bytecount_c__mixin);
    }


    enum _dpp_impl__Post_z_count_c__mixin = ` auto _Post_z_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_z_count_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_z_count_c__mixin); })) {
        mixin(_dpp_impl__Post_z_count_c__mixin);
    }


    enum _dpp_impl__Post_z_bytecount__mixin = ` auto _Post_z_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_z_bytecount_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_z_bytecount__mixin); })) {
        mixin(_dpp_impl__Post_z_bytecount__mixin);
    }


    enum _dpp_impl__Post_z_count__mixin = ` auto _Post_z_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_z_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_z_count__mixin); })) {
        mixin(_dpp_impl__Post_z_count__mixin);
    }


    enum _dpp_impl__Post_bytecount_x__mixin = ` auto _Post_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_bytecount_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Post_bytecount_x__mixin);
    }


    enum _dpp_impl__Post_count_x__mixin = ` auto _Post_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_count_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_count_x__mixin); })) {
        mixin(_dpp_impl__Post_count_x__mixin);
    }


    enum _dpp_impl__Post_bytecount_c__mixin = ` auto _Post_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_bytecount_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Post_bytecount_c__mixin);
    }


    enum _dpp_impl__Post_count_c__mixin = ` auto _Post_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_count_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_count_c__mixin); })) {
        mixin(_dpp_impl__Post_count_c__mixin);
    }


    enum _dpp_impl__Post_bytecount__mixin = ` auto _Post_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_bytecount_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_bytecount__mixin); })) {
        mixin(_dpp_impl__Post_bytecount__mixin);
    }


    enum _dpp_impl__Post_count__mixin = ` auto _Post_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_count__mixin); })) {
        mixin(_dpp_impl__Post_count__mixin);
    }


    enum _dpp_impl__Post_bytecap__mixin = ` auto _Post_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_bytecap__mixin); })) {
        mixin(_dpp_impl__Post_bytecap__mixin);
    }


    enum _dpp_impl__Post_cap__mixin = ` auto _Post_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Post_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_cap__mixin); })) {
        mixin(_dpp_impl__Post_cap__mixin);
    }




    static if(!is(typeof(_Post_maybez_))) {
        private enum enumMixinStr__Post_maybez_ = `enum _Post_maybez_ = _SAL_L_Source_ ( _Post_maybez_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Post_maybez_); }))) {
            mixin(enumMixinStr__Post_maybez_);
        }
    }


    enum _dpp_impl__Pre_opt_ptrdiff_count__mixin = ` auto _Pre_opt_ptrdiff_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_ptrdiff_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_ptrdiff_count__mixin); })) {
        mixin(_dpp_impl__Pre_opt_ptrdiff_count__mixin);
    }


    enum _dpp_impl__Pre_ptrdiff_count__mixin = ` auto _Pre_ptrdiff_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_ptrdiff_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_ptrdiff_count__mixin); })) {
        mixin(_dpp_impl__Pre_ptrdiff_count__mixin);
    }


    enum _dpp_impl__Pre_opt_bytecount_x__mixin = ` auto _Pre_opt_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_bytecount_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Pre_opt_bytecount_x__mixin);
    }


    enum _dpp_impl__Pre_bytecount_x__mixin = ` auto _Pre_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_bytecount_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Pre_bytecount_x__mixin);
    }


    enum _dpp_impl__Pre_opt_count_x__mixin = ` auto _Pre_opt_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_count_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_count_x__mixin); })) {
        mixin(_dpp_impl__Pre_opt_count_x__mixin);
    }


    enum _dpp_impl__Pre_count_x__mixin = ` auto _Pre_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_count_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_count_x__mixin); })) {
        mixin(_dpp_impl__Pre_count_x__mixin);
    }


    enum _dpp_impl__Pre_opt_bytecount_c__mixin = ` auto _Pre_opt_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_bytecount_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Pre_opt_bytecount_c__mixin);
    }


    enum _dpp_impl__Pre_bytecount_c__mixin = ` auto _Pre_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_bytecount_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Pre_bytecount_c__mixin);
    }


    enum _dpp_impl__Pre_opt_count_c__mixin = ` auto _Pre_opt_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_count_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_count_c__mixin); })) {
        mixin(_dpp_impl__Pre_opt_count_c__mixin);
    }


    enum _dpp_impl__Pre_count_c__mixin = ` auto _Pre_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_count_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_count_c__mixin); })) {
        mixin(_dpp_impl__Pre_count_c__mixin);
    }


    enum _dpp_impl__Pre_opt_bytecount__mixin = ` auto _Pre_opt_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_bytecount_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_bytecount__mixin); })) {
        mixin(_dpp_impl__Pre_opt_bytecount__mixin);
    }


    enum _dpp_impl__Pre_bytecount__mixin = ` auto _Pre_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_bytecount_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_bytecount__mixin); })) {
        mixin(_dpp_impl__Pre_bytecount__mixin);
    }


    enum _dpp_impl__Pre_opt_count__mixin = ` auto _Pre_opt_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_count__mixin); })) {
        mixin(_dpp_impl__Pre_opt_count__mixin);
    }


    enum _dpp_impl__Pre_count__mixin = ` auto _Pre_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_count__mixin); })) {
        mixin(_dpp_impl__Pre_count__mixin);
    }


    enum _dpp_impl__Pre_opt_valid_bytecap_x__mixin = ` auto _Pre_opt_valid_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_valid_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_valid_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Pre_opt_valid_bytecap_x__mixin);
    }


    enum _dpp_impl__Pre_valid_bytecap_x__mixin = ` auto _Pre_valid_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_valid_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_valid_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Pre_valid_bytecap_x__mixin);
    }


    enum _dpp_impl__Pre_opt_valid_cap_x__mixin = ` auto _Pre_opt_valid_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_valid_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_valid_cap_x__mixin); })) {
        mixin(_dpp_impl__Pre_opt_valid_cap_x__mixin);
    }


    enum _dpp_impl__Pre_valid_cap_x__mixin = ` auto _Pre_valid_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_valid_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_valid_cap_x__mixin); })) {
        mixin(_dpp_impl__Pre_valid_cap_x__mixin);
    }


    enum _dpp_impl__Pre_opt_valid_bytecap_c__mixin = ` auto _Pre_opt_valid_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_valid_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_valid_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Pre_opt_valid_bytecap_c__mixin);
    }


    enum _dpp_impl__Pre_valid_bytecap_c__mixin = ` auto _Pre_valid_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_valid_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_valid_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Pre_valid_bytecap_c__mixin);
    }


    enum _dpp_impl__Pre_opt_valid_cap_c__mixin = ` auto _Pre_opt_valid_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_valid_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_valid_cap_c__mixin); })) {
        mixin(_dpp_impl__Pre_opt_valid_cap_c__mixin);
    }


    enum _dpp_impl__Pre_valid_cap_c__mixin = ` auto _Pre_valid_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_valid_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_valid_cap_c__mixin); })) {
        mixin(_dpp_impl__Pre_valid_cap_c__mixin);
    }


    enum _dpp_impl__Pre_opt_valid_bytecap__mixin = ` auto _Pre_opt_valid_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_valid_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_valid_bytecap__mixin); })) {
        mixin(_dpp_impl__Pre_opt_valid_bytecap__mixin);
    }


    enum _dpp_impl__Pre_valid_bytecap__mixin = ` auto _Pre_valid_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_valid_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_valid_bytecap__mixin); })) {
        mixin(_dpp_impl__Pre_valid_bytecap__mixin);
    }


    enum _dpp_impl__Pre_opt_valid_cap__mixin = ` auto _Pre_opt_valid_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_valid_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_valid_cap__mixin); })) {
        mixin(_dpp_impl__Pre_opt_valid_cap__mixin);
    }


    enum _dpp_impl__Pre_valid_cap__mixin = ` auto _Pre_valid_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_valid_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_valid_cap__mixin); })) {
        mixin(_dpp_impl__Pre_valid_cap__mixin);
    }


    enum _dpp_impl__Pre_opt_z_bytecap_x__mixin = ` auto _Pre_opt_z_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_z_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_z_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Pre_opt_z_bytecap_x__mixin);
    }


    enum _dpp_impl__Pre_z_bytecap_x__mixin = ` auto _Pre_z_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_z_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_z_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Pre_z_bytecap_x__mixin);
    }


    enum _dpp_impl__Pre_opt_z_cap_x__mixin = ` auto _Pre_opt_z_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_z_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_z_cap_x__mixin); })) {
        mixin(_dpp_impl__Pre_opt_z_cap_x__mixin);
    }


    enum _dpp_impl__Pre_z_cap_x__mixin = ` auto _Pre_z_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_z_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_z_cap_x__mixin); })) {
        mixin(_dpp_impl__Pre_z_cap_x__mixin);
    }


    enum _dpp_impl__Pre_opt_z_bytecap_c__mixin = ` auto _Pre_opt_z_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_z_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_z_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Pre_opt_z_bytecap_c__mixin);
    }


    enum _dpp_impl__Pre_z_bytecap_c__mixin = ` auto _Pre_z_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_z_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_z_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Pre_z_bytecap_c__mixin);
    }


    enum _dpp_impl__Pre_opt_z_cap_c__mixin = ` auto _Pre_opt_z_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_z_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_z_cap_c__mixin); })) {
        mixin(_dpp_impl__Pre_opt_z_cap_c__mixin);
    }


    enum _dpp_impl__Pre_z_cap_c__mixin = ` auto _Pre_z_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_z_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_z_cap_c__mixin); })) {
        mixin(_dpp_impl__Pre_z_cap_c__mixin);
    }


    enum _dpp_impl__Pre_opt_z_bytecap__mixin = ` auto _Pre_opt_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_z_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Pre_opt_z_bytecap__mixin);
    }


    enum _dpp_impl__Pre_z_bytecap__mixin = ` auto _Pre_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_z_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Pre_z_bytecap__mixin);
    }


    enum _dpp_impl__Pre_opt_z_cap__mixin = ` auto _Pre_opt_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_z_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_z_cap__mixin); })) {
        mixin(_dpp_impl__Pre_opt_z_cap__mixin);
    }


    enum _dpp_impl__Pre_z_cap__mixin = ` auto _Pre_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_z_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_z_cap__mixin); })) {
        mixin(_dpp_impl__Pre_z_cap__mixin);
    }


    enum _dpp_impl__Pre_opt_ptrdiff_cap__mixin = ` auto _Pre_opt_ptrdiff_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_ptrdiff_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_ptrdiff_cap__mixin); })) {
        mixin(_dpp_impl__Pre_opt_ptrdiff_cap__mixin);
    }


    enum _dpp_impl__Pre_ptrdiff_cap__mixin = ` auto _Pre_ptrdiff_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_ptrdiff_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_ptrdiff_cap__mixin); })) {
        mixin(_dpp_impl__Pre_ptrdiff_cap__mixin);
    }


    enum _dpp_impl__Pre_opt_bytecap_x__mixin = ` auto _Pre_opt_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Pre_opt_bytecap_x__mixin);
    }


    enum _dpp_impl__Pre_bytecap_x__mixin = ` auto _Pre_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Pre_bytecap_x__mixin);
    }


    enum _dpp_impl__Pre_opt_cap_x__mixin = ` auto _Pre_opt_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_cap_x__mixin); })) {
        mixin(_dpp_impl__Pre_opt_cap_x__mixin);
    }


    enum _dpp_impl__Pre_cap_x__mixin = ` auto _Pre_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_cap_x__mixin); })) {
        mixin(_dpp_impl__Pre_cap_x__mixin);
    }


    enum _dpp_impl__Pre_opt_cap_for__mixin = ` auto _Pre_opt_cap_for_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_cap_for_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_cap_for__mixin); })) {
        mixin(_dpp_impl__Pre_opt_cap_for__mixin);
    }


    enum _dpp_impl__Pre_cap_for__mixin = ` auto _Pre_cap_for_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_cap_for_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_cap_for__mixin); })) {
        mixin(_dpp_impl__Pre_cap_for__mixin);
    }


    enum _dpp_impl__Pre_opt_cap_m__mixin = ` auto _Pre_opt_cap_m_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Pre_opt_cap_m_ , ( arg0 , arg1 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_cap_m__mixin); })) {
        mixin(_dpp_impl__Pre_opt_cap_m__mixin);
    }


    enum _dpp_impl__Pre_cap_m__mixin = ` auto _Pre_cap_m_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Pre_cap_m_ , ( arg0 , arg1 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_cap_m__mixin); })) {
        mixin(_dpp_impl__Pre_cap_m__mixin);
    }




    static if(!is(typeof(_Pre_opt_cap_c_one_))) {
        private enum enumMixinStr__Pre_opt_cap_c_one_ = `enum _Pre_opt_cap_c_one_ = _SAL1_1_Source_ ( _Pre_opt_cap_c_one_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_opt_cap_c_one_); }))) {
            mixin(enumMixinStr__Pre_opt_cap_c_one_);
        }
    }




    static if(!is(typeof(_Pre_cap_c_one_))) {
        private enum enumMixinStr__Pre_cap_c_one_ = `enum _Pre_cap_c_one_ = _SAL1_1_Source_ ( _Pre_cap_c_one_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_cap_c_one_); }))) {
            mixin(enumMixinStr__Pre_cap_c_one_);
        }
    }


    enum _dpp_impl__Pre_opt_bytecap_c__mixin = ` auto _Pre_opt_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Pre_opt_bytecap_c__mixin);
    }


    enum _dpp_impl__Pre_bytecap_c__mixin = ` auto _Pre_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Pre_bytecap_c__mixin);
    }




    static if(!is(typeof(PDF_SIGNATURE_DEFAULT_APPEARANCE))) {
        private enum enumMixinStr_PDF_SIGNATURE_DEFAULT_APPEARANCE = `enum PDF_SIGNATURE_DEFAULT_APPEARANCE = ( PDF_SIGNATURE_SHOW_LABELS | PDF_SIGNATURE_SHOW_DN | PDF_SIGNATURE_SHOW_DATE | PDF_SIGNATURE_SHOW_TEXT_NAME | PDF_SIGNATURE_SHOW_GRAPHIC_NAME | PDF_SIGNATURE_SHOW_LOGO );`;
        static if(is(typeof({ mixin(enumMixinStr_PDF_SIGNATURE_DEFAULT_APPEARANCE); }))) {
            mixin(enumMixinStr_PDF_SIGNATURE_DEFAULT_APPEARANCE);
        }
    }


    enum _dpp_impl__Pre_opt_cap_c__mixin = ` auto _Pre_opt_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_cap_c__mixin); })) {
        mixin(_dpp_impl__Pre_opt_cap_c__mixin);
    }


    enum _dpp_impl__Pre_cap_c__mixin = ` auto _Pre_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_cap_c__mixin); })) {
        mixin(_dpp_impl__Pre_cap_c__mixin);
    }


    enum _dpp_impl__Pre_opt_bytecap__mixin = ` auto _Pre_opt_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_bytecap__mixin); })) {
        mixin(_dpp_impl__Pre_opt_bytecap__mixin);
    }


    enum _dpp_impl__Pre_bytecap__mixin = ` auto _Pre_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_bytecap__mixin); })) {
        mixin(_dpp_impl__Pre_bytecap__mixin);
    }


    enum _dpp_impl__Pre_opt_cap__mixin = ` auto _Pre_opt_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_opt_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_opt_cap__mixin); })) {
        mixin(_dpp_impl__Pre_opt_cap__mixin);
    }


    enum _dpp_impl__Pre_cap__mixin = ` auto _Pre_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Pre_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_cap__mixin); })) {
        mixin(_dpp_impl__Pre_cap__mixin);
    }




    static if(!is(typeof(_Pre_writeonly_))) {
        private enum enumMixinStr__Pre_writeonly_ = `enum _Pre_writeonly_ = _SAL1_1_Source_ ( _Pre_writeonly_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_writeonly_); }))) {
            mixin(enumMixinStr__Pre_writeonly_);
        }
    }




    static if(!is(typeof(_Pre_readonly_))) {
        private enum enumMixinStr__Pre_readonly_ = `enum _Pre_readonly_ = _SAL1_1_Source_ ( _Pre_readonly_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_readonly_); }))) {
            mixin(enumMixinStr__Pre_readonly_);
        }
    }




    static if(!is(typeof(_Pre_opt_z_))) {
        private enum enumMixinStr__Pre_opt_z_ = `enum _Pre_opt_z_ = _SAL1_1_Source_ ( _Pre_opt_z_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_opt_z_); }))) {
            mixin(enumMixinStr__Pre_opt_z_);
        }
    }


    enum _dpp_impl__Ret_opt_z_bytecount__mixin = ` auto _Ret_opt_z_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_z_bytecount_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_z_bytecount__mixin); })) {
        mixin(_dpp_impl__Ret_opt_z_bytecount__mixin);
    }


    enum _dpp_impl__Ret_z_bytecount__mixin = ` auto _Ret_z_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_z_bytecount_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_z_bytecount__mixin); })) {
        mixin(_dpp_impl__Ret_z_bytecount__mixin);
    }


    enum _dpp_impl__Ret_opt_z_count__mixin = ` auto _Ret_opt_z_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_z_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_z_count__mixin); })) {
        mixin(_dpp_impl__Ret_opt_z_count__mixin);
    }


    enum _dpp_impl__Ret_z_count__mixin = ` auto _Ret_z_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_z_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_z_count__mixin); })) {
        mixin(_dpp_impl__Ret_z_count__mixin);
    }


    enum _dpp_impl__Ret_opt_bytecount_x__mixin = ` auto _Ret_opt_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_bytecount_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Ret_opt_bytecount_x__mixin);
    }


    enum _dpp_impl__Ret_bytecount_x__mixin = ` auto _Ret_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_bytecount_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Ret_bytecount_x__mixin);
    }


    enum _dpp_impl__Ret_opt_count_x__mixin = ` auto _Ret_opt_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_count_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_count_x__mixin); })) {
        mixin(_dpp_impl__Ret_opt_count_x__mixin);
    }


    enum _dpp_impl__Ret_count_x__mixin = ` auto _Ret_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_count_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_count_x__mixin); })) {
        mixin(_dpp_impl__Ret_count_x__mixin);
    }


    enum _dpp_impl__Ret_opt_bytecount_c__mixin = ` auto _Ret_opt_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_bytecount_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Ret_opt_bytecount_c__mixin);
    }


    enum _dpp_impl__Ret_bytecount_c__mixin = ` auto _Ret_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_bytecount_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Ret_bytecount_c__mixin);
    }


    enum _dpp_impl__Ret_opt_count_c__mixin = ` auto _Ret_opt_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_count_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_count_c__mixin); })) {
        mixin(_dpp_impl__Ret_opt_count_c__mixin);
    }


    enum _dpp_impl__Ret_count_c__mixin = ` auto _Ret_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_count_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_count_c__mixin); })) {
        mixin(_dpp_impl__Ret_count_c__mixin);
    }


    enum _dpp_impl__Ret_opt_bytecount__mixin = ` auto _Ret_opt_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_bytecount_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_bytecount__mixin); })) {
        mixin(_dpp_impl__Ret_opt_bytecount__mixin);
    }


    enum _dpp_impl__Ret_bytecount__mixin = ` auto _Ret_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_bytecount_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_bytecount__mixin); })) {
        mixin(_dpp_impl__Ret_bytecount__mixin);
    }


    enum _dpp_impl__Ret_opt_count__mixin = ` auto _Ret_opt_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_count__mixin); })) {
        mixin(_dpp_impl__Ret_opt_count__mixin);
    }


    enum _dpp_impl__Ret_count__mixin = ` auto _Ret_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_count__mixin); })) {
        mixin(_dpp_impl__Ret_count__mixin);
    }


    enum _dpp_impl__Ret_opt_z_bytecap__mixin = ` auto _Ret_opt_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_z_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Ret_opt_z_bytecap__mixin);
    }


    enum _dpp_impl__Ret_z_bytecap__mixin = ` auto _Ret_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_z_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Ret_z_bytecap__mixin);
    }


    enum _dpp_impl__Ret_opt_z_cap__mixin = ` auto _Ret_opt_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_z_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_z_cap__mixin); })) {
        mixin(_dpp_impl__Ret_opt_z_cap__mixin);
    }


    enum _dpp_impl__Ret_z_cap__mixin = ` auto _Ret_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_z_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_z_cap__mixin); })) {
        mixin(_dpp_impl__Ret_z_cap__mixin);
    }


    enum _dpp_impl__Ret_opt_bytecap_x__mixin = ` auto _Ret_opt_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Ret_opt_bytecap_x__mixin);
    }


    enum _dpp_impl__Ret_bytecap_x__mixin = ` auto _Ret_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Ret_bytecap_x__mixin);
    }


    enum _dpp_impl__Ret_opt_cap_x__mixin = ` auto _Ret_opt_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_cap_x__mixin); })) {
        mixin(_dpp_impl__Ret_opt_cap_x__mixin);
    }




    enum _dpp_impl__Ret_cap_x__mixin = ` auto _Ret_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_cap_x__mixin); })) {
        mixin(_dpp_impl__Ret_cap_x__mixin);
    }


    enum _dpp_impl__Ret_opt_bytecap_c__mixin = ` auto _Ret_opt_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Ret_opt_bytecap_c__mixin);
    }


    enum _dpp_impl__Ret_bytecap_c__mixin = ` auto _Ret_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Ret_bytecap_c__mixin);
    }


    enum _dpp_impl__Ret_opt_cap_c__mixin = ` auto _Ret_opt_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_cap_c__mixin); })) {
        mixin(_dpp_impl__Ret_opt_cap_c__mixin);
    }


    enum _dpp_impl__Ret_cap_c__mixin = ` auto _Ret_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_cap_c__mixin); })) {
        mixin(_dpp_impl__Ret_cap_c__mixin);
    }


    enum _dpp_impl__Ret_opt_bytecap__mixin = ` auto _Ret_opt_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_bytecap__mixin); })) {
        mixin(_dpp_impl__Ret_opt_bytecap__mixin);
    }


    enum _dpp_impl__Ret_bytecap__mixin = ` auto _Ret_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_bytecap__mixin); })) {
        mixin(_dpp_impl__Ret_bytecap__mixin);
    }


    enum _dpp_impl__Ret_opt_cap__mixin = ` auto _Ret_opt_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_opt_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_opt_cap__mixin); })) {
        mixin(_dpp_impl__Ret_opt_cap__mixin);
    }


    enum _dpp_impl__Ret_cap__mixin = ` auto _Ret_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Ret_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_cap__mixin); })) {
        mixin(_dpp_impl__Ret_cap__mixin);
    }




    static if(!is(typeof(_Ret_opt_z_))) {
        private enum enumMixinStr__Ret_opt_z_ = `enum _Ret_opt_z_ = _SAL1_1_Source_ ( _Ret_opt_z_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Ret_opt_z_); }))) {
            mixin(enumMixinStr__Ret_opt_z_);
        }
    }




    static if(!is(typeof(_Ret_opt_valid_))) {
        private enum enumMixinStr__Ret_opt_valid_ = `enum _Ret_opt_valid_ = _SAL1_1_Source_ ( _Ret_opt_valid_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Ret_opt_valid_); }))) {
            mixin(enumMixinStr__Ret_opt_valid_);
        }
    }




    static if(!is(typeof(_Deref2_pre_readonly_))) {
        private enum enumMixinStr__Deref2_pre_readonly_ = `enum _Deref2_pre_readonly_ = _SAL1_1_Source_ ( _Deref2_pre_readonly_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref2_pre_readonly_); }))) {
            mixin(enumMixinStr__Deref2_pre_readonly_);
        }
    }




    static if(!is(typeof(_Deref_ret_opt_z_))) {
        private enum enumMixinStr__Deref_ret_opt_z_ = `enum _Deref_ret_opt_z_ = _SAL1_1_Source_ ( _Deref_ret_opt_z_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_ret_opt_z_); }))) {
            mixin(enumMixinStr__Deref_ret_opt_z_);
        }
    }




    static if(!is(typeof(_Deref_ret_z_))) {
        private enum enumMixinStr__Deref_ret_z_ = `enum _Deref_ret_z_ = _SAL1_1_Source_ ( _Deref_ret_z_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_ret_z_); }))) {
            mixin(enumMixinStr__Deref_ret_z_);
        }
    }




    static if(!is(typeof(_Deref_post_null_))) {
        private enum enumMixinStr__Deref_post_null_ = `enum _Deref_post_null_ = _SAL1_1_Source_ ( _Deref_post_null_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_post_null_); }))) {
            mixin(enumMixinStr__Deref_post_null_);
        }
    }




    static if(!is(typeof(_Deref_post_maybenull_))) {
        private enum enumMixinStr__Deref_post_maybenull_ = `enum _Deref_post_maybenull_ = _SAL1_1_Source_ ( _Deref_post_maybenull_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_post_maybenull_); }))) {
            mixin(enumMixinStr__Deref_post_maybenull_);
        }
    }




    static if(!is(typeof(_Deref_post_notnull_))) {
        private enum enumMixinStr__Deref_post_notnull_ = `enum _Deref_post_notnull_ = _SAL1_1_Source_ ( _Deref_post_notnull_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_post_notnull_); }))) {
            mixin(enumMixinStr__Deref_post_notnull_);
        }
    }




    static if(!is(typeof(_Deref_post_opt_valid_))) {
        private enum enumMixinStr__Deref_post_opt_valid_ = `enum _Deref_post_opt_valid_ = _SAL1_1_Source_ ( _Deref_post_opt_valid_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_post_opt_valid_); }))) {
            mixin(enumMixinStr__Deref_post_opt_valid_);
        }
    }




    static if(!is(typeof(_Deref_post_valid_))) {
        private enum enumMixinStr__Deref_post_valid_ = `enum _Deref_post_valid_ = _SAL1_1_Source_ ( _Deref_post_valid_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_post_valid_); }))) {
            mixin(enumMixinStr__Deref_post_valid_);
        }
    }


    enum _dpp_impl__Deref_post_opt_bytecount_x__mixin = ` auto _Deref_post_opt_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_bytecount_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_bytecount_x__mixin);
    }


    enum _dpp_impl__Deref_post_bytecount_x__mixin = ` auto _Deref_post_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_bytecount_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_bytecount_x__mixin);
    }


    enum _dpp_impl__Deref_post_opt_count_x__mixin = ` auto _Deref_post_opt_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_count_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_count_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_count_x__mixin);
    }


    enum _dpp_impl__Deref_post_count_x__mixin = ` auto _Deref_post_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_count_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_count_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_count_x__mixin);
    }


    enum _dpp_impl__Deref_post_opt_bytecount_c__mixin = ` auto _Deref_post_opt_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_bytecount_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_bytecount_c__mixin);
    }


    enum _dpp_impl__Deref_post_bytecount_c__mixin = ` auto _Deref_post_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_bytecount_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_bytecount_c__mixin);
    }


    enum _dpp_impl__Deref_post_opt_count_c__mixin = ` auto _Deref_post_opt_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_count_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_count_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_count_c__mixin);
    }


    enum _dpp_impl__Deref_post_count_c__mixin = ` auto _Deref_post_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_count_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_count_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_count_c__mixin);
    }


    enum _dpp_impl__Deref_post_opt_bytecount__mixin = ` auto _Deref_post_opt_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_bytecount_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_bytecount__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_bytecount__mixin);
    }


    enum _dpp_impl__Deref_post_bytecount__mixin = ` auto _Deref_post_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_bytecount_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_bytecount__mixin); })) {
        mixin(_dpp_impl__Deref_post_bytecount__mixin);
    }


    enum _dpp_impl__Deref_post_opt_count__mixin = ` auto _Deref_post_opt_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_count__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_count__mixin);
    }


    enum _dpp_impl__Deref_post_count__mixin = ` auto _Deref_post_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_count__mixin); })) {
        mixin(_dpp_impl__Deref_post_count__mixin);
    }


    enum _dpp_impl__Deref_post_opt_valid_bytecap_x__mixin = ` auto _Deref_post_opt_valid_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_valid_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_valid_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_valid_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_post_valid_bytecap_x__mixin = ` auto _Deref_post_valid_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_valid_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_valid_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_valid_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_post_opt_valid_cap_x__mixin = ` auto _Deref_post_opt_valid_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_valid_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_valid_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_valid_cap_x__mixin);
    }


    enum _dpp_impl__Deref_post_valid_cap_x__mixin = ` auto _Deref_post_valid_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_valid_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_valid_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_valid_cap_x__mixin);
    }


    enum _dpp_impl__Deref_post_opt_valid_bytecap_c__mixin = ` auto _Deref_post_opt_valid_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_valid_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_valid_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_valid_bytecap_c__mixin);
    }




    enum _dpp_impl__Deref_post_valid_bytecap_c__mixin = ` auto _Deref_post_valid_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_valid_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_valid_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_valid_bytecap_c__mixin);
    }


    enum _dpp_impl__Deref_post_opt_valid_cap_c__mixin = ` auto _Deref_post_opt_valid_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_valid_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_valid_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_valid_cap_c__mixin);
    }


    enum _dpp_impl__Deref_post_valid_cap_c__mixin = ` auto _Deref_post_valid_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_valid_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_valid_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_valid_cap_c__mixin);
    }


    enum _dpp_impl__Deref_post_opt_valid_bytecap__mixin = ` auto _Deref_post_opt_valid_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_valid_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_valid_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_valid_bytecap__mixin);
    }


    enum _dpp_impl__Deref_post_valid_bytecap__mixin = ` auto _Deref_post_valid_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_valid_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_valid_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_post_valid_bytecap__mixin);
    }


    enum _dpp_impl__Deref_post_opt_valid_cap__mixin = ` auto _Deref_post_opt_valid_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_valid_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_valid_cap__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_valid_cap__mixin);
    }


    enum _dpp_impl__Deref_post_valid_cap__mixin = ` auto _Deref_post_valid_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_valid_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_valid_cap__mixin); })) {
        mixin(_dpp_impl__Deref_post_valid_cap__mixin);
    }


    enum _dpp_impl__Deref_post_opt_z_bytecap_x__mixin = ` auto _Deref_post_opt_z_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_z_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_z_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_z_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_post_z_bytecap_x__mixin = ` auto _Deref_post_z_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_z_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_z_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_z_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_post_opt_z_cap_x__mixin = ` auto _Deref_post_opt_z_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_z_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_z_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_z_cap_x__mixin);
    }


    enum _dpp_impl__Deref_post_z_cap_x__mixin = ` auto _Deref_post_z_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_z_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_z_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_z_cap_x__mixin);
    }


    enum _dpp_impl__Deref_post_opt_z_bytecap_c__mixin = ` auto _Deref_post_opt_z_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_z_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_z_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_z_bytecap_c__mixin);
    }


    enum _dpp_impl__Deref_post_z_bytecap_c__mixin = ` auto _Deref_post_z_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_z_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_z_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_z_bytecap_c__mixin);
    }


    enum _dpp_impl__Deref_post_opt_z_cap_c__mixin = ` auto _Deref_post_opt_z_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_z_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_z_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_z_cap_c__mixin);
    }


    enum _dpp_impl__Deref_post_z_cap_c__mixin = ` auto _Deref_post_z_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_z_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_z_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_z_cap_c__mixin);
    }


    enum _dpp_impl__Deref_post_opt_z_bytecap__mixin = ` auto _Deref_post_opt_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_z_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_z_bytecap__mixin);
    }


    enum _dpp_impl__Deref_post_z_bytecap__mixin = ` auto _Deref_post_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_z_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_post_z_bytecap__mixin);
    }


    enum _dpp_impl__Deref_post_opt_z_cap__mixin = ` auto _Deref_post_opt_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_z_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_z_cap__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_z_cap__mixin);
    }


    enum _dpp_impl__Deref_post_z_cap__mixin = ` auto _Deref_post_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_z_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_z_cap__mixin); })) {
        mixin(_dpp_impl__Deref_post_z_cap__mixin);
    }


    enum _dpp_impl__Deref_post_opt_bytecap_x__mixin = ` auto _Deref_post_opt_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_post_bytecap_x__mixin = ` auto _Deref_post_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_post_opt_cap_x__mixin = ` auto _Deref_post_opt_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_cap_x__mixin);
    }


    enum _dpp_impl__Deref_post_cap_x__mixin = ` auto _Deref_post_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_post_cap_x__mixin);
    }


    enum _dpp_impl__Deref_post_opt_bytecap_c__mixin = ` auto _Deref_post_opt_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_bytecap_c__mixin);
    }


    enum _dpp_impl__Deref_post_bytecap_c__mixin = ` auto _Deref_post_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_bytecap_c__mixin);
    }


    enum _dpp_impl__Deref_post_opt_cap_c__mixin = ` auto _Deref_post_opt_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_cap_c__mixin);
    }


    enum _dpp_impl__Deref_post_cap_c__mixin = ` auto _Deref_post_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_post_cap_c__mixin);
    }


    enum _dpp_impl__Deref_post_opt_bytecap__mixin = ` auto _Deref_post_opt_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_bytecap__mixin);
    }


    enum _dpp_impl__Deref_post_bytecap__mixin = ` auto _Deref_post_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_post_bytecap__mixin);
    }


    enum _dpp_impl__Deref_post_opt_cap__mixin = ` auto _Deref_post_opt_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_opt_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_opt_cap__mixin); })) {
        mixin(_dpp_impl__Deref_post_opt_cap__mixin);
    }


    enum _dpp_impl__Deref_post_cap__mixin = ` auto _Deref_post_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_post_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_post_cap__mixin); })) {
        mixin(_dpp_impl__Deref_post_cap__mixin);
    }




    static if(!is(typeof(_Deref_post_opt_z_))) {
        private enum enumMixinStr__Deref_post_opt_z_ = `enum _Deref_post_opt_z_ = _SAL1_1_Source_ ( _Deref_post_opt_z_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_post_opt_z_); }))) {
            mixin(enumMixinStr__Deref_post_opt_z_);
        }
    }




    static if(!is(typeof(_Deref_post_z_))) {
        private enum enumMixinStr__Deref_post_z_ = `enum _Deref_post_z_ = _SAL1_1_Source_ ( _Deref_post_z_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_post_z_); }))) {
            mixin(enumMixinStr__Deref_post_z_);
        }
    }




    static if(!is(typeof(_Deref_pre_writeonly_))) {
        private enum enumMixinStr__Deref_pre_writeonly_ = `enum _Deref_pre_writeonly_ = _SAL1_1_Source_ ( _Deref_pre_writeonly_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_pre_writeonly_); }))) {
            mixin(enumMixinStr__Deref_pre_writeonly_);
        }
    }




    static if(!is(typeof(_Deref_pre_readonly_))) {
        private enum enumMixinStr__Deref_pre_readonly_ = `enum _Deref_pre_readonly_ = _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_pre_readonly_); }))) {
            mixin(enumMixinStr__Deref_pre_readonly_);
        }
    }




    static if(!is(typeof(_Deref_pre_null_))) {
        private enum enumMixinStr__Deref_pre_null_ = `enum _Deref_pre_null_ = _SAL1_1_Source_ ( _Deref_pre_null_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_pre_null_); }))) {
            mixin(enumMixinStr__Deref_pre_null_);
        }
    }




    static if(!is(typeof(_Deref_pre_maybenull_))) {
        private enum enumMixinStr__Deref_pre_maybenull_ = `enum _Deref_pre_maybenull_ = _SAL1_1_Source_ ( _Deref_pre_maybenull_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_pre_maybenull_); }))) {
            mixin(enumMixinStr__Deref_pre_maybenull_);
        }
    }




    static if(!is(typeof(_Deref_pre_notnull_))) {
        private enum enumMixinStr__Deref_pre_notnull_ = `enum _Deref_pre_notnull_ = _SAL1_1_Source_ ( _Deref_pre_notnull_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_pre_notnull_); }))) {
            mixin(enumMixinStr__Deref_pre_notnull_);
        }
    }




    static if(!is(typeof(_Deref_pre_invalid_))) {
        private enum enumMixinStr__Deref_pre_invalid_ = `enum _Deref_pre_invalid_ = _SAL1_1_Source_ ( _Deref_pre_invalid_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_pre_invalid_); }))) {
            mixin(enumMixinStr__Deref_pre_invalid_);
        }
    }




    static if(!is(typeof(_Deref_pre_opt_valid_))) {
        private enum enumMixinStr__Deref_pre_opt_valid_ = `enum _Deref_pre_opt_valid_ = _SAL1_1_Source_ ( _Deref_pre_opt_valid_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_pre_opt_valid_); }))) {
            mixin(enumMixinStr__Deref_pre_opt_valid_);
        }
    }




    static if(!is(typeof(_Deref_pre_valid_))) {
        private enum enumMixinStr__Deref_pre_valid_ = `enum _Deref_pre_valid_ = _SAL1_1_Source_ ( _Deref_pre_valid_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_pre_valid_); }))) {
            mixin(enumMixinStr__Deref_pre_valid_);
        }
    }


    enum _dpp_impl__Deref_pre_opt_bytecount_x__mixin = ` auto _Deref_pre_opt_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_bytecount_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_bytecount_x__mixin);
    }


    enum _dpp_impl__Deref_pre_bytecount_x__mixin = ` auto _Deref_pre_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_bytecount_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_bytecount_x__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_count_x__mixin = ` auto _Deref_pre_opt_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_count_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_count_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_count_x__mixin);
    }


    enum _dpp_impl__Deref_pre_count_x__mixin = ` auto _Deref_pre_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_count_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_count_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_count_x__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_bytecount_c__mixin = ` auto _Deref_pre_opt_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_bytecount_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_bytecount_c__mixin);
    }


    enum _dpp_impl__Deref_pre_bytecount_c__mixin = ` auto _Deref_pre_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_bytecount_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_bytecount_c__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_count_c__mixin = ` auto _Deref_pre_opt_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_count_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_count_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_count_c__mixin);
    }


    enum _dpp_impl__Deref_pre_count_c__mixin = ` auto _Deref_pre_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_count_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_count_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_count_c__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_bytecount__mixin = ` auto _Deref_pre_opt_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_bytecount_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_bytecount__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_bytecount__mixin);
    }


    enum _dpp_impl__Deref_pre_bytecount__mixin = ` auto _Deref_pre_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_bytecount_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_bytecount__mixin); })) {
        mixin(_dpp_impl__Deref_pre_bytecount__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_count__mixin = ` auto _Deref_pre_opt_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_count__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_count__mixin);
    }


    enum _dpp_impl__Deref_pre_count__mixin = ` auto _Deref_pre_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_count_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_count__mixin); })) {
        mixin(_dpp_impl__Deref_pre_count__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_valid_bytecap_x__mixin = ` auto _Deref_pre_opt_valid_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_valid_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_valid_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_valid_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_pre_valid_bytecap_x__mixin = ` auto _Deref_pre_valid_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_valid_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_valid_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_valid_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_valid_cap_x__mixin = ` auto _Deref_pre_opt_valid_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_valid_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_valid_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_valid_cap_x__mixin);
    }


    enum _dpp_impl__Deref_pre_valid_cap_x__mixin = ` auto _Deref_pre_valid_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_valid_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_valid_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_valid_cap_x__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_valid_bytecap_c__mixin = ` auto _Deref_pre_opt_valid_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_valid_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_valid_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_valid_bytecap_c__mixin);
    }


    enum _dpp_impl__Deref_pre_valid_bytecap_c__mixin = ` auto _Deref_pre_valid_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_valid_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_valid_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_valid_bytecap_c__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_valid_cap_c__mixin = ` auto _Deref_pre_opt_valid_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_valid_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_valid_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_valid_cap_c__mixin);
    }


    enum _dpp_impl__Deref_pre_valid_cap_c__mixin = ` auto _Deref_pre_valid_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_valid_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_valid_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_valid_cap_c__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_valid_bytecap__mixin = ` auto _Deref_pre_opt_valid_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_valid_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_valid_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_valid_bytecap__mixin);
    }


    enum _dpp_impl__Deref_pre_valid_bytecap__mixin = ` auto _Deref_pre_valid_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_valid_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_valid_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_pre_valid_bytecap__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_valid_cap__mixin = ` auto _Deref_pre_opt_valid_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_valid_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_valid_cap__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_valid_cap__mixin);
    }


    enum _dpp_impl__Deref_pre_valid_cap__mixin = ` auto _Deref_pre_valid_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_valid_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_valid_cap__mixin); })) {
        mixin(_dpp_impl__Deref_pre_valid_cap__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_z_bytecap_x__mixin = ` auto _Deref_pre_opt_z_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_z_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_z_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_z_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_pre_z_bytecap_x__mixin = ` auto _Deref_pre_z_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_z_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_z_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_z_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_z_cap_x__mixin = ` auto _Deref_pre_opt_z_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_z_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_z_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_z_cap_x__mixin);
    }


    enum _dpp_impl__Deref_pre_z_cap_x__mixin = ` auto _Deref_pre_z_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_z_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_z_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_z_cap_x__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_z_bytecap_c__mixin = ` auto _Deref_pre_opt_z_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_z_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_z_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_z_bytecap_c__mixin);
    }


    enum _dpp_impl__Deref_pre_z_bytecap_c__mixin = ` auto _Deref_pre_z_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_z_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_z_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_z_bytecap_c__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_z_cap_c__mixin = ` auto _Deref_pre_opt_z_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_z_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_z_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_z_cap_c__mixin);
    }


    enum _dpp_impl__Deref_pre_z_cap_c__mixin = ` auto _Deref_pre_z_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_z_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_z_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_z_cap_c__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_z_bytecap__mixin = ` auto _Deref_pre_opt_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_z_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_z_bytecap__mixin);
    }


    enum _dpp_impl__Deref_pre_z_bytecap__mixin = ` auto _Deref_pre_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_z_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_pre_z_bytecap__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_z_cap__mixin = ` auto _Deref_pre_opt_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_z_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_z_cap__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_z_cap__mixin);
    }


    enum _dpp_impl__Deref_pre_z_cap__mixin = ` auto _Deref_pre_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_z_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_z_cap__mixin); })) {
        mixin(_dpp_impl__Deref_pre_z_cap__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_bytecap_x__mixin = ` auto _Deref_pre_opt_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_pre_bytecap_x__mixin = ` auto _Deref_pre_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_bytecap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_bytecap_x__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_cap_x__mixin = ` auto _Deref_pre_opt_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_cap_x__mixin);
    }


    enum _dpp_impl__Deref_pre_cap_x__mixin = ` auto _Deref_pre_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_cap_x_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_cap_x__mixin); })) {
        mixin(_dpp_impl__Deref_pre_cap_x__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_bytecap_c__mixin = ` auto _Deref_pre_opt_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_bytecap_c__mixin);
    }


    enum _dpp_impl__Deref_pre_bytecap_c__mixin = ` auto _Deref_pre_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_bytecap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_bytecap_c__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_cap_c__mixin = ` auto _Deref_pre_opt_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_cap_c__mixin);
    }


    enum _dpp_impl__Deref_pre_cap_c__mixin = ` auto _Deref_pre_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_cap_c_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_cap_c__mixin); })) {
        mixin(_dpp_impl__Deref_pre_cap_c__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_bytecap__mixin = ` auto _Deref_pre_opt_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_bytecap__mixin);
    }


    enum _dpp_impl__Deref_pre_bytecap__mixin = ` auto _Deref_pre_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_bytecap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_bytecap__mixin); })) {
        mixin(_dpp_impl__Deref_pre_bytecap__mixin);
    }


    enum _dpp_impl__Deref_pre_opt_cap__mixin = ` auto _Deref_pre_opt_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_opt_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_opt_cap__mixin); })) {
        mixin(_dpp_impl__Deref_pre_opt_cap__mixin);
    }


    enum _dpp_impl__Deref_pre_cap__mixin = ` auto _Deref_pre_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Deref_pre_cap_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_pre_cap__mixin); })) {
        mixin(_dpp_impl__Deref_pre_cap__mixin);
    }




    static if(!is(typeof(_Deref_pre_opt_z_))) {
        private enum enumMixinStr__Deref_pre_opt_z_ = `enum _Deref_pre_opt_z_ = _SAL1_1_Source_ ( _Deref_pre_opt_z_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_pre_opt_z_); }))) {
            mixin(enumMixinStr__Deref_pre_opt_z_);
        }
    }




    static if(!is(typeof(_Deref_pre_z_))) {
        private enum enumMixinStr__Deref_pre_z_ = `enum _Deref_pre_z_ = _SAL1_1_Source_ ( _Deref_pre_z_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_pre_z_); }))) {
            mixin(enumMixinStr__Deref_pre_z_);
        }
    }




    static if(!is(typeof(_Deref_opt_out_opt_z_))) {
        private enum enumMixinStr__Deref_opt_out_opt_z_ = `enum _Deref_opt_out_opt_z_ = _SAL1_1_Source_ ( _Deref_opt_out_opt_z_ , ( ) , _Out_opt_ _SAL1_1_Source_ ( _Deref_post_opt_z_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_opt_out_opt_z_); }))) {
            mixin(enumMixinStr__Deref_opt_out_opt_z_);
        }
    }




    static if(!is(typeof(_Deref_opt_out_z_))) {
        private enum enumMixinStr__Deref_opt_out_z_ = `enum _Deref_opt_out_z_ = _SAL1_1_Source_ ( _Deref_opt_out_z_ , ( ) , _Out_opt_ _SAL1_1_Source_ ( _Deref_post_z_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_opt_out_z_); }))) {
            mixin(enumMixinStr__Deref_opt_out_z_);
        }
    }




    static if(!is(typeof(_Deref_out_opt_z_))) {
        private enum enumMixinStr__Deref_out_opt_z_ = `enum _Deref_out_opt_z_ = _SAL1_1_Source_ ( _Deref_out_opt_z_ , ( ) , _Out_ _SAL1_1_Source_ ( _Deref_post_opt_z_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_out_opt_z_); }))) {
            mixin(enumMixinStr__Deref_out_opt_z_);
        }
    }




    static if(!is(typeof(_Deref_out_z_))) {
        private enum enumMixinStr__Deref_out_z_ = `enum _Deref_out_z_ = _SAL1_1_Source_ ( _Deref_out_z_ , ( ) , _Out_ _SAL1_1_Source_ ( _Deref_post_z_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_out_z_); }))) {
            mixin(enumMixinStr__Deref_out_z_);
        }
    }




    static if(!is(typeof(_Deref_opt_out_opt_))) {
        private enum enumMixinStr__Deref_opt_out_opt_ = `enum _Deref_opt_out_opt_ = _SAL1_1_Source_ ( _Deref_opt_out_opt_ , ( ) , _Out_opt_ _SAL1_1_Source_ ( _Deref_post_opt_valid_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_opt_out_opt_); }))) {
            mixin(enumMixinStr__Deref_opt_out_opt_);
        }
    }




    static if(!is(typeof(_Deref_opt_out_))) {
        private enum enumMixinStr__Deref_opt_out_ = `enum _Deref_opt_out_ = _SAL1_1_Source_ ( _Deref_opt_out_ , ( ) , _Out_opt_ _SAL1_1_Source_ ( _Deref_post_valid_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_opt_out_); }))) {
            mixin(enumMixinStr__Deref_opt_out_);
        }
    }




    static if(!is(typeof(_Deref_out_opt_))) {
        private enum enumMixinStr__Deref_out_opt_ = `enum _Deref_out_opt_ = _SAL1_1_Source_ ( _Deref_out_opt_ , ( ) , _Out_ _SAL1_1_Source_ ( _Deref_post_opt_valid_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_out_opt_); }))) {
            mixin(enumMixinStr__Deref_out_opt_);
        }
    }




    static if(!is(typeof(_Deref_out_))) {
        private enum enumMixinStr__Deref_out_ = `enum _Deref_out_ = _SAL1_1_Source_ ( _Deref_out_ , ( ) , _Out_ _SAL1_1_Source_ ( _Deref_post_valid_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_out_); }))) {
            mixin(enumMixinStr__Deref_out_);
        }
    }




    static if(!is(typeof(_Deref_ret_bound_))) {
        private enum enumMixinStr__Deref_ret_bound_ = `enum _Deref_ret_bound_ = _SAL1_1_Source_ ( _Deref_ret_bound_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_ret_bound_); }))) {
            mixin(enumMixinStr__Deref_ret_bound_);
        }
    }




    static if(!is(typeof(_Deref_inout_bound_))) {
        private enum enumMixinStr__Deref_inout_bound_ = `enum _Deref_inout_bound_ = _SAL1_1_Source_ ( _Deref_inout_bound_ , ( ) , _Deref_in_bound_ _Deref_out_bound_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_inout_bound_); }))) {
            mixin(enumMixinStr__Deref_inout_bound_);
        }
    }




    static if(!is(typeof(_Deref_out_bound_))) {
        private enum enumMixinStr__Deref_out_bound_ = `enum _Deref_out_bound_ = _SAL1_1_Source_ ( _Deref_out_bound_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_out_bound_); }))) {
            mixin(enumMixinStr__Deref_out_bound_);
        }
    }




    static if(!is(typeof(_Deref_in_bound_))) {
        private enum enumMixinStr__Deref_in_bound_ = `enum _Deref_in_bound_ = _SAL1_1_Source_ ( _Deref_in_bound_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Deref_in_bound_); }))) {
            mixin(enumMixinStr__Deref_in_bound_);
        }
    }




    static if(!is(typeof(_Ret_bound_))) {
        private enum enumMixinStr__Ret_bound_ = `enum _Ret_bound_ = _SAL1_1_Source_ ( _Ret_bound_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Ret_bound_); }))) {
            mixin(enumMixinStr__Ret_bound_);
        }
    }




    static if(!is(typeof(_Out_bound_))) {
        private enum enumMixinStr__Out_bound_ = `enum _Out_bound_ = _SAL1_1_Source_ ( _Out_bound_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Out_bound_); }))) {
            mixin(enumMixinStr__Out_bound_);
        }
    }




    static if(!is(typeof(_In_bound_))) {
        private enum enumMixinStr__In_bound_ = `enum _In_bound_ = _SAL1_1_Source_ ( _In_bound_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__In_bound_); }))) {
            mixin(enumMixinStr__In_bound_);
        }
    }




    static if(!is(typeof(_Ret_opt_))) {
        private enum enumMixinStr__Ret_opt_ = `enum _Ret_opt_ = _SAL1_1_Source_ ( _Ret_opt_ , ( ) , _SAL1_1_Source_ ( _Ret_opt_valid_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Ret_opt_); }))) {
            mixin(enumMixinStr__Ret_opt_);
        }
    }




    static if(!is(typeof(_Ret_))) {
        private enum enumMixinStr__Ret_ = `enum _Ret_ = _SAL1_1_Source_ ( _Ret_ , ( ) , _Ret_valid_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Ret_); }))) {
            mixin(enumMixinStr__Ret_);
        }
    }


    enum _dpp_impl__Inout_opt_z_bytecap_x__mixin = ` auto _Inout_opt_z_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_z_bytecap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_z_bytecap_x_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_z_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Inout_opt_z_bytecap_x__mixin);
    }


    enum _dpp_impl__Inout_z_bytecap_x__mixin = ` auto _Inout_z_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_z_bytecap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_z_bytecap_x_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_z_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Inout_z_bytecap_x__mixin);
    }


    enum _dpp_impl__Inout_opt_z_cap_x__mixin = ` auto _Inout_opt_z_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_z_cap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_z_cap_x_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_z_cap_x__mixin); })) {
        mixin(_dpp_impl__Inout_opt_z_cap_x__mixin);
    }


    enum _dpp_impl__Inout_z_cap_x__mixin = ` auto _Inout_z_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_z_cap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_z_cap_x_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_z_cap_x__mixin); })) {
        mixin(_dpp_impl__Inout_z_cap_x__mixin);
    }


    enum _dpp_impl__Inout_opt_z_bytecap_c__mixin = ` auto _Inout_opt_z_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_z_bytecap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_z_bytecap_c_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_z_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Inout_opt_z_bytecap_c__mixin);
    }


    enum _dpp_impl__Inout_z_bytecap_c__mixin = ` auto _Inout_z_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_z_bytecap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_z_bytecap_c_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_z_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Inout_z_bytecap_c__mixin);
    }


    enum _dpp_impl__Inout_opt_z_cap_c__mixin = ` auto _Inout_opt_z_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_z_cap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_z_cap_c_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_z_cap_c__mixin); })) {
        mixin(_dpp_impl__Inout_opt_z_cap_c__mixin);
    }


    enum _dpp_impl__Inout_z_cap_c__mixin = ` auto _Inout_z_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_z_cap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_z_cap_c_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_z_cap_c__mixin); })) {
        mixin(_dpp_impl__Inout_z_cap_c__mixin);
    }


    enum _dpp_impl__Inout_opt_z_bytecap__mixin = ` auto _Inout_opt_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_z_bytecap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_z_bytecap_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Inout_opt_z_bytecap__mixin);
    }


    enum _dpp_impl__Inout_z_bytecap__mixin = ` auto _Inout_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_z_bytecap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_z_bytecap_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Inout_z_bytecap__mixin);
    }


    enum _dpp_impl__Inout_opt_z_cap__mixin = ` auto _Inout_opt_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_z_cap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_z_cap_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_z_cap__mixin); })) {
        mixin(_dpp_impl__Inout_opt_z_cap__mixin);
    }


    enum _dpp_impl__Inout_z_cap__mixin = ` auto _Inout_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_z_cap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_z_cap_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_z_cap__mixin); })) {
        mixin(_dpp_impl__Inout_z_cap__mixin);
    }


    enum _dpp_impl__Inout_opt_bytecap_x__mixin = ` auto _Inout_opt_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_bytecap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_valid_bytecap_x_ , ( arg0 ) , ) _Post_valid_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Inout_opt_bytecap_x__mixin);
    }


    enum _dpp_impl__Inout_bytecap_x__mixin = ` auto _Inout_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_bytecap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_valid_bytecap_x_ , ( arg0 ) , ) _Post_valid_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Inout_bytecap_x__mixin);
    }


    enum _dpp_impl__Inout_opt_cap_x__mixin = ` auto _Inout_opt_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_cap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_valid_cap_x_ , ( arg0 ) , ) _Post_valid_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_cap_x__mixin); })) {
        mixin(_dpp_impl__Inout_opt_cap_x__mixin);
    }


    enum _dpp_impl__Inout_cap_x__mixin = ` auto _Inout_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_cap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_valid_cap_x_ , ( arg0 ) , ) _Post_valid_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_cap_x__mixin); })) {
        mixin(_dpp_impl__Inout_cap_x__mixin);
    }


    enum _dpp_impl__Inout_opt_bytecap_c__mixin = ` auto _Inout_opt_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_bytecap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_valid_bytecap_c_ , ( arg0 ) , ) _Post_valid_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Inout_opt_bytecap_c__mixin);
    }


    enum _dpp_impl__Inout_bytecap_c__mixin = ` auto _Inout_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_bytecap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_valid_bytecap_c_ , ( arg0 ) , ) _Post_valid_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Inout_bytecap_c__mixin);
    }


    enum _dpp_impl__Inout_opt_cap_c__mixin = ` auto _Inout_opt_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_cap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_valid_cap_c_ , ( arg0 ) , ) _Post_valid_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_cap_c__mixin); })) {
        mixin(_dpp_impl__Inout_opt_cap_c__mixin);
    }


    enum _dpp_impl__Inout_cap_c__mixin = ` auto _Inout_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_cap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_valid_cap_c_ , ( arg0 ) , ) _Post_valid_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_cap_c__mixin); })) {
        mixin(_dpp_impl__Inout_cap_c__mixin);
    }


    enum _dpp_impl__Inout_opt_bytecap__mixin = ` auto _Inout_opt_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_bytecap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_valid_bytecap_ , ( arg0 ) , ) _Post_valid_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_bytecap__mixin); })) {
        mixin(_dpp_impl__Inout_opt_bytecap__mixin);
    }


    enum _dpp_impl__Inout_bytecap__mixin = ` auto _Inout_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_bytecap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_valid_bytecap_ , ( arg0 ) , ) _Post_valid_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_bytecap__mixin); })) {
        mixin(_dpp_impl__Inout_bytecap__mixin);
    }


    enum _dpp_impl__Inout_opt_cap__mixin = ` auto _Inout_opt_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_cap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_valid_cap_ , ( arg0 ) , ) _Post_valid_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_cap__mixin); })) {
        mixin(_dpp_impl__Inout_opt_cap__mixin);
    }


    enum _dpp_impl__Inout_cap__mixin = ` auto _Inout_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_cap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_valid_cap_ , ( arg0 ) , ) _Post_valid_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_cap__mixin); })) {
        mixin(_dpp_impl__Inout_cap__mixin);
    }


    enum _dpp_impl__Inout_opt_bytecount_x__mixin = ` auto _Inout_opt_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_bytecount_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Prepost_opt_bytecount_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecount_x_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_x_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Inout_opt_bytecount_x__mixin);
    }


    enum _dpp_impl__Inout_bytecount_x__mixin = ` auto _Inout_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_bytecount_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Prepost_bytecount_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecount_x_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_x_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_bytecount_x__mixin); })) {
        mixin(_dpp_impl__Inout_bytecount_x__mixin);
    }


    enum _dpp_impl__Inout_opt_count_x__mixin = ` auto _Inout_opt_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_count_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Prepost_opt_count_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_count_x_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_x_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_count_x__mixin); })) {
        mixin(_dpp_impl__Inout_opt_count_x__mixin);
    }


    enum _dpp_impl__Inout_count_x__mixin = ` auto _Inout_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_count_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Prepost_count_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_count_x_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_x_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_count_x__mixin); })) {
        mixin(_dpp_impl__Inout_count_x__mixin);
    }


    enum _dpp_impl__Inout_opt_ptrdiff_count__mixin = ` auto _Inout_opt_ptrdiff_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_ptrdiff_count_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_ptrdiff_count_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_ptrdiff_count__mixin); })) {
        mixin(_dpp_impl__Inout_opt_ptrdiff_count__mixin);
    }


    enum _dpp_impl__Inout_ptrdiff_count__mixin = ` auto _Inout_ptrdiff_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_ptrdiff_count_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_ptrdiff_count_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_ptrdiff_count__mixin); })) {
        mixin(_dpp_impl__Inout_ptrdiff_count__mixin);
    }


    enum _dpp_impl__Inout_opt_z_bytecount_c__mixin = ` auto _Inout_opt_z_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_z_bytecount_c_ , ( arg0 ) , _Prepost_z_ _SAL1_1_Source_ ( _Prepost_opt_bytecount_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecount_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_c_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_z_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Inout_opt_z_bytecount_c__mixin);
    }


    enum _dpp_impl__Inout_z_bytecount_c__mixin = ` auto _Inout_z_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_z_bytecount_c_ , ( arg0 ) , _Prepost_z_ _SAL1_1_Source_ ( _Prepost_bytecount_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecount_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_c_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_z_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Inout_z_bytecount_c__mixin);
    }


    enum _dpp_impl__Inout_opt_z_count_c__mixin = ` auto _Inout_opt_z_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_z_count_c_ , ( arg0 ) , _Prepost_z_ _SAL1_1_Source_ ( _Prepost_opt_count_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_count_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_c_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_z_count_c__mixin); })) {
        mixin(_dpp_impl__Inout_opt_z_count_c__mixin);
    }


    enum _dpp_impl__Inout_z_count_c__mixin = ` auto _Inout_z_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_z_count_c_ , ( arg0 ) , _Prepost_z_ _SAL1_1_Source_ ( _Prepost_count_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_count_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_c_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_z_count_c__mixin); })) {
        mixin(_dpp_impl__Inout_z_count_c__mixin);
    }


    enum _dpp_impl__Inout_opt_z_bytecount__mixin = ` auto _Inout_opt_z_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_z_bytecount_ , ( arg0 ) , _Prepost_z_ _SAL1_1_Source_ ( _Prepost_opt_bytecount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecount_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_z_bytecount__mixin); })) {
        mixin(_dpp_impl__Inout_opt_z_bytecount__mixin);
    }


    enum _dpp_impl__Inout_z_bytecount__mixin = ` auto _Inout_z_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_z_bytecount_ , ( arg0 ) , _Prepost_z_ _SAL1_1_Source_ ( _Prepost_bytecount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecount_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_z_bytecount__mixin); })) {
        mixin(_dpp_impl__Inout_z_bytecount__mixin);
    }


    enum _dpp_impl__Inout_opt_z_count__mixin = ` auto _Inout_opt_z_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_z_count_ , ( arg0 ) , _Prepost_z_ _SAL1_1_Source_ ( _Prepost_opt_count_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_z_count__mixin); })) {
        mixin(_dpp_impl__Inout_opt_z_count__mixin);
    }


    enum _dpp_impl__Inout_z_count__mixin = ` auto _Inout_z_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_z_count_ , ( arg0 ) , _Prepost_z_ _SAL1_1_Source_ ( _Prepost_count_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_z_count__mixin); })) {
        mixin(_dpp_impl__Inout_z_count__mixin);
    }


    enum _dpp_impl__Inout_opt_bytecount_c__mixin = ` auto _Inout_opt_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_bytecount_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Prepost_opt_bytecount_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecount_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_c_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Inout_opt_bytecount_c__mixin);
    }


    enum _dpp_impl__Inout_bytecount_c__mixin = ` auto _Inout_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_bytecount_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Prepost_bytecount_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecount_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_c_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_bytecount_c__mixin); })) {
        mixin(_dpp_impl__Inout_bytecount_c__mixin);
    }


    enum _dpp_impl__Inout_opt_count_c__mixin = ` auto _Inout_opt_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_count_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Prepost_opt_count_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_count_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_c_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_count_c__mixin); })) {
        mixin(_dpp_impl__Inout_opt_count_c__mixin);
    }


    enum _dpp_impl__Inout_count_c__mixin = ` auto _Inout_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_count_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Prepost_count_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_count_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_c_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_count_c__mixin); })) {
        mixin(_dpp_impl__Inout_count_c__mixin);
    }


    enum _dpp_impl__Inout_opt_bytecount__mixin = ` auto _Inout_opt_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_bytecount_ , ( arg0 ) , _SAL1_1_Source_ ( _Prepost_opt_bytecount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecount_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_bytecount__mixin); })) {
        mixin(_dpp_impl__Inout_opt_bytecount__mixin);
    }


    enum _dpp_impl__Inout_bytecount__mixin = ` auto _Inout_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_bytecount_ , ( arg0 ) , _SAL1_1_Source_ ( _Prepost_bytecount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecount_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_bytecount__mixin); })) {
        mixin(_dpp_impl__Inout_bytecount__mixin);
    }


    enum _dpp_impl__Inout_opt_count__mixin = ` auto _Inout_opt_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_opt_count_ , ( arg0 ) , _SAL1_1_Source_ ( _Prepost_opt_count_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_opt_count__mixin); })) {
        mixin(_dpp_impl__Inout_opt_count__mixin);
    }


    enum _dpp_impl__Inout_count__mixin = ` auto _Inout_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Inout_count_ , ( arg0 ) , _SAL1_1_Source_ ( _Prepost_count_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_ , ( arg0 ) , ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_count__mixin); })) {
        mixin(_dpp_impl__Inout_count__mixin);
    }


    enum _dpp_impl__Out_opt_z_bytecapcount__mixin = ` auto _Out_opt_z_bytecapcount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_z_bytecapcount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_z_bytecount_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_z_bytecapcount__mixin); })) {
        mixin(_dpp_impl__Out_opt_z_bytecapcount__mixin);
    }


    enum _dpp_impl__Out_z_bytecapcount__mixin = ` auto _Out_z_bytecapcount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_z_bytecapcount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_z_bytecount_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_z_bytecapcount__mixin); })) {
        mixin(_dpp_impl__Out_z_bytecapcount__mixin);
    }


    enum _dpp_impl__Out_opt_z_capcount__mixin = ` auto _Out_opt_z_capcount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_z_capcount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_cap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_z_count_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_z_capcount__mixin); })) {
        mixin(_dpp_impl__Out_opt_z_capcount__mixin);
    }


    enum _dpp_impl__Out_z_capcount__mixin = ` auto _Out_z_capcount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_z_capcount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_cap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_z_count_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_z_capcount__mixin); })) {
        mixin(_dpp_impl__Out_z_capcount__mixin);
    }


    enum _dpp_impl__Out_opt_bytecapcount_x__mixin = ` auto _Out_opt_bytecapcount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_bytecapcount_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_x_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_x_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_bytecapcount_x__mixin); })) {
        mixin(_dpp_impl__Out_opt_bytecapcount_x__mixin);
    }


    enum _dpp_impl__Out_bytecapcount_x__mixin = ` auto _Out_bytecapcount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_bytecapcount_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecap_x_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_x_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_bytecapcount_x__mixin); })) {
        mixin(_dpp_impl__Out_bytecapcount_x__mixin);
    }


    enum _dpp_impl__Out_opt_capcount_x__mixin = ` auto _Out_opt_capcount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_capcount_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_cap_x_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_x_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_capcount_x__mixin); })) {
        mixin(_dpp_impl__Out_opt_capcount_x__mixin);
    }


    enum _dpp_impl__Out_capcount_x__mixin = ` auto _Out_capcount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_capcount_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_cap_x_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_x_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_capcount_x__mixin); })) {
        mixin(_dpp_impl__Out_capcount_x__mixin);
    }


    enum _dpp_impl__Out_opt_bytecapcount__mixin = ` auto _Out_opt_bytecapcount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_bytecapcount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_bytecapcount__mixin); })) {
        mixin(_dpp_impl__Out_opt_bytecapcount__mixin);
    }


    enum _dpp_impl__Out_bytecapcount__mixin = ` auto _Out_bytecapcount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_bytecapcount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_bytecapcount__mixin); })) {
        mixin(_dpp_impl__Out_bytecapcount__mixin);
    }


    enum _dpp_impl__Out_opt_capcount__mixin = ` auto _Out_opt_capcount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_capcount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_cap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_capcount__mixin); })) {
        mixin(_dpp_impl__Out_opt_capcount__mixin);
    }


    enum _dpp_impl__Out_capcount__mixin = ` auto _Out_capcount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_capcount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_cap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_capcount__mixin); })) {
        mixin(_dpp_impl__Out_capcount__mixin);
    }


    enum _dpp_impl__Out_opt_z_bytecap_post_bytecount__mixin = ` auto _Out_opt_z_bytecap_post_bytecount_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Out_opt_z_bytecap_post_bytecount_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_z_bytecount_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_z_bytecap_post_bytecount__mixin); })) {
        mixin(_dpp_impl__Out_opt_z_bytecap_post_bytecount__mixin);
    }


    enum _dpp_impl__Out_z_bytecap_post_bytecount__mixin = ` auto _Out_z_bytecap_post_bytecount_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Out_z_bytecap_post_bytecount_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_bytecap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_z_bytecount_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_z_bytecap_post_bytecount__mixin); })) {
        mixin(_dpp_impl__Out_z_bytecap_post_bytecount__mixin);
    }


    enum _dpp_impl__Out_opt_z_cap_post_count__mixin = ` auto _Out_opt_z_cap_post_count_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Out_opt_z_cap_post_count_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_opt_cap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_z_count_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_z_cap_post_count__mixin); })) {
        mixin(_dpp_impl__Out_opt_z_cap_post_count__mixin);
    }


    enum _dpp_impl__Out_z_cap_post_count__mixin = ` auto _Out_z_cap_post_count_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Out_z_cap_post_count_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_cap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_z_count_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_z_cap_post_count__mixin); })) {
        mixin(_dpp_impl__Out_z_cap_post_count__mixin);
    }


    enum _dpp_impl__Out_opt_bytecap_post_bytecount__mixin = ` auto _Out_opt_bytecap_post_bytecount_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Out_opt_bytecap_post_bytecount_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_bytecap_post_bytecount__mixin); })) {
        mixin(_dpp_impl__Out_opt_bytecap_post_bytecount__mixin);
    }


    enum _dpp_impl__Out_bytecap_post_bytecount__mixin = ` auto _Out_bytecap_post_bytecount_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Out_bytecap_post_bytecount_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_bytecap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_bytecap_post_bytecount__mixin); })) {
        mixin(_dpp_impl__Out_bytecap_post_bytecount__mixin);
    }


    enum _dpp_impl__Out_opt_cap_post_count__mixin = ` auto _Out_opt_cap_post_count_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Out_opt_cap_post_count_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_opt_cap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_cap_post_count__mixin); })) {
        mixin(_dpp_impl__Out_opt_cap_post_count__mixin);
    }


    enum _dpp_impl__Out_cap_post_count__mixin = ` auto _Out_cap_post_count_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Out_cap_post_count_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_cap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_cap_post_count__mixin); })) {
        mixin(_dpp_impl__Out_cap_post_count__mixin);
    }


    enum _dpp_impl__Out_opt_z_bytecap_x__mixin = ` auto _Out_opt_z_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_z_bytecap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_x_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_z_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Out_opt_z_bytecap_x__mixin);
    }


    enum _dpp_impl__Out_z_bytecap_x__mixin = ` auto _Out_z_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_z_bytecap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecap_x_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_z_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Out_z_bytecap_x__mixin);
    }


    enum _dpp_impl__Out_opt_z_cap_x__mixin = ` auto _Out_opt_z_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_z_cap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_cap_x_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_z_cap_x__mixin); })) {
        mixin(_dpp_impl__Out_opt_z_cap_x__mixin);
    }


    enum _dpp_impl__Out_z_cap_x__mixin = ` auto _Out_z_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_z_cap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_cap_x_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_z_cap_x__mixin); })) {
        mixin(_dpp_impl__Out_z_cap_x__mixin);
    }


    enum _dpp_impl__Out_opt_z_bytecap_c__mixin = ` auto _Out_opt_z_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_z_bytecap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_c_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_z_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Out_opt_z_bytecap_c__mixin);
    }


    enum _dpp_impl__Out_z_bytecap_c__mixin = ` auto _Out_z_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_z_bytecap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecap_c_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_z_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Out_z_bytecap_c__mixin);
    }


    enum _dpp_impl__Out_opt_z_cap_c__mixin = ` auto _Out_opt_z_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_z_cap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_cap_c_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_z_cap_c__mixin); })) {
        mixin(_dpp_impl__Out_opt_z_cap_c__mixin);
    }


    enum _dpp_impl__Out_z_cap_c__mixin = ` auto _Out_z_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_z_cap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_cap_c_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_z_cap_c__mixin); })) {
        mixin(_dpp_impl__Out_z_cap_c__mixin);
    }


    enum _dpp_impl__Out_opt_z_bytecap__mixin = ` auto _Out_opt_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_z_bytecap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Out_opt_z_bytecap__mixin);
    }


    enum _dpp_impl__Out_z_bytecap__mixin = ` auto _Out_z_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_z_bytecap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecap_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_z_bytecap__mixin); })) {
        mixin(_dpp_impl__Out_z_bytecap__mixin);
    }


    enum _dpp_impl__Out_opt_z_cap__mixin = ` auto _Out_opt_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_z_cap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_cap_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_z_cap__mixin); })) {
        mixin(_dpp_impl__Out_opt_z_cap__mixin);
    }


    enum _dpp_impl__Out_z_cap__mixin = ` auto _Out_z_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_z_cap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_cap_ , ( arg0 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_z_cap__mixin); })) {
        mixin(_dpp_impl__Out_z_cap__mixin);
    }


    enum _dpp_impl__Out_opt_bytecap_x__mixin = ` auto _Out_opt_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_bytecap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_x_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Out_opt_bytecap_x__mixin);
    }


    enum _dpp_impl__Out_bytecap_x__mixin = ` auto _Out_bytecap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_bytecap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecap_x_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_bytecap_x__mixin); })) {
        mixin(_dpp_impl__Out_bytecap_x__mixin);
    }


    enum _dpp_impl__Out_opt_cap_x__mixin = ` auto _Out_opt_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_cap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_cap_x_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_cap_x__mixin); })) {
        mixin(_dpp_impl__Out_opt_cap_x__mixin);
    }


    enum _dpp_impl__Out_cap_x__mixin = ` auto _Out_cap_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_cap_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_cap_x_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_cap_x__mixin); })) {
        mixin(_dpp_impl__Out_cap_x__mixin);
    }


    enum _dpp_impl__Out_opt_ptrdiff_cap__mixin = ` auto _Out_opt_ptrdiff_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_ptrdiff_cap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_ptrdiff_cap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_ptrdiff_cap__mixin); })) {
        mixin(_dpp_impl__Out_opt_ptrdiff_cap__mixin);
    }


    enum _dpp_impl__Out_ptrdiff_cap__mixin = ` auto _Out_ptrdiff_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_ptrdiff_cap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_ptrdiff_cap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_ptrdiff_cap__mixin); })) {
        mixin(_dpp_impl__Out_ptrdiff_cap__mixin);
    }


    enum _dpp_impl__Out_opt_z_cap_m__mixin = ` auto _Out_opt_z_cap_m_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Out_opt_z_cap_m_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_opt_cap_m_ , ( arg0 , arg1 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_z_cap_m__mixin); })) {
        mixin(_dpp_impl__Out_opt_z_cap_m__mixin);
    }


    enum _dpp_impl__Out_z_cap_m__mixin = ` auto _Out_z_cap_m_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Out_z_cap_m_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_cap_m_ , ( arg0 , arg1 ) , ) _Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_z_cap_m__mixin); })) {
        mixin(_dpp_impl__Out_z_cap_m__mixin);
    }


    enum _dpp_impl__Out_opt_cap_m__mixin = ` auto _Out_opt_cap_m_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Out_opt_cap_m_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_opt_cap_m_ , ( arg0 , arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_cap_m__mixin); })) {
        mixin(_dpp_impl__Out_opt_cap_m__mixin);
    }


    enum _dpp_impl__Out_cap_m__mixin = ` auto _Out_cap_m_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL1_1_Source_ ( _Out_cap_m_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_cap_m_ , ( arg0 , arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_cap_m__mixin); })) {
        mixin(_dpp_impl__Out_cap_m__mixin);
    }


    enum _dpp_impl__Out_opt_bytecap_c__mixin = ` auto _Out_opt_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_bytecap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_c_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Out_opt_bytecap_c__mixin);
    }


    enum _dpp_impl__Out_bytecap_c__mixin = ` auto _Out_bytecap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_bytecap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecap_c_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_bytecap_c__mixin); })) {
        mixin(_dpp_impl__Out_bytecap_c__mixin);
    }


    enum _dpp_impl__Out_opt_cap_c__mixin = ` auto _Out_opt_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_cap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_cap_c_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_cap_c__mixin); })) {
        mixin(_dpp_impl__Out_opt_cap_c__mixin);
    }


    enum _dpp_impl__Out_cap_c__mixin = ` auto _Out_cap_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_cap_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_cap_c_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_cap_c__mixin); })) {
        mixin(_dpp_impl__Out_cap_c__mixin);
    }


    enum _dpp_impl__Out_opt_bytecap__mixin = ` auto _Out_opt_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_bytecap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_bytecap__mixin); })) {
        mixin(_dpp_impl__Out_opt_bytecap__mixin);
    }


    enum _dpp_impl__Out_bytecap__mixin = ` auto _Out_bytecap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_bytecap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_bytecap__mixin); })) {
        mixin(_dpp_impl__Out_bytecap__mixin);
    }


    enum _dpp_impl__Out_opt_cap__mixin = ` auto _Out_opt_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_opt_cap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_cap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_opt_cap__mixin); })) {
        mixin(_dpp_impl__Out_opt_cap__mixin);
    }


    enum _dpp_impl__Out_cap__mixin = ` auto _Out_cap_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _Out_cap_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_cap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_cap__mixin); })) {
        mixin(_dpp_impl__Out_cap__mixin);
    }


    enum _dpp_impl__In_opt_bytecount_x__mixin = ` auto _In_opt_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_opt_bytecount_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecount_x_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_opt_bytecount_x__mixin); })) {
        mixin(_dpp_impl__In_opt_bytecount_x__mixin);
    }


    enum _dpp_impl__In_bytecount_x__mixin = ` auto _In_bytecount_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_bytecount_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecount_x_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_bytecount_x__mixin); })) {
        mixin(_dpp_impl__In_bytecount_x__mixin);
    }


    enum _dpp_impl__In_opt_count_x__mixin = ` auto _In_opt_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_opt_count_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_count_x_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_opt_count_x__mixin); })) {
        mixin(_dpp_impl__In_opt_count_x__mixin);
    }


    enum _dpp_impl__In_count_x__mixin = ` auto _In_count_x_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_count_x_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_count_x_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_count_x__mixin); })) {
        mixin(_dpp_impl__In_count_x__mixin);
    }


    enum _dpp_impl__In_opt_ptrdiff_count__mixin = ` auto _In_opt_ptrdiff_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_opt_ptrdiff_count_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_ptrdiff_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_opt_ptrdiff_count__mixin); })) {
        mixin(_dpp_impl__In_opt_ptrdiff_count__mixin);
    }


    enum _dpp_impl__In_ptrdiff_count__mixin = ` auto _In_ptrdiff_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_ptrdiff_count_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_ptrdiff_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_ptrdiff_count__mixin); })) {
        mixin(_dpp_impl__In_ptrdiff_count__mixin);
    }


    enum _dpp_impl__In_opt_z_bytecount_c__mixin = ` auto _In_opt_z_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_opt_z_bytecount_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_z_ , ( ) , ) _SAL1_1_Source_ ( _Pre_opt_bytecount_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_opt_z_bytecount_c__mixin); })) {
        mixin(_dpp_impl__In_opt_z_bytecount_c__mixin);
    }


    enum _dpp_impl__In_z_bytecount_c__mixin = ` auto _In_z_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_z_bytecount_c_ , ( arg0 ) , _Pre_z_ _SAL1_1_Source_ ( _Pre_bytecount_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_z_bytecount_c__mixin); })) {
        mixin(_dpp_impl__In_z_bytecount_c__mixin);
    }


    enum _dpp_impl__In_opt_z_count_c__mixin = ` auto _In_opt_z_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_opt_z_count_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_z_ , ( ) , ) _SAL1_1_Source_ ( _Pre_opt_count_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_opt_z_count_c__mixin); })) {
        mixin(_dpp_impl__In_opt_z_count_c__mixin);
    }


    enum _dpp_impl__In_z_count_c__mixin = ` auto _In_z_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_z_count_c_ , ( arg0 ) , _Pre_z_ _SAL1_1_Source_ ( _Pre_count_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_z_count_c__mixin); })) {
        mixin(_dpp_impl__In_z_count_c__mixin);
    }


    enum _dpp_impl__In_opt_z_bytecount__mixin = ` auto _In_opt_z_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_opt_z_bytecount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_z_ , ( ) , ) _SAL1_1_Source_ ( _Pre_opt_bytecount_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_opt_z_bytecount__mixin); })) {
        mixin(_dpp_impl__In_opt_z_bytecount__mixin);
    }


    enum _dpp_impl__In_z_bytecount__mixin = ` auto _In_z_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_z_bytecount_ , ( arg0 ) , _Pre_z_ _SAL1_1_Source_ ( _Pre_bytecount_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_z_bytecount__mixin); })) {
        mixin(_dpp_impl__In_z_bytecount__mixin);
    }


    enum _dpp_impl__In_opt_z_count__mixin = ` auto _In_opt_z_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_opt_z_count_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_z_ , ( ) , ) _SAL1_1_Source_ ( _Pre_opt_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_opt_z_count__mixin); })) {
        mixin(_dpp_impl__In_opt_z_count__mixin);
    }


    enum _dpp_impl__In_z_count__mixin = ` auto _In_z_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_z_count_ , ( arg0 ) , _Pre_z_ _SAL1_1_Source_ ( _Pre_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_z_count__mixin); })) {
        mixin(_dpp_impl__In_z_count__mixin);
    }


    enum _dpp_impl__In_opt_bytecount_c__mixin = ` auto _In_opt_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_opt_bytecount_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecount_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_opt_bytecount_c__mixin); })) {
        mixin(_dpp_impl__In_opt_bytecount_c__mixin);
    }


    enum _dpp_impl__In_bytecount_c__mixin = ` auto _In_bytecount_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_bytecount_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecount_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_bytecount_c__mixin); })) {
        mixin(_dpp_impl__In_bytecount_c__mixin);
    }


    enum _dpp_impl__In_opt_count_c__mixin = ` auto _In_opt_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_opt_count_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_count_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_opt_count_c__mixin); })) {
        mixin(_dpp_impl__In_opt_count_c__mixin);
    }


    enum _dpp_impl__In_count_c__mixin = ` auto _In_count_c_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_count_c_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_count_c_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_count_c__mixin); })) {
        mixin(_dpp_impl__In_count_c__mixin);
    }


    enum _dpp_impl__In_opt_bytecount__mixin = ` auto _In_opt_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_opt_bytecount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecount_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_opt_bytecount__mixin); })) {
        mixin(_dpp_impl__In_opt_bytecount__mixin);
    }


    enum _dpp_impl__In_bytecount__mixin = ` auto _In_bytecount_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_bytecount_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecount_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_bytecount__mixin); })) {
        mixin(_dpp_impl__In_bytecount__mixin);
    }


    enum _dpp_impl__In_opt_count__mixin = ` auto _In_opt_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_opt_count_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_opt_count__mixin); })) {
        mixin(_dpp_impl__In_opt_count__mixin);
    }


    enum _dpp_impl__In_count__mixin = ` auto _In_count_(A0)(A0 arg0) {
        return _SAL1_1_Source_ ( _In_count_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_count__mixin); })) {
        mixin(_dpp_impl__In_count__mixin);
    }




    static if(!is(typeof(_Prepost_z_))) {
        private enum enumMixinStr__Prepost_z_ = `enum _Prepost_z_ = _SAL2_Source_ ( _Prepost_z_ , ( ) , _Pre_z_ _Post_z_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Prepost_z_); }))) {
            mixin(enumMixinStr__Prepost_z_);
        }
    }




    static if(!is(typeof(_Post_maybenull_))) {
        private enum enumMixinStr__Post_maybenull_ = `enum _Post_maybenull_ = _SAL2_Source_ ( _Post_maybenull_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Post_maybenull_); }))) {
            mixin(enumMixinStr__Post_maybenull_);
        }
    }




    static if(!is(typeof(_Post_null_))) {
        private enum enumMixinStr__Post_null_ = `enum _Post_null_ = _SAL2_Source_ ( _Post_null_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Post_null_); }))) {
            mixin(enumMixinStr__Post_null_);
        }
    }




    static if(!is(typeof(_Post_notnull_))) {
        private enum enumMixinStr__Post_notnull_ = `enum _Post_notnull_ = _SAL2_Source_ ( _Post_notnull_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Post_notnull_); }))) {
            mixin(enumMixinStr__Post_notnull_);
        }
    }




    static if(!is(typeof(_Post_ptr_invalid_))) {
        private enum enumMixinStr__Post_ptr_invalid_ = `enum _Post_ptr_invalid_ = _SAL2_Source_ ( _Post_ptr_invalid_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Post_ptr_invalid_); }))) {
            mixin(enumMixinStr__Post_ptr_invalid_);
        }
    }




    static if(!is(typeof(_Post_invalid_))) {
        private enum enumMixinStr__Post_invalid_ = `enum _Post_invalid_ = _SAL2_Source_ ( _Post_invalid_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Post_invalid_); }))) {
            mixin(enumMixinStr__Post_invalid_);
        }
    }




    static if(!is(typeof(_Post_valid_))) {
        private enum enumMixinStr__Post_valid_ = `enum _Post_valid_ = _SAL2_Source_ ( _Post_valid_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Post_valid_); }))) {
            mixin(enumMixinStr__Post_valid_);
        }
    }




    static if(!is(typeof(_Post_z_))) {
        private enum enumMixinStr__Post_z_ = `enum _Post_z_ = _SAL2_Source_ ( _Post_z_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Post_z_); }))) {
            mixin(enumMixinStr__Post_z_);
        }
    }




    static if(!is(typeof(_Pre_null_))) {
        private enum enumMixinStr__Pre_null_ = `enum _Pre_null_ = _SAL2_Source_ ( _Pre_null_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_null_); }))) {
            mixin(enumMixinStr__Pre_null_);
        }
    }




    static if(!is(typeof(_Pre_maybenull_))) {
        private enum enumMixinStr__Pre_maybenull_ = `enum _Pre_maybenull_ = _SAL2_Source_ ( _Pre_maybenull_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_maybenull_); }))) {
            mixin(enumMixinStr__Pre_maybenull_);
        }
    }




    static if(!is(typeof(_Pre_notnull_))) {
        private enum enumMixinStr__Pre_notnull_ = `enum _Pre_notnull_ = _SAL2_Source_ ( _Pre_notnull_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_notnull_); }))) {
            mixin(enumMixinStr__Pre_notnull_);
        }
    }




    static if(!is(typeof(_Pre_unknown_))) {
        private enum enumMixinStr__Pre_unknown_ = `enum _Pre_unknown_ = _SAL2_Source_ ( _Pre_unknown_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_unknown_); }))) {
            mixin(enumMixinStr__Pre_unknown_);
        }
    }




    static if(!is(typeof(_Pre_invalid_))) {
        private enum enumMixinStr__Pre_invalid_ = `enum _Pre_invalid_ = _SAL2_Source_ ( _Pre_invalid_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_invalid_); }))) {
            mixin(enumMixinStr__Pre_invalid_);
        }
    }




    static if(!is(typeof(_Pre_opt_valid_))) {
        private enum enumMixinStr__Pre_opt_valid_ = `enum _Pre_opt_valid_ = _SAL2_Source_ ( _Pre_opt_valid_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_opt_valid_); }))) {
            mixin(enumMixinStr__Pre_opt_valid_);
        }
    }




    static if(!is(typeof(_Pre_valid_))) {
        private enum enumMixinStr__Pre_valid_ = `enum _Pre_valid_ = _SAL2_Source_ ( _Pre_valid_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_valid_); }))) {
            mixin(enumMixinStr__Pre_valid_);
        }
    }




    static if(!is(typeof(_Pre_z_))) {
        private enum enumMixinStr__Pre_z_ = `enum _Pre_z_ = _SAL2_Source_ ( _Pre_z_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_z_); }))) {
            mixin(enumMixinStr__Pre_z_);
        }
    }




    static if(!is(typeof(_Maybenull_))) {
        private enum enumMixinStr__Maybenull_ = `enum _Maybenull_ = _SAL2_Source_ ( _Maybenull_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Maybenull_); }))) {
            mixin(enumMixinStr__Maybenull_);
        }
    }




    static if(!is(typeof(_Notnull_))) {
        private enum enumMixinStr__Notnull_ = `enum _Notnull_ = _SAL2_Source_ ( _Notnull_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Notnull_); }))) {
            mixin(enumMixinStr__Notnull_);
        }
    }




    static if(!is(typeof(_Null_))) {
        private enum enumMixinStr__Null_ = `enum _Null_ = _SAL2_Source_ ( _Null_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Null_); }))) {
            mixin(enumMixinStr__Null_);
        }
    }


    enum _dpp_impl__Post_writable_byte_size__mixin = ` auto _Post_writable_byte_size_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Post_writable_byte_size_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_writable_byte_size__mixin); })) {
        mixin(_dpp_impl__Post_writable_byte_size__mixin);
    }


    enum _dpp_impl__Post_readable_byte_size__mixin = ` auto _Post_readable_byte_size_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Post_readable_byte_size_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_readable_byte_size__mixin); })) {
        mixin(_dpp_impl__Post_readable_byte_size__mixin);
    }


    enum _dpp_impl__Post_writable_size__mixin = ` auto _Post_writable_size_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Post_writable_size_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_writable_size__mixin); })) {
        mixin(_dpp_impl__Post_writable_size__mixin);
    }


    enum _dpp_impl__Post_readable_size__mixin = ` auto _Post_readable_size_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Post_readable_size_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_readable_size__mixin); })) {
        mixin(_dpp_impl__Post_readable_size__mixin);
    }


    enum _dpp_impl__Pre_writable_byte_size__mixin = ` auto _Pre_writable_byte_size_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Pre_writable_byte_size_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_writable_byte_size__mixin); })) {
        mixin(_dpp_impl__Pre_writable_byte_size__mixin);
    }


    enum _dpp_impl__Pre_readable_byte_size__mixin = ` auto _Pre_readable_byte_size_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Pre_readable_byte_size_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_readable_byte_size__mixin); })) {
        mixin(_dpp_impl__Pre_readable_byte_size__mixin);
    }


    enum _dpp_impl__Pre_writable_size__mixin = ` auto _Pre_writable_size_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Pre_writable_size_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_writable_size__mixin); })) {
        mixin(_dpp_impl__Pre_writable_size__mixin);
    }


    enum _dpp_impl__Pre_readable_size__mixin = ` auto _Pre_readable_size_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Pre_readable_size_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_readable_size__mixin); })) {
        mixin(_dpp_impl__Pre_readable_size__mixin);
    }




    static if(!is(typeof(_NullNull_terminated_))) {
        private enum enumMixinStr__NullNull_terminated_ = `enum _NullNull_terminated_ = _SAL2_Source_ ( _NullNull_terminated_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__NullNull_terminated_); }))) {
            mixin(enumMixinStr__NullNull_terminated_);
        }
    }




    static if(!is(typeof(_Null_terminated_))) {
        private enum enumMixinStr__Null_terminated_ = `enum _Null_terminated_ = _SAL2_Source_ ( _Null_terminated_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Null_terminated_); }))) {
            mixin(enumMixinStr__Null_terminated_);
        }
    }


    enum _dpp_impl__Writable_elements__mixin = ` auto _Writable_elements_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Writable_elements_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Writable_elements__mixin); })) {
        mixin(_dpp_impl__Writable_elements__mixin);
    }


    enum _dpp_impl__Writable_bytes__mixin = ` auto _Writable_bytes_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Writable_bytes_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Writable_bytes__mixin); })) {
        mixin(_dpp_impl__Writable_bytes__mixin);
    }


    enum _dpp_impl__Readable_elements__mixin = ` auto _Readable_elements_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Readable_elements_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Readable_elements__mixin); })) {
        mixin(_dpp_impl__Readable_elements__mixin);
    }


    enum _dpp_impl__Readable_bytes__mixin = ` auto _Readable_bytes_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Readable_bytes_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Readable_bytes__mixin); })) {
        mixin(_dpp_impl__Readable_bytes__mixin);
    }




    static if(!is(typeof(_Maybevalid_))) {
        private enum enumMixinStr__Maybevalid_ = `enum _Maybevalid_ = ;`;
        static if(is(typeof({ mixin(enumMixinStr__Maybevalid_); }))) {
            mixin(enumMixinStr__Maybevalid_);
        }
    }




    static if(!is(typeof(_Notvalid_))) {
        private enum enumMixinStr__Notvalid_ = `enum _Notvalid_ = ;`;
        static if(is(typeof({ mixin(enumMixinStr__Notvalid_); }))) {
            mixin(enumMixinStr__Notvalid_);
        }
    }




    static if(!is(typeof(_Valid_))) {
        private enum enumMixinStr__Valid_ = `enum _Valid_ = ;`;
        static if(is(typeof({ mixin(enumMixinStr__Valid_); }))) {
            mixin(enumMixinStr__Valid_);
        }
    }




    static if(!is(typeof(_Post_))) {
        private enum enumMixinStr__Post_ = `enum _Post_ = ;`;
        static if(is(typeof({ mixin(enumMixinStr__Post_); }))) {
            mixin(enumMixinStr__Post_);
        }
    }




    static if(!is(typeof(_Pre_))) {
        private enum enumMixinStr__Pre_ = `enum _Pre_ = ;`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_); }))) {
            mixin(enumMixinStr__Pre_);
        }
    }


    enum _dpp_impl__Field_range__mixin = ` auto _Field_range_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Field_range_ , ( arg0 , arg1 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_range__mixin); })) {
        mixin(_dpp_impl__Field_range__mixin);
    }




    static if(!is(typeof(_Field_z_))) {
        private enum enumMixinStr__Field_z_ = `enum _Field_z_ = _SAL2_Source_ ( _Field_z_ , ( ) , _SAL2_Source_ ( _Null_terminated_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Field_z_); }))) {
            mixin(enumMixinStr__Field_z_);
        }
    }


    enum _dpp_impl__Field_size_bytes_full_opt__mixin = ` auto _Field_size_bytes_full_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Field_size_bytes_full_opt_ , ( arg0 ) , _Field_size_bytes_part_opt_ ( arg0 , arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_size_bytes_full_opt__mixin); })) {
        mixin(_dpp_impl__Field_size_bytes_full_opt__mixin);
    }


    enum _dpp_impl__Field_size_bytes_full__mixin = ` auto _Field_size_bytes_full_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Field_size_bytes_full_ , ( arg0 ) , _Field_size_bytes_part_ ( arg0 , arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_size_bytes_full__mixin); })) {
        mixin(_dpp_impl__Field_size_bytes_full__mixin);
    }


    enum _dpp_impl__Field_size_bytes_part_opt__mixin = ` auto _Field_size_bytes_part_opt_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Field_size_bytes_part_opt_ , ( arg0 , arg1 ) , _SAL2_Source_ ( _Maybenull_ , ( ) , ) _SAL2_Source_ ( _Writable_bytes_ , ( arg0 ) , ) _SAL2_Source_ ( _Readable_bytes_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_size_bytes_part_opt__mixin); })) {
        mixin(_dpp_impl__Field_size_bytes_part_opt__mixin);
    }


    enum _dpp_impl__Field_size_bytes_part__mixin = ` auto _Field_size_bytes_part_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Field_size_bytes_part_ , ( arg0 , arg1 ) , _SAL2_Source_ ( _Notnull_ , ( ) , ) _SAL2_Source_ ( _Writable_bytes_ , ( arg0 ) , ) _SAL2_Source_ ( _Readable_bytes_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_size_bytes_part__mixin); })) {
        mixin(_dpp_impl__Field_size_bytes_part__mixin);
    }


    enum _dpp_impl__Field_size_bytes_opt__mixin = ` auto _Field_size_bytes_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Field_size_bytes_opt_ , ( arg0 ) , _SAL2_Source_ ( _Maybenull_ , ( ) , ) _SAL2_Source_ ( _Writable_bytes_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_size_bytes_opt__mixin); })) {
        mixin(_dpp_impl__Field_size_bytes_opt__mixin);
    }


    enum _dpp_impl__Field_size_bytes__mixin = ` auto _Field_size_bytes_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Field_size_bytes_ , ( arg0 ) , _SAL2_Source_ ( _Notnull_ , ( ) , ) _SAL2_Source_ ( _Writable_bytes_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_size_bytes__mixin); })) {
        mixin(_dpp_impl__Field_size_bytes__mixin);
    }


    enum _dpp_impl__Field_size_full_opt__mixin = ` auto _Field_size_full_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Field_size_full_opt_ , ( arg0 ) , _Field_size_part_opt_ ( arg0 , arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_size_full_opt__mixin); })) {
        mixin(_dpp_impl__Field_size_full_opt__mixin);
    }


    enum _dpp_impl__Field_size_full__mixin = ` auto _Field_size_full_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Field_size_full_ , ( arg0 ) , _Field_size_part_ ( arg0 , arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_size_full__mixin); })) {
        mixin(_dpp_impl__Field_size_full__mixin);
    }


    enum _dpp_impl__Field_size_part_opt__mixin = ` auto _Field_size_part_opt_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Field_size_part_opt_ , ( arg0 , arg1 ) , _SAL2_Source_ ( _Maybenull_ , ( ) , ) _SAL2_Source_ ( _Writable_elements_ , ( arg0 ) , ) _SAL2_Source_ ( _Readable_elements_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_size_part_opt__mixin); })) {
        mixin(_dpp_impl__Field_size_part_opt__mixin);
    }


    enum _dpp_impl__Field_size_part__mixin = ` auto _Field_size_part_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Field_size_part_ , ( arg0 , arg1 ) , _SAL2_Source_ ( _Notnull_ , ( ) , ) _SAL2_Source_ ( _Writable_elements_ , ( arg0 ) , ) _SAL2_Source_ ( _Readable_elements_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_size_part__mixin); })) {
        mixin(_dpp_impl__Field_size_part__mixin);
    }


    enum _dpp_impl__Field_size_opt__mixin = ` auto _Field_size_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Field_size_opt_ , ( arg0 ) , _SAL2_Source_ ( _Maybenull_ , ( ) , ) _SAL2_Source_ ( _Writable_elements_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_size_opt__mixin); })) {
        mixin(_dpp_impl__Field_size_opt__mixin);
    }


    enum _dpp_impl__Field_size__mixin = ` auto _Field_size_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Field_size_ , ( arg0 ) , _SAL2_Source_ ( _Notnull_ , ( ) , ) _SAL2_Source_ ( _Writable_elements_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Field_size__mixin); })) {
        mixin(_dpp_impl__Field_size__mixin);
    }


    enum _dpp_impl__Struct_size_bytes__mixin = ` auto _Struct_size_bytes_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Struct_size_bytes_ , ( arg0 ) , _SAL2_Source_ ( _Writable_bytes_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Struct_size_bytes__mixin); })) {
        mixin(_dpp_impl__Struct_size_bytes__mixin);
    }


    enum _dpp_impl__Post_satisfies__mixin = ` auto _Post_satisfies_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Post_satisfies_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_satisfies__mixin); })) {
        mixin(_dpp_impl__Post_satisfies__mixin);
    }


    enum _dpp_impl__Pre_satisfies__mixin = ` auto _Pre_satisfies_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Pre_satisfies_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_satisfies__mixin); })) {
        mixin(_dpp_impl__Pre_satisfies__mixin);
    }


    enum _dpp_impl__Unchanged__mixin = ` auto _Unchanged_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Unchanged_ , ( arg0 ) , _At_ ( arg0 , _Post_equal_to_ ( _Old_ ( arg0 ) ) _Const_ ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Unchanged__mixin); })) {
        mixin(_dpp_impl__Unchanged__mixin);
    }


    enum _dpp_impl__Post_equal_to__mixin = ` auto _Post_equal_to_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Post_equal_to_ , ( arg0 ) , _Out_range_ ( == , arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_equal_to__mixin); })) {
        mixin(_dpp_impl__Post_equal_to__mixin);
    }


    enum _dpp_impl__Pre_equal_to__mixin = ` auto _Pre_equal_to_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Pre_equal_to_ , ( arg0 ) , _In_range_ ( == , arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Pre_equal_to__mixin); })) {
        mixin(_dpp_impl__Pre_equal_to__mixin);
    }


    enum _dpp_impl__Deref_ret_range__mixin = ` auto _Deref_ret_range_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Deref_ret_range_ , ( arg0 , arg1 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_ret_range__mixin); })) {
        mixin(_dpp_impl__Deref_ret_range__mixin);
    }


    enum _dpp_impl__Deref_out_range__mixin = ` auto _Deref_out_range_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Deref_out_range_ , ( arg0 , arg1 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_out_range__mixin); })) {
        mixin(_dpp_impl__Deref_out_range__mixin);
    }


    enum _dpp_impl__Deref_in_range__mixin = ` auto _Deref_in_range_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Deref_in_range_ , ( arg0 , arg1 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Deref_in_range__mixin); })) {
        mixin(_dpp_impl__Deref_in_range__mixin);
    }


    enum _dpp_impl__Ret_range__mixin = ` auto _Ret_range_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Ret_range_ , ( arg0 , arg1 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_range__mixin); })) {
        mixin(_dpp_impl__Ret_range__mixin);
    }


    enum _dpp_impl__Out_range__mixin = ` auto _Out_range_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Out_range_ , ( arg0 , arg1 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_range__mixin); })) {
        mixin(_dpp_impl__Out_range__mixin);
    }


    enum _dpp_impl__In_range__mixin = ` auto _In_range_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _In_range_ , ( arg0 , arg1 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_range__mixin); })) {
        mixin(_dpp_impl__In_range__mixin);
    }


    enum _dpp_impl__Scanf_s_format_string_params__mixin = ` auto _Scanf_s_format_string_params_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Scanf_s_format_string_params_ , ( arg0 ) , _Format_string_impl_ ( "scanf_s" , arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Scanf_s_format_string_params__mixin); })) {
        mixin(_dpp_impl__Scanf_s_format_string_params__mixin);
    }


    enum _dpp_impl__Scanf_format_string_params__mixin = ` auto _Scanf_format_string_params_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Scanf_format_string_params_ , ( arg0 ) , _Format_string_impl_ ( "scanf" , arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Scanf_format_string_params__mixin); })) {
        mixin(_dpp_impl__Scanf_format_string_params__mixin);
    }


    enum _dpp_impl__Printf_format_string_params__mixin = ` auto _Printf_format_string_params_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Printf_format_string_params_ , ( arg0 ) , _Format_string_impl_ ( "printf" , arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Printf_format_string_params__mixin); })) {
        mixin(_dpp_impl__Printf_format_string_params__mixin);
    }


    enum _dpp_impl__Format_string_impl__mixin = ` auto _Format_string_impl_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Format_string_impl__mixin); })) {
        mixin(_dpp_impl__Format_string_impl__mixin);
    }




    static if(!is(typeof(_Scanf_s_format_string_))) {
        private enum enumMixinStr__Scanf_s_format_string_ = `enum _Scanf_s_format_string_ = _SAL2_Source_ ( _Scanf_s_format_string_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Scanf_s_format_string_); }))) {
            mixin(enumMixinStr__Scanf_s_format_string_);
        }
    }




    static if(!is(typeof(_Scanf_format_string_))) {
        private enum enumMixinStr__Scanf_format_string_ = `enum _Scanf_format_string_ = _SAL2_Source_ ( _Scanf_format_string_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Scanf_format_string_); }))) {
            mixin(enumMixinStr__Scanf_format_string_);
        }
    }




    static if(!is(typeof(_Printf_format_string_))) {
        private enum enumMixinStr__Printf_format_string_ = `enum _Printf_format_string_ = _SAL2_Source_ ( _Printf_format_string_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Printf_format_string_); }))) {
            mixin(enumMixinStr__Printf_format_string_);
        }
    }




    static if(!is(typeof(_Must_inspect_result_))) {
        private enum enumMixinStr__Must_inspect_result_ = `enum _Must_inspect_result_ = _SAL2_Source_ ( _Must_inspect_result_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Must_inspect_result_); }))) {
            mixin(enumMixinStr__Must_inspect_result_);
        }
    }




    static if(!is(typeof(_Check_return_))) {
        private enum enumMixinStr__Check_return_ = `enum _Check_return_ = _SAL2_Source_ ( _Check_return_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Check_return_); }))) {
            mixin(enumMixinStr__Check_return_);
        }
    }




    static if(!is(typeof(_Notliteral_))) {
        private enum enumMixinStr__Notliteral_ = `enum _Notliteral_ = _SAL2_Source_ ( _Notliteral_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Notliteral_); }))) {
            mixin(enumMixinStr__Notliteral_);
        }
    }




    static if(!is(typeof(_Literal_))) {
        private enum enumMixinStr__Literal_ = `enum _Literal_ = _SAL2_Source_ ( _Literal_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Literal_); }))) {
            mixin(enumMixinStr__Literal_);
        }
    }




    static if(!is(typeof(_Points_to_data_))) {
        private enum enumMixinStr__Points_to_data_ = `enum _Points_to_data_ = _SAL2_Source_ ( _Points_to_data_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Points_to_data_); }))) {
            mixin(enumMixinStr__Points_to_data_);
        }
    }


    enum _dpp_impl__Ret_writes_bytes_to_maybenull__mixin = ` auto _Ret_writes_bytes_to_maybenull_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Ret_writes_bytes_to_maybenull_ , ( arg0 , arg1 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_writes_bytes_to_maybenull__mixin); })) {
        mixin(_dpp_impl__Ret_writes_bytes_to_maybenull__mixin);
    }


    enum _dpp_impl__Ret_writes_to_maybenull__mixin = ` auto _Ret_writes_to_maybenull_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Ret_writes_to_maybenull_ , ( arg0 , arg1 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_writes_to_maybenull__mixin); })) {
        mixin(_dpp_impl__Ret_writes_to_maybenull__mixin);
    }


    enum _dpp_impl__Ret_writes_bytes_to__mixin = ` auto _Ret_writes_bytes_to_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Ret_writes_bytes_to_ , ( arg0 , arg1 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_writes_bytes_to__mixin); })) {
        mixin(_dpp_impl__Ret_writes_bytes_to__mixin);
    }


    enum _dpp_impl__Ret_writes_to__mixin = ` auto _Ret_writes_to_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Ret_writes_to_ , ( arg0 , arg1 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_writes_to__mixin); })) {
        mixin(_dpp_impl__Ret_writes_to__mixin);
    }


    enum _dpp_impl__Ret_writes_bytes_maybenull__mixin = ` auto _Ret_writes_bytes_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Ret_writes_bytes_maybenull_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_writes_bytes_maybenull__mixin); })) {
        mixin(_dpp_impl__Ret_writes_bytes_maybenull__mixin);
    }


    enum _dpp_impl__Ret_writes_maybenull_z__mixin = ` auto _Ret_writes_maybenull_z_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Ret_writes_maybenull_z_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_writes_maybenull_z__mixin); })) {
        mixin(_dpp_impl__Ret_writes_maybenull_z__mixin);
    }


    enum _dpp_impl__Ret_writes_maybenull__mixin = ` auto _Ret_writes_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Ret_writes_maybenull_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_writes_maybenull__mixin); })) {
        mixin(_dpp_impl__Ret_writes_maybenull__mixin);
    }


    enum _dpp_impl__Ret_writes_bytes__mixin = ` auto _Ret_writes_bytes_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Ret_writes_bytes_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_writes_bytes__mixin); })) {
        mixin(_dpp_impl__Ret_writes_bytes__mixin);
    }


    enum _dpp_impl__Ret_writes_z__mixin = ` auto _Ret_writes_z_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Ret_writes_z_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_writes_z__mixin); })) {
        mixin(_dpp_impl__Ret_writes_z__mixin);
    }


    enum _dpp_impl__Ret_writes__mixin = ` auto _Ret_writes_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Ret_writes_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Ret_writes__mixin); })) {
        mixin(_dpp_impl__Ret_writes__mixin);
    }




    static if(!is(typeof(_Ret_valid_))) {
        private enum enumMixinStr__Ret_valid_ = `enum _Ret_valid_ = _SAL2_Source_ ( _Ret_valid_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Ret_valid_); }))) {
            mixin(enumMixinStr__Ret_valid_);
        }
    }




    static if(!is(typeof(_Ret_null_))) {
        private enum enumMixinStr__Ret_null_ = `enum _Ret_null_ = _SAL2_Source_ ( _Ret_null_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Ret_null_); }))) {
            mixin(enumMixinStr__Ret_null_);
        }
    }




    static if(!is(typeof(_Ret_maybenull_))) {
        private enum enumMixinStr__Ret_maybenull_ = `enum _Ret_maybenull_ = _SAL2_Source_ ( _Ret_maybenull_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Ret_maybenull_); }))) {
            mixin(enumMixinStr__Ret_maybenull_);
        }
    }




    static if(!is(typeof(_Ret_notnull_))) {
        private enum enumMixinStr__Ret_notnull_ = `enum _Ret_notnull_ = _SAL2_Source_ ( _Ret_notnull_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Ret_notnull_); }))) {
            mixin(enumMixinStr__Ret_notnull_);
        }
    }




    static if(!is(typeof(_Ret_maybenull_z_))) {
        private enum enumMixinStr__Ret_maybenull_z_ = `enum _Ret_maybenull_z_ = _SAL2_Source_ ( _Ret_maybenull_z_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Ret_maybenull_z_); }))) {
            mixin(enumMixinStr__Ret_maybenull_z_);
        }
    }




    static if(!is(typeof(_Ret_z_))) {
        private enum enumMixinStr__Ret_z_ = `enum _Ret_z_ = _SAL2_Source_ ( _Ret_z_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Ret_z_); }))) {
            mixin(enumMixinStr__Ret_z_);
        }
    }




    static if(!is(typeof(_Result_zeroonfailure_))) {
        private enum enumMixinStr__Result_zeroonfailure_ = `enum _Result_zeroonfailure_ = _SAL2_Source_ ( _Result_zeroonfailure_ , ( ) , _On_failure_ ( _Deref_impl_ _SAL2_Source_ ( _Out_range_ , ( == , 0 ) , ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Result_zeroonfailure_); }))) {
            mixin(enumMixinStr__Result_zeroonfailure_);
        }
    }




    static if(!is(typeof(_Result_nullonfailure_))) {
        private enum enumMixinStr__Result_nullonfailure_ = `enum _Result_nullonfailure_ = _SAL2_Source_ ( _Result_nullonfailure_ , ( ) , _On_failure_ ( _Deref_impl_ _SAL2_Source_ ( _Post_null_ , ( ) , ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Result_nullonfailure_); }))) {
            mixin(enumMixinStr__Result_nullonfailure_);
        }
    }




    static if(!is(typeof(_Outref_result_nullonfailure_))) {
        private enum enumMixinStr__Outref_result_nullonfailure_ = `enum _Outref_result_nullonfailure_ = _SAL2_Source_ ( _Outref_result_nullonfailure_ , ( ) , _Outref_ _On_failure_ ( _SAL2_Source_ ( _Post_null_ , ( ) , ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Outref_result_nullonfailure_); }))) {
            mixin(enumMixinStr__Outref_result_nullonfailure_);
        }
    }


    enum _dpp_impl__Outref_result_bytebuffer_all_maybenull__mixin = ` auto _Outref_result_bytebuffer_all_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outref_result_bytebuffer_all_maybenull_ , ( arg0 ) , _Outref_result_bytebuffer_to_maybenull_ ( arg0 , _Old_ ( arg0 ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outref_result_bytebuffer_all_maybenull__mixin); })) {
        mixin(_dpp_impl__Outref_result_bytebuffer_all_maybenull__mixin);
    }


    enum _dpp_impl__Outref_result_buffer_all_maybenull__mixin = ` auto _Outref_result_buffer_all_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outref_result_buffer_all_maybenull_ , ( arg0 ) , _Outref_result_buffer_to_maybenull_ ( arg0 , _Old_ ( arg0 ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outref_result_buffer_all_maybenull__mixin); })) {
        mixin(_dpp_impl__Outref_result_buffer_all_maybenull__mixin);
    }


    enum _dpp_impl__Outref_result_bytebuffer_to_maybenull__mixin = ` auto _Outref_result_bytebuffer_to_maybenull_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Outref_result_bytebuffer_to_maybenull_ , ( arg0 , arg1 ) , _Outref_result_bytebuffer_maybenull_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outref_result_bytebuffer_to_maybenull__mixin); })) {
        mixin(_dpp_impl__Outref_result_bytebuffer_to_maybenull__mixin);
    }


    enum _dpp_impl__Outref_result_buffer_to_maybenull__mixin = ` auto _Outref_result_buffer_to_maybenull_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Outref_result_buffer_to_maybenull_ , ( arg0 , arg1 ) , _Outref_result_buffer_maybenull_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outref_result_buffer_to_maybenull__mixin); })) {
        mixin(_dpp_impl__Outref_result_buffer_to_maybenull__mixin);
    }


    enum _dpp_impl__Outref_result_bytebuffer_maybenull__mixin = ` auto _Outref_result_bytebuffer_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outref_result_bytebuffer_maybenull_ , ( arg0 ) , _Outref_result_maybenull_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outref_result_bytebuffer_maybenull__mixin); })) {
        mixin(_dpp_impl__Outref_result_bytebuffer_maybenull__mixin);
    }


    enum _dpp_impl__Outref_result_buffer_maybenull__mixin = ` auto _Outref_result_buffer_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outref_result_buffer_maybenull_ , ( arg0 ) , _Outref_result_maybenull_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outref_result_buffer_maybenull__mixin); })) {
        mixin(_dpp_impl__Outref_result_buffer_maybenull__mixin);
    }


    enum _dpp_impl__Outref_result_bytebuffer_all__mixin = ` auto _Outref_result_bytebuffer_all_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outref_result_bytebuffer_all_ , ( arg0 ) , _Outref_result_bytebuffer_to_ ( arg0 , _Old_ ( arg0 ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outref_result_bytebuffer_all__mixin); })) {
        mixin(_dpp_impl__Outref_result_bytebuffer_all__mixin);
    }


    enum _dpp_impl__Outref_result_buffer_all__mixin = ` auto _Outref_result_buffer_all_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outref_result_buffer_all_ , ( arg0 ) , _Outref_result_buffer_to_ ( arg0 , _Old_ ( arg0 ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outref_result_buffer_all__mixin); })) {
        mixin(_dpp_impl__Outref_result_buffer_all__mixin);
    }


    enum _dpp_impl__Outref_result_bytebuffer_to__mixin = ` auto _Outref_result_bytebuffer_to_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Outref_result_bytebuffer_to_ , ( arg0 , arg1 ) , _Outref_result_bytebuffer_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outref_result_bytebuffer_to__mixin); })) {
        mixin(_dpp_impl__Outref_result_bytebuffer_to__mixin);
    }


    enum _dpp_impl__Outref_result_buffer_to__mixin = ` auto _Outref_result_buffer_to_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Outref_result_buffer_to_ , ( arg0 , arg1 ) , _Outref_result_buffer_ ( arg0 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outref_result_buffer_to__mixin); })) {
        mixin(_dpp_impl__Outref_result_buffer_to__mixin);
    }


    enum _dpp_impl__Outref_result_bytebuffer__mixin = ` auto _Outref_result_bytebuffer_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outref_result_bytebuffer_ , ( arg0 ) , _Outref_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outref_result_bytebuffer__mixin); })) {
        mixin(_dpp_impl__Outref_result_bytebuffer__mixin);
    }


    enum _dpp_impl__Outref_result_buffer__mixin = ` auto _Outref_result_buffer_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outref_result_buffer_ , ( arg0 ) , _Outref_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outref_result_buffer__mixin); })) {
        mixin(_dpp_impl__Outref_result_buffer__mixin);
    }




    static if(!is(typeof(_Outref_result_maybenull_))) {
        private enum enumMixinStr__Outref_result_maybenull_ = `enum _Outref_result_maybenull_ = _SAL2_Source_ ( _Outref_result_maybenull_ , ( ) , _SAL2_Source_ ( _Post_maybenull_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Outref_result_maybenull_); }))) {
            mixin(enumMixinStr__Outref_result_maybenull_);
        }
    }




    static if(!is(typeof(_Outref_))) {
        private enum enumMixinStr__Outref_ = `enum _Outref_ = _SAL2_Source_ ( _Outref_ , ( ) , _Out_impl_ _SAL2_Source_ ( _Post_notnull_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Outref_); }))) {
            mixin(enumMixinStr__Outref_);
        }
    }


    enum _dpp_impl__Outptr_opt_result_bytebuffer_all_maybenull__mixin = ` auto _Outptr_opt_result_bytebuffer_all_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_opt_result_bytebuffer_all_maybenull_ , ( arg0 ) , _Out_opt_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_opt_result_bytebuffer_all_maybenull__mixin); })) {
        mixin(_dpp_impl__Outptr_opt_result_bytebuffer_all_maybenull__mixin);
    }


    enum _dpp_impl__Outptr_result_bytebuffer_all_maybenull__mixin = ` auto _Outptr_result_bytebuffer_all_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_result_bytebuffer_all_maybenull_ , ( arg0 ) , _Out_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_result_bytebuffer_all_maybenull__mixin); })) {
        mixin(_dpp_impl__Outptr_result_bytebuffer_all_maybenull__mixin);
    }


    enum _dpp_impl__Outptr_opt_result_bytebuffer_to_maybenull__mixin = ` auto _Outptr_opt_result_bytebuffer_to_maybenull_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Outptr_opt_result_bytebuffer_to_maybenull_ , ( arg0 , arg1 ) , _Out_opt_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_opt_result_bytebuffer_to_maybenull__mixin); })) {
        mixin(_dpp_impl__Outptr_opt_result_bytebuffer_to_maybenull__mixin);
    }


    enum _dpp_impl__Outptr_result_bytebuffer_to_maybenull__mixin = ` auto _Outptr_result_bytebuffer_to_maybenull_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Outptr_result_bytebuffer_to_maybenull_ , ( arg0 , arg1 ) , _Out_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_result_bytebuffer_to_maybenull__mixin); })) {
        mixin(_dpp_impl__Outptr_result_bytebuffer_to_maybenull__mixin);
    }


    enum _dpp_impl__Outptr_opt_result_bytebuffer_maybenull__mixin = ` auto _Outptr_opt_result_bytebuffer_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_opt_result_bytebuffer_maybenull_ , ( arg0 ) , _Out_opt_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_opt_result_bytebuffer_maybenull__mixin); })) {
        mixin(_dpp_impl__Outptr_opt_result_bytebuffer_maybenull__mixin);
    }


    enum _dpp_impl__Outptr_result_bytebuffer_maybenull__mixin = ` auto _Outptr_result_bytebuffer_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_result_bytebuffer_maybenull_ , ( arg0 ) , _Out_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_result_bytebuffer_maybenull__mixin); })) {
        mixin(_dpp_impl__Outptr_result_bytebuffer_maybenull__mixin);
    }


    enum _dpp_impl__Outptr_opt_result_bytebuffer_all__mixin = ` auto _Outptr_opt_result_bytebuffer_all_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_opt_result_bytebuffer_all_ , ( arg0 ) , _Out_opt_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_opt_result_bytebuffer_all__mixin); })) {
        mixin(_dpp_impl__Outptr_opt_result_bytebuffer_all__mixin);
    }


    enum _dpp_impl__Outptr_result_bytebuffer_all__mixin = ` auto _Outptr_result_bytebuffer_all_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_result_bytebuffer_all_ , ( arg0 ) , _Out_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_result_bytebuffer_all__mixin); })) {
        mixin(_dpp_impl__Outptr_result_bytebuffer_all__mixin);
    }


    enum _dpp_impl__Outptr_opt_result_bytebuffer_to__mixin = ` auto _Outptr_opt_result_bytebuffer_to_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Outptr_opt_result_bytebuffer_to_ , ( arg0 , arg1 ) , _Out_opt_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_opt_result_bytebuffer_to__mixin); })) {
        mixin(_dpp_impl__Outptr_opt_result_bytebuffer_to__mixin);
    }


    enum _dpp_impl__Outptr_result_bytebuffer_to__mixin = ` auto _Outptr_result_bytebuffer_to_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Outptr_result_bytebuffer_to_ , ( arg0 , arg1 ) , _Out_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_result_bytebuffer_to__mixin); })) {
        mixin(_dpp_impl__Outptr_result_bytebuffer_to__mixin);
    }


    enum _dpp_impl__Outptr_opt_result_bytebuffer__mixin = ` auto _Outptr_opt_result_bytebuffer_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_opt_result_bytebuffer_ , ( arg0 ) , _Out_opt_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_opt_result_bytebuffer__mixin); })) {
        mixin(_dpp_impl__Outptr_opt_result_bytebuffer__mixin);
    }


    enum _dpp_impl__Outptr_result_bytebuffer__mixin = ` auto _Outptr_result_bytebuffer_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_result_bytebuffer_ , ( arg0 ) , _Out_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_result_bytebuffer__mixin); })) {
        mixin(_dpp_impl__Outptr_result_bytebuffer__mixin);
    }


    enum _dpp_impl__Outptr_opt_result_buffer_all_maybenull__mixin = ` auto _Outptr_opt_result_buffer_all_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_opt_result_buffer_all_maybenull_ , ( arg0 ) , _Out_opt_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_opt_result_buffer_all_maybenull__mixin); })) {
        mixin(_dpp_impl__Outptr_opt_result_buffer_all_maybenull__mixin);
    }


    enum _dpp_impl__Outptr_result_buffer_all_maybenull__mixin = ` auto _Outptr_result_buffer_all_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_result_buffer_all_maybenull_ , ( arg0 ) , _Out_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_result_buffer_all_maybenull__mixin); })) {
        mixin(_dpp_impl__Outptr_result_buffer_all_maybenull__mixin);
    }


    enum _dpp_impl__Outptr_opt_result_buffer_to_maybenull__mixin = ` auto _Outptr_opt_result_buffer_to_maybenull_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Outptr_opt_result_buffer_to_maybenull_ , ( arg0 , arg1 ) , _Out_opt_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_opt_result_buffer_to_maybenull__mixin); })) {
        mixin(_dpp_impl__Outptr_opt_result_buffer_to_maybenull__mixin);
    }


    enum _dpp_impl__Outptr_result_buffer_to_maybenull__mixin = ` auto _Outptr_result_buffer_to_maybenull_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Outptr_result_buffer_to_maybenull_ , ( arg0 , arg1 ) , _Out_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_result_buffer_to_maybenull__mixin); })) {
        mixin(_dpp_impl__Outptr_result_buffer_to_maybenull__mixin);
    }


    enum _dpp_impl__Outptr_opt_result_buffer_maybenull__mixin = ` auto _Outptr_opt_result_buffer_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_opt_result_buffer_maybenull_ , ( arg0 ) , _Out_opt_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_opt_result_buffer_maybenull__mixin); })) {
        mixin(_dpp_impl__Outptr_opt_result_buffer_maybenull__mixin);
    }


    enum _dpp_impl__Outptr_result_buffer_maybenull__mixin = ` auto _Outptr_result_buffer_maybenull_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_result_buffer_maybenull_ , ( arg0 ) , _Out_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_result_buffer_maybenull__mixin); })) {
        mixin(_dpp_impl__Outptr_result_buffer_maybenull__mixin);
    }


    enum _dpp_impl__Outptr_opt_result_buffer_all__mixin = ` auto _Outptr_opt_result_buffer_all_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_opt_result_buffer_all_ , ( arg0 ) , _Out_opt_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_opt_result_buffer_all__mixin); })) {
        mixin(_dpp_impl__Outptr_opt_result_buffer_all__mixin);
    }


    enum _dpp_impl__Outptr_result_buffer_all__mixin = ` auto _Outptr_result_buffer_all_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_result_buffer_all_ , ( arg0 ) , _Out_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_result_buffer_all__mixin); })) {
        mixin(_dpp_impl__Outptr_result_buffer_all__mixin);
    }


    enum _dpp_impl__Outptr_opt_result_buffer_to__mixin = ` auto _Outptr_opt_result_buffer_to_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Outptr_opt_result_buffer_to_ , ( arg0 , arg1 ) , _Out_opt_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_opt_result_buffer_to__mixin); })) {
        mixin(_dpp_impl__Outptr_opt_result_buffer_to__mixin);
    }


    enum _dpp_impl__Outptr_result_buffer_to__mixin = ` auto _Outptr_result_buffer_to_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Outptr_result_buffer_to_ , ( arg0 , arg1 ) , _Out_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_result_buffer_to__mixin); })) {
        mixin(_dpp_impl__Outptr_result_buffer_to__mixin);
    }


    enum _dpp_impl__Outptr_opt_result_buffer__mixin = ` auto _Outptr_opt_result_buffer_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_opt_result_buffer_ , ( arg0 ) , _Out_opt_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_opt_result_buffer__mixin); })) {
        mixin(_dpp_impl__Outptr_opt_result_buffer__mixin);
    }


    enum _dpp_impl__Outptr_result_buffer__mixin = ` auto _Outptr_result_buffer_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Outptr_result_buffer_ , ( arg0 ) , _Out_impl_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Outptr_result_buffer__mixin); })) {
        mixin(_dpp_impl__Outptr_result_buffer__mixin);
    }




    static if(!is(typeof(_COM_Outptr_opt_result_maybenull_))) {
        private enum enumMixinStr__COM_Outptr_opt_result_maybenull_ = `enum _COM_Outptr_opt_result_maybenull_ = _SAL2_Source_ ( _COM_Outptr_opt_result_maybenull_ , ( ) , _Outptr_opt_result_maybenull_ _On_failure_ ( _SAL1_1_Source_ ( _Deref_post_null_ , ( ) , ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr__COM_Outptr_opt_result_maybenull_); }))) {
            mixin(enumMixinStr__COM_Outptr_opt_result_maybenull_);
        }
    }




    static if(!is(typeof(_COM_Outptr_opt_))) {
        private enum enumMixinStr__COM_Outptr_opt_ = `enum _COM_Outptr_opt_ = _SAL2_Source_ ( _COM_Outptr_opt_ , ( ) , _Outptr_opt_ _On_failure_ ( _SAL1_1_Source_ ( _Deref_post_null_ , ( ) , ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr__COM_Outptr_opt_); }))) {
            mixin(enumMixinStr__COM_Outptr_opt_);
        }
    }




    static if(!is(typeof(_COM_Outptr_result_maybenull_))) {
        private enum enumMixinStr__COM_Outptr_result_maybenull_ = `enum _COM_Outptr_result_maybenull_ = _SAL2_Source_ ( _COM_Outptr_result_maybenull_ , ( ) , _Outptr_result_maybenull_ _On_failure_ ( _SAL1_1_Source_ ( _Deref_post_null_ , ( ) , ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr__COM_Outptr_result_maybenull_); }))) {
            mixin(enumMixinStr__COM_Outptr_result_maybenull_);
        }
    }




    static if(!is(typeof(_COM_Outptr_))) {
        private enum enumMixinStr__COM_Outptr_ = `enum _COM_Outptr_ = _SAL2_Source_ ( _COM_Outptr_ , ( ) , _Outptr_ _On_failure_ ( _SAL1_1_Source_ ( _Deref_post_null_ , ( ) , ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr__COM_Outptr_); }))) {
            mixin(enumMixinStr__COM_Outptr_);
        }
    }




    static if(!is(typeof(_Outptr_opt_result_nullonfailure_))) {
        private enum enumMixinStr__Outptr_opt_result_nullonfailure_ = `enum _Outptr_opt_result_nullonfailure_ = _SAL2_Source_ ( _Outptr_opt_result_nullonfailure_ , ( ) , _Outptr_opt_ _On_failure_ ( _SAL1_1_Source_ ( _Deref_post_null_ , ( ) , ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Outptr_opt_result_nullonfailure_); }))) {
            mixin(enumMixinStr__Outptr_opt_result_nullonfailure_);
        }
    }




    static if(!is(typeof(_Outptr_result_nullonfailure_))) {
        private enum enumMixinStr__Outptr_result_nullonfailure_ = `enum _Outptr_result_nullonfailure_ = _SAL2_Source_ ( _Outptr_result_nullonfailure_ , ( ) , _Outptr_ _On_failure_ ( _SAL1_1_Source_ ( _Deref_post_null_ , ( ) , ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Outptr_result_nullonfailure_); }))) {
            mixin(enumMixinStr__Outptr_result_nullonfailure_);
        }
    }




    static if(!is(typeof(_Outptr_opt_result_maybenull_z_))) {
        private enum enumMixinStr__Outptr_opt_result_maybenull_z_ = `enum _Outptr_opt_result_maybenull_z_ = _SAL2_Source_ ( _Outptr_opt_result_maybenull_z_ , ( ) , _Out_opt_impl_ _SAL1_1_Source_ ( _Deref_post_opt_z_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Outptr_opt_result_maybenull_z_); }))) {
            mixin(enumMixinStr__Outptr_opt_result_maybenull_z_);
        }
    }




    static if(!is(typeof(_Outptr_result_maybenull_z_))) {
        private enum enumMixinStr__Outptr_result_maybenull_z_ = `enum _Outptr_result_maybenull_z_ = _SAL2_Source_ ( _Outptr_result_maybenull_z_ , ( ) , _Out_impl_ _SAL1_1_Source_ ( _Deref_post_opt_z_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Outptr_result_maybenull_z_); }))) {
            mixin(enumMixinStr__Outptr_result_maybenull_z_);
        }
    }




    static if(!is(typeof(_Outptr_opt_result_z_))) {
        private enum enumMixinStr__Outptr_opt_result_z_ = `enum _Outptr_opt_result_z_ = _SAL2_Source_ ( _Outptr_opt_result_z_ , ( ) , _Out_opt_impl_ _SAL1_1_Source_ ( _Deref_post_z_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Outptr_opt_result_z_); }))) {
            mixin(enumMixinStr__Outptr_opt_result_z_);
        }
    }




    static if(!is(typeof(_Outptr_result_z_))) {
        private enum enumMixinStr__Outptr_result_z_ = `enum _Outptr_result_z_ = _SAL2_Source_ ( _Outptr_result_z_ , ( ) , _Out_impl_ _SAL1_1_Source_ ( _Deref_post_z_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Outptr_result_z_); }))) {
            mixin(enumMixinStr__Outptr_result_z_);
        }
    }




    static if(!is(typeof(_Outptr_opt_result_maybenull_))) {
        private enum enumMixinStr__Outptr_opt_result_maybenull_ = `enum _Outptr_opt_result_maybenull_ = _SAL2_Source_ ( _Outptr_opt_result_maybenull_ , ( ) , _Out_opt_impl_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Outptr_opt_result_maybenull_); }))) {
            mixin(enumMixinStr__Outptr_opt_result_maybenull_);
        }
    }




    static if(!is(typeof(_Outptr_opt_))) {
        private enum enumMixinStr__Outptr_opt_ = `enum _Outptr_opt_ = _SAL2_Source_ ( _Outptr_opt_ , ( ) , _Out_opt_impl_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Outptr_opt_); }))) {
            mixin(enumMixinStr__Outptr_opt_);
        }
    }




    static if(!is(typeof(_Outptr_result_maybenull_))) {
        private enum enumMixinStr__Outptr_result_maybenull_ = `enum _Outptr_result_maybenull_ = _SAL2_Source_ ( _Outptr_result_maybenull_ , ( ) , _Out_impl_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Outptr_result_maybenull_); }))) {
            mixin(enumMixinStr__Outptr_result_maybenull_);
        }
    }




    static if(!is(typeof(_Outptr_))) {
        private enum enumMixinStr__Outptr_ = `enum _Outptr_ = _SAL2_Source_ ( _Outptr_ , ( ) , _Out_impl_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Outptr_); }))) {
            mixin(enumMixinStr__Outptr_);
        }
    }


    enum _dpp_impl__Inout_updates_bytes_all_opt__mixin = ` auto _Inout_updates_bytes_all_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Inout_updates_bytes_all_opt_ , ( arg0 ) , _Inout_updates_bytes_to_opt_ ( _Old_ ( arg0 ) , _Old_ ( arg0 ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates_bytes_all_opt__mixin); })) {
        mixin(_dpp_impl__Inout_updates_bytes_all_opt__mixin);
    }


    enum _dpp_impl__Inout_updates_bytes_all__mixin = ` auto _Inout_updates_bytes_all_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Inout_updates_bytes_all_ , ( arg0 ) , _Inout_updates_bytes_to_ ( _Old_ ( arg0 ) , _Old_ ( arg0 ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates_bytes_all__mixin); })) {
        mixin(_dpp_impl__Inout_updates_bytes_all__mixin);
    }


    enum _dpp_impl__Inout_updates_bytes_to_opt__mixin = ` auto _Inout_updates_bytes_to_opt_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Inout_updates_bytes_to_opt_ , ( arg0 , arg1 ) , _Out_writes_bytes_to_opt_ ( arg0 , arg1 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates_bytes_to_opt__mixin); })) {
        mixin(_dpp_impl__Inout_updates_bytes_to_opt__mixin);
    }


    enum _dpp_impl__Inout_updates_bytes_to__mixin = ` auto _Inout_updates_bytes_to_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Inout_updates_bytes_to_ , ( arg0 , arg1 ) , _Out_writes_bytes_to_ ( arg0 , arg1 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates_bytes_to__mixin); })) {
        mixin(_dpp_impl__Inout_updates_bytes_to__mixin);
    }


    enum _dpp_impl__Inout_updates_bytes_opt__mixin = ` auto _Inout_updates_bytes_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Inout_updates_bytes_opt_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates_bytes_opt__mixin); })) {
        mixin(_dpp_impl__Inout_updates_bytes_opt__mixin);
    }


    enum _dpp_impl__Inout_updates_bytes__mixin = ` auto _Inout_updates_bytes_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Inout_updates_bytes_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates_bytes__mixin); })) {
        mixin(_dpp_impl__Inout_updates_bytes__mixin);
    }


    enum _dpp_impl__Inout_updates_all_opt__mixin = ` auto _Inout_updates_all_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Inout_updates_all_opt_ , ( arg0 ) , _Inout_updates_to_opt_ ( _Old_ ( arg0 ) , _Old_ ( arg0 ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates_all_opt__mixin); })) {
        mixin(_dpp_impl__Inout_updates_all_opt__mixin);
    }


    enum _dpp_impl__Inout_updates_all__mixin = ` auto _Inout_updates_all_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Inout_updates_all_ , ( arg0 ) , _Inout_updates_to_ ( _Old_ ( arg0 ) , _Old_ ( arg0 ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates_all__mixin); })) {
        mixin(_dpp_impl__Inout_updates_all__mixin);
    }


    enum _dpp_impl__Inout_updates_to_opt__mixin = ` auto _Inout_updates_to_opt_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Inout_updates_to_opt_ , ( arg0 , arg1 ) , _Out_writes_to_opt_ ( arg0 , arg1 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates_to_opt__mixin); })) {
        mixin(_dpp_impl__Inout_updates_to_opt__mixin);
    }


    enum _dpp_impl__Inout_updates_to__mixin = ` auto _Inout_updates_to_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Inout_updates_to_ , ( arg0 , arg1 ) , _Out_writes_to_ ( arg0 , arg1 ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates_to__mixin); })) {
        mixin(_dpp_impl__Inout_updates_to__mixin);
    }


    enum _dpp_impl__Inout_updates_opt_z__mixin = ` auto _Inout_updates_opt_z_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Inout_updates_opt_z_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_cap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates_opt_z__mixin); })) {
        mixin(_dpp_impl__Inout_updates_opt_z__mixin);
    }


    enum _dpp_impl__Inout_updates_z__mixin = ` auto _Inout_updates_z_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Inout_updates_z_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_cap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates_z__mixin); })) {
        mixin(_dpp_impl__Inout_updates_z__mixin);
    }


    enum _dpp_impl__Inout_updates_opt__mixin = ` auto _Inout_updates_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Inout_updates_opt_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_cap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates_opt__mixin); })) {
        mixin(_dpp_impl__Inout_updates_opt__mixin);
    }


    enum _dpp_impl__Inout_updates__mixin = ` auto _Inout_updates_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Inout_updates_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_cap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_updates__mixin); })) {
        mixin(_dpp_impl__Inout_updates__mixin);
    }




    static if(!is(typeof(_Inout_opt_z_))) {
        private enum enumMixinStr__Inout_opt_z_ = `enum _Inout_opt_z_ = _SAL2_Source_ ( _Inout_opt_z_ , ( ) , _SAL1_1_Source_ ( _Prepost_opt_z_ , ( ) , _SAL1_1_Source_ ( _Pre_opt_z_ , ( ) , ) _SAL2_Source_ ( _Post_z_ , ( ) , ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Inout_opt_z_); }))) {
            mixin(enumMixinStr__Inout_opt_z_);
        }
    }




    static if(!is(typeof(_Inout_z_))) {
        private enum enumMixinStr__Inout_z_ = `enum _Inout_z_ = _SAL2_Source_ ( _Inout_z_ , ( ) , _SAL2_Source_ ( _Prepost_z_ , ( ) , _SAL2_Source_ ( _Pre_z_ , ( ) , ) _SAL2_Source_ ( _Post_z_ , ( ) , ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Inout_z_); }))) {
            mixin(enumMixinStr__Inout_z_);
        }
    }




    static if(!is(typeof(_Inout_opt_))) {
        private enum enumMixinStr__Inout_opt_ = `enum _Inout_opt_ = _SAL2_Source_ ( _Inout_opt_ , ( ) , _SAL1_1_Source_ ( _Prepost_opt_valid_ , ( ) , _SAL2_Source_ ( _Pre_opt_valid_ , ( ) , ) _SAL2_Source_ ( _Post_valid_ , ( ) , ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Inout_opt_); }))) {
            mixin(enumMixinStr__Inout_opt_);
        }
    }




    static if(!is(typeof(_Inout_))) {
        private enum enumMixinStr__Inout_ = `enum _Inout_ = _SAL2_Source_ ( _Inout_ , ( ) , _SAL1_1_Source_ ( _Prepost_valid_ , ( ) , _SAL2_Source_ ( _Pre_valid_ , ( ) , ) _SAL2_Source_ ( _Post_valid_ , ( ) , ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr__Inout_); }))) {
            mixin(enumMixinStr__Inout_);
        }
    }


    enum _dpp_impl__Out_writes_to_ptr_opt_z__mixin = ` auto _Out_writes_to_ptr_opt_z_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_to_ptr_opt_z_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_ptrdiff_cap_ , ( arg0 ) , ) Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_to_ptr_opt_z__mixin); })) {
        mixin(_dpp_impl__Out_writes_to_ptr_opt_z__mixin);
    }


    enum _dpp_impl__Out_writes_to_ptr_z__mixin = ` auto _Out_writes_to_ptr_z_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_to_ptr_z_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_ptrdiff_cap_ , ( arg0 ) , ) Post_z_ );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_to_ptr_z__mixin); })) {
        mixin(_dpp_impl__Out_writes_to_ptr_z__mixin);
    }


    enum _dpp_impl__Out_writes_to_ptr_opt__mixin = ` auto _Out_writes_to_ptr_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_to_ptr_opt_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_ptrdiff_cap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_to_ptr_opt__mixin); })) {
        mixin(_dpp_impl__Out_writes_to_ptr_opt__mixin);
    }


    enum _dpp_impl__Out_writes_to_ptr__mixin = ` auto _Out_writes_to_ptr_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_to_ptr_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_ptrdiff_cap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_to_ptr__mixin); })) {
        mixin(_dpp_impl__Out_writes_to_ptr__mixin);
    }


    enum _dpp_impl__Out_writes_bytes_all_opt__mixin = ` auto _Out_writes_bytes_all_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_bytes_all_opt_ , ( arg0 ) , _Out_writes_bytes_to_opt_ ( _Old_ ( arg0 ) , _Old_ ( arg0 ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_bytes_all_opt__mixin); })) {
        mixin(_dpp_impl__Out_writes_bytes_all_opt__mixin);
    }


    enum _dpp_impl__Out_writes_bytes_all__mixin = ` auto _Out_writes_bytes_all_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_bytes_all_ , ( arg0 ) , _Out_writes_bytes_to_ ( _Old_ ( arg0 ) , _Old_ ( arg0 ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_bytes_all__mixin); })) {
        mixin(_dpp_impl__Out_writes_bytes_all__mixin);
    }


    enum _dpp_impl__Out_writes_bytes_to_opt__mixin = ` auto _Out_writes_bytes_to_opt_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Out_writes_bytes_to_opt_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_bytes_to_opt__mixin); })) {
        mixin(_dpp_impl__Out_writes_bytes_to_opt__mixin);
    }


    enum _dpp_impl__Out_writes_bytes_to__mixin = ` auto _Out_writes_bytes_to_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Out_writes_bytes_to_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_bytecap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_bytecount_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_bytes_to__mixin); })) {
        mixin(_dpp_impl__Out_writes_bytes_to__mixin);
    }


    enum _dpp_impl__Out_writes_all_opt__mixin = ` auto _Out_writes_all_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_all_opt_ , ( arg0 ) , _Out_writes_to_opt_ ( _Old_ ( arg0 ) , _Old_ ( arg0 ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_all_opt__mixin); })) {
        mixin(_dpp_impl__Out_writes_all_opt__mixin);
    }


    enum _dpp_impl__Out_writes_all__mixin = ` auto _Out_writes_all_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_all_ , ( arg0 ) , _Out_writes_to_ ( _Old_ ( arg0 ) , _Old_ ( arg0 ) ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_all__mixin); })) {
        mixin(_dpp_impl__Out_writes_all__mixin);
    }


    enum _dpp_impl__Out_writes_to_opt__mixin = ` auto _Out_writes_to_opt_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Out_writes_to_opt_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_opt_cap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_to_opt__mixin); })) {
        mixin(_dpp_impl__Out_writes_to_opt__mixin);
    }


    enum _dpp_impl__Out_writes_to__mixin = ` auto _Out_writes_to_(A0, A1)(A0 arg0, A1 arg1) {
        return _SAL2_Source_ ( _Out_writes_to_ , ( arg0 , arg1 ) , _SAL1_1_Source_ ( _Pre_cap_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Post_count_ , ( arg1 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_to__mixin); })) {
        mixin(_dpp_impl__Out_writes_to__mixin);
    }


    enum _dpp_impl__Out_writes_opt_z__mixin = ` auto _Out_writes_opt_z_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_opt_z_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_cap_ , ( arg0 ) , ) _SAL2_Source_ ( _Post_z_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_opt_z__mixin); })) {
        mixin(_dpp_impl__Out_writes_opt_z__mixin);
    }


    enum _dpp_impl__Out_writes_z__mixin = ` auto _Out_writes_z_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_z_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_cap_ , ( arg0 ) , ) _SAL2_Source_ ( _Post_z_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_z__mixin); })) {
        mixin(_dpp_impl__Out_writes_z__mixin);
    }


    enum _dpp_impl__Out_writes_bytes_opt__mixin = ` auto _Out_writes_bytes_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_bytes_opt_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_bytes_opt__mixin); })) {
        mixin(_dpp_impl__Out_writes_bytes_opt__mixin);
    }


    enum _dpp_impl__Out_writes_bytes__mixin = ` auto _Out_writes_bytes_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_bytes_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_bytes__mixin); })) {
        mixin(_dpp_impl__Out_writes_bytes__mixin);
    }


    enum _dpp_impl__Out_writes_opt__mixin = ` auto _Out_writes_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_opt_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_cap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes_opt__mixin); })) {
        mixin(_dpp_impl__Out_writes_opt__mixin);
    }


    enum _dpp_impl__Out_writes__mixin = ` auto _Out_writes_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Out_writes_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_cap_ , ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_writes__mixin); })) {
        mixin(_dpp_impl__Out_writes__mixin);
    }




    static if(!is(typeof(_Out_opt_))) {
        private enum enumMixinStr__Out_opt_ = `enum _Out_opt_ = _SAL2_Source_ ( _Out_opt_ , ( ) , _Out_opt_impl_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Out_opt_); }))) {
            mixin(enumMixinStr__Out_opt_);
        }
    }




    static if(!is(typeof(_Out_))) {
        private enum enumMixinStr__Out_ = `enum _Out_ = _SAL2_Source_ ( _Out_ , ( ) , _Out_impl_ );`;
        static if(is(typeof({ mixin(enumMixinStr__Out_); }))) {
            mixin(enumMixinStr__Out_);
        }
    }


    enum _dpp_impl__In_reads_to_ptr_opt_z__mixin = ` auto _In_reads_to_ptr_opt_z_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _In_reads_to_ptr_opt_z_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_ptrdiff_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) _SAL1_1_Source_ ( _Pre_opt_z_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_reads_to_ptr_opt_z__mixin); })) {
        mixin(_dpp_impl__In_reads_to_ptr_opt_z__mixin);
    }


    enum _dpp_impl__In_reads_to_ptr_z__mixin = ` auto _In_reads_to_ptr_z_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _In_reads_to_ptr_z_ , ( arg0 ) , _In_reads_to_ptr_ ( arg0 ) _SAL2_Source_ ( _Pre_z_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_reads_to_ptr_z__mixin); })) {
        mixin(_dpp_impl__In_reads_to_ptr_z__mixin);
    }


    enum _dpp_impl__In_reads_to_ptr_opt__mixin = ` auto _In_reads_to_ptr_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _In_reads_to_ptr_opt_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_ptrdiff_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_reads_to_ptr_opt__mixin); })) {
        mixin(_dpp_impl__In_reads_to_ptr_opt__mixin);
    }


    enum _dpp_impl__In_reads_to_ptr__mixin = ` auto _In_reads_to_ptr_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _In_reads_to_ptr_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_ptrdiff_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_reads_to_ptr__mixin); })) {
        mixin(_dpp_impl__In_reads_to_ptr__mixin);
    }


    enum _dpp_impl__In_reads_or_z_opt__mixin = ` auto _In_reads_or_z_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _In_reads_or_z_opt_ , ( arg0 ) , _In_opt_ _When_ ( _String_length_ ( _Curr_ ) < ( arg0 ) , _SAL2_Source_ ( _Pre_z_ , ( ) , ) ) _When_ ( _String_length_ ( _Curr_ ) >= ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_reads_or_z_opt__mixin); })) {
        mixin(_dpp_impl__In_reads_or_z_opt__mixin);
    }


    enum _dpp_impl__In_reads_or_z__mixin = ` auto _In_reads_or_z_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _In_reads_or_z_ , ( arg0 ) , _In_ _When_ ( _String_length_ ( _Curr_ ) < ( arg0 ) , _SAL2_Source_ ( _Pre_z_ , ( ) , ) ) _When_ ( _String_length_ ( _Curr_ ) >= ( arg0 ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_reads_or_z__mixin); })) {
        mixin(_dpp_impl__In_reads_or_z__mixin);
    }


    enum _dpp_impl__In_reads_opt_z__mixin = ` auto _In_reads_opt_z_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _In_reads_opt_z_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) _SAL1_1_Source_ ( _Pre_opt_z_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_reads_opt_z__mixin); })) {
        mixin(_dpp_impl__In_reads_opt_z__mixin);
    }


    enum _dpp_impl__In_reads_z__mixin = ` auto _In_reads_z_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _In_reads_z_ , ( arg0 ) , _In_reads_ ( arg0 ) _SAL2_Source_ ( _Pre_z_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_reads_z__mixin); })) {
        mixin(_dpp_impl__In_reads_z__mixin);
    }


    enum _dpp_impl__In_reads_bytes_opt__mixin = ` auto _In_reads_bytes_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _In_reads_bytes_opt_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_bytecount_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_reads_bytes_opt__mixin); })) {
        mixin(_dpp_impl__In_reads_bytes_opt__mixin);
    }


    enum _dpp_impl__In_reads_bytes__mixin = ` auto _In_reads_bytes_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _In_reads_bytes_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_bytecount_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_reads_bytes__mixin); })) {
        mixin(_dpp_impl__In_reads_bytes__mixin);
    }


    enum _dpp_impl__In_reads_opt__mixin = ` auto _In_reads_opt_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _In_reads_opt_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_opt_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_reads_opt__mixin); })) {
        mixin(_dpp_impl__In_reads_opt__mixin);
    }


    enum _dpp_impl__In_reads__mixin = ` auto _In_reads_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _In_reads_ , ( arg0 ) , _SAL1_1_Source_ ( _Pre_count_ , ( arg0 ) , ) _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_reads__mixin); })) {
        mixin(_dpp_impl__In_reads__mixin);
    }




    static if(!is(typeof(_In_opt_z_))) {
        private enum enumMixinStr__In_opt_z_ = `enum _In_opt_z_ = _SAL2_Source_ ( _In_opt_z_ , ( ) , _In_opt_ );`;
        static if(is(typeof({ mixin(enumMixinStr__In_opt_z_); }))) {
            mixin(enumMixinStr__In_opt_z_);
        }
    }




    static if(!is(typeof(_In_z_))) {
        private enum enumMixinStr__In_z_ = `enum _In_z_ = _SAL2_Source_ ( _In_z_ , ( ) , _In_ );`;
        static if(is(typeof({ mixin(enumMixinStr__In_z_); }))) {
            mixin(enumMixinStr__In_z_);
        }
    }




    static if(!is(typeof(_In_opt_))) {
        private enum enumMixinStr__In_opt_ = `enum _In_opt_ = _SAL2_Source_ ( _In_opt_ , ( ) , _SAL1_1_Source_ ( _Deref_pre_readonly_ , ( ) , ) );`;
        static if(is(typeof({ mixin(enumMixinStr__In_opt_); }))) {
            mixin(enumMixinStr__In_opt_);
        }
    }




    static if(!is(typeof(_In_))) {
        private enum enumMixinStr__In_ = `enum _In_ = _SAL2_Source_ ( _In_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__In_); }))) {
            mixin(enumMixinStr__In_);
        }
    }




    static if(!is(typeof(_Const_))) {
        private enum enumMixinStr__Const_ = `enum _Const_ = _SAL2_Source_ ( _Const_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Const_); }))) {
            mixin(enumMixinStr__Const_);
        }
    }




    static if(!is(typeof(_Reserved_))) {
        private enum enumMixinStr__Reserved_ = `enum _Reserved_ = _SAL2_Source_ ( _Reserved_ , ( ) , );`;
        static if(is(typeof({ mixin(enumMixinStr__Reserved_); }))) {
            mixin(enumMixinStr__Reserved_);
        }
    }


    enum _dpp_impl__Inout_defensive__mixin = ` auto _Inout_defensive_(A0)(A0 arg0) {
        return _Pre_defensive_ _Post_defensive_ _Group_ ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Inout_defensive__mixin); })) {
        mixin(_dpp_impl__Inout_defensive__mixin);
    }


    enum _dpp_impl__Out_defensive__mixin = ` auto _Out_defensive_(A0)(A0 arg0) {
        return _Post_defensive_ _Group_ ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Out_defensive__mixin); })) {
        mixin(_dpp_impl__Out_defensive__mixin);
    }


    enum _dpp_impl__In_defensive__mixin = ` auto _In_defensive_(A0)(A0 arg0) {
        return _Pre_defensive_ _Group_ ( arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__In_defensive__mixin); })) {
        mixin(_dpp_impl__In_defensive__mixin);
    }




    static if(!is(typeof(_Post_defensive_))) {
        private enum enumMixinStr__Post_defensive_ = `enum _Post_defensive_ = ;`;
        static if(is(typeof({ mixin(enumMixinStr__Post_defensive_); }))) {
            mixin(enumMixinStr__Post_defensive_);
        }
    }




    static if(!is(typeof(_Pre_defensive_))) {
        private enum enumMixinStr__Pre_defensive_ = `enum _Pre_defensive_ = ;`;
        static if(is(typeof({ mixin(enumMixinStr__Pre_defensive_); }))) {
            mixin(enumMixinStr__Pre_defensive_);
        }
    }




    static if(!is(typeof(_Notref_))) {
        private enum enumMixinStr__Notref_ = `enum _Notref_ = ;`;
        static if(is(typeof({ mixin(enumMixinStr__Notref_); }))) {
            mixin(enumMixinStr__Notref_);
        }
    }




    static if(!is(typeof(_Use_decl_annotations_))) {
        private enum enumMixinStr__Use_decl_annotations_ = `enum _Use_decl_annotations_ = ;`;
        static if(is(typeof({ mixin(enumMixinStr__Use_decl_annotations_); }))) {
            mixin(enumMixinStr__Use_decl_annotations_);
        }
    }


    enum _dpp_impl__Always__mixin = ` auto _Always_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Always__mixin); })) {
        mixin(_dpp_impl__Always__mixin);
    }


    enum _dpp_impl__On_failure__mixin = ` auto _On_failure_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__On_failure__mixin); })) {
        mixin(_dpp_impl__On_failure__mixin);
    }


    enum _dpp_impl__Return_type_success__mixin = ` auto _Return_type_success_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Return_type_success_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Return_type_success__mixin); })) {
        mixin(_dpp_impl__Return_type_success__mixin);
    }


    enum _dpp_impl__Success__mixin = ` auto _Success_(A0)(A0 arg0) {
        return _SAL2_Source_ ( _Success_ , ( arg0 ) , );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Success__mixin); })) {
        mixin(_dpp_impl__Success__mixin);
    }


    enum _dpp_impl__GrouP__mixin = ` auto _GrouP_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__GrouP__mixin); })) {
        mixin(_dpp_impl__GrouP__mixin);
    }


    enum _dpp_impl__Group__mixin = ` auto _Group_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Group__mixin); })) {
        mixin(_dpp_impl__Group__mixin);
    }


    enum _dpp_impl__When__mixin = ` auto _When_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__When__mixin); })) {
        mixin(_dpp_impl__When__mixin);
    }


    enum _dpp_impl__At_buffer__mixin = ` auto _At_buffer_(A0, A1, A2, A3)(A0 arg0, A1 arg1, A2 arg2, A3 arg3) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__At_buffer__mixin); })) {
        mixin(_dpp_impl__At_buffer__mixin);
    }


    enum _dpp_impl__At__mixin = ` auto _At_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__At__mixin); })) {
        mixin(_dpp_impl__At__mixin);
    }


    enum _dpp_impl__SAL_L_Source__mixin = ` auto _SAL_L_Source_(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__SAL_L_Source__mixin); })) {
        mixin(_dpp_impl__SAL_L_Source__mixin);
    }


    enum _dpp_impl__SAL2_Source__mixin = ` auto _SAL2_Source_(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__SAL2_Source__mixin); })) {
        mixin(_dpp_impl__SAL2_Source__mixin);
    }


    enum _dpp_impl__SAL1_2_Source__mixin = ` auto _SAL1_2_Source_(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__SAL1_2_Source__mixin); })) {
        mixin(_dpp_impl__SAL1_2_Source__mixin);
    }


    enum _dpp_impl__SAL1_1_Source__mixin = ` auto _SAL1_1_Source_(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__SAL1_1_Source__mixin); })) {
        mixin(_dpp_impl__SAL1_1_Source__mixin);
    }


    enum _dpp_impl__SAL1_Source__mixin = ` auto _SAL1_Source_(A0, A1, A2)(A0 arg0, A1 arg1, A2 arg2) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__SAL1_Source__mixin); })) {
        mixin(_dpp_impl__SAL1_Source__mixin);
    }




    static if(!is(typeof(_USE_ATTRIBUTES_FOR_SAL))) {
        private enum enumMixinStr__USE_ATTRIBUTES_FOR_SAL = `enum _USE_ATTRIBUTES_FOR_SAL = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__USE_ATTRIBUTES_FOR_SAL); }))) {
            mixin(enumMixinStr__USE_ATTRIBUTES_FOR_SAL);
        }
    }




    static if(!is(typeof(_USE_DECLSPECS_FOR_SAL))) {
        private enum enumMixinStr__USE_DECLSPECS_FOR_SAL = `enum _USE_DECLSPECS_FOR_SAL = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__USE_DECLSPECS_FOR_SAL); }))) {
            mixin(enumMixinStr__USE_DECLSPECS_FOR_SAL);
        }
    }




    static if(!is(typeof(__SAL_H_VERSION))) {
        private enum enumMixinStr___SAL_H_VERSION = `enum __SAL_H_VERSION = 180000000;`;
        static if(is(typeof({ mixin(enumMixinStr___SAL_H_VERSION); }))) {
            mixin(enumMixinStr___SAL_H_VERSION);
        }
    }




    static if(!is(typeof(_SAL_VERSION))) {
        private enum enumMixinStr__SAL_VERSION = `enum _SAL_VERSION = 20;`;
        static if(is(typeof({ mixin(enumMixinStr__SAL_VERSION); }))) {
            mixin(enumMixinStr__SAL_VERSION);
        }
    }






    static if(!is(typeof(RSIZE_MAX))) {
        private enum enumMixinStr_RSIZE_MAX = `enum RSIZE_MAX = ( 0xffffffffffffffffuL >> 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RSIZE_MAX); }))) {
            mixin(enumMixinStr_RSIZE_MAX);
        }
    }




    static if(!is(typeof(_UI64_MAX))) {
        private enum enumMixinStr__UI64_MAX = `enum _UI64_MAX = 0xffffffffffffffffuL;`;
        static if(is(typeof({ mixin(enumMixinStr__UI64_MAX); }))) {
            mixin(enumMixinStr__UI64_MAX);
        }
    }




    static if(!is(typeof(_I64_MAX))) {
        private enum enumMixinStr__I64_MAX = `enum _I64_MAX = 9223372036854775807L;`;
        static if(is(typeof({ mixin(enumMixinStr__I64_MAX); }))) {
            mixin(enumMixinStr__I64_MAX);
        }
    }




    static if(!is(typeof(_I64_MIN))) {
        private enum enumMixinStr__I64_MIN = `enum _I64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__I64_MIN); }))) {
            mixin(enumMixinStr__I64_MIN);
        }
    }




    static if(!is(typeof(_UI32_MAX))) {
        private enum enumMixinStr__UI32_MAX = `enum _UI32_MAX = 0xffffffffu;`;
        static if(is(typeof({ mixin(enumMixinStr__UI32_MAX); }))) {
            mixin(enumMixinStr__UI32_MAX);
        }
    }




    static if(!is(typeof(_I32_MAX))) {
        private enum enumMixinStr__I32_MAX = `enum _I32_MAX = 2147483647;`;
        static if(is(typeof({ mixin(enumMixinStr__I32_MAX); }))) {
            mixin(enumMixinStr__I32_MAX);
        }
    }




    static if(!is(typeof(_I32_MIN))) {
        private enum enumMixinStr__I32_MIN = `enum _I32_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__I32_MIN); }))) {
            mixin(enumMixinStr__I32_MIN);
        }
    }




    static if(!is(typeof(_UI16_MAX))) {
        private enum enumMixinStr__UI16_MAX = `enum _UI16_MAX = 0xffffu;`;
        static if(is(typeof({ mixin(enumMixinStr__UI16_MAX); }))) {
            mixin(enumMixinStr__UI16_MAX);
        }
    }




    static if(!is(typeof(_I16_MAX))) {
        private enum enumMixinStr__I16_MAX = `enum _I16_MAX = 32767;`;
        static if(is(typeof({ mixin(enumMixinStr__I16_MAX); }))) {
            mixin(enumMixinStr__I16_MAX);
        }
    }




    static if(!is(typeof(_I16_MIN))) {
        private enum enumMixinStr__I16_MIN = `enum _I16_MIN = ( - 32767 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__I16_MIN); }))) {
            mixin(enumMixinStr__I16_MIN);
        }
    }




    static if(!is(typeof(_UI8_MAX))) {
        private enum enumMixinStr__UI8_MAX = `enum _UI8_MAX = 0xff;`;
        static if(is(typeof({ mixin(enumMixinStr__UI8_MAX); }))) {
            mixin(enumMixinStr__UI8_MAX);
        }
    }




    static if(!is(typeof(_I8_MAX))) {
        private enum enumMixinStr__I8_MAX = `enum _I8_MAX = 12;`;
        static if(is(typeof({ mixin(enumMixinStr__I8_MAX); }))) {
            mixin(enumMixinStr__I8_MAX);
        }
    }




    static if(!is(typeof(_I8_MIN))) {
        private enum enumMixinStr__I8_MIN = `enum _I8_MIN = ( - 12 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr__I8_MIN); }))) {
            mixin(enumMixinStr__I8_MIN);
        }
    }




    static if(!is(typeof(MB_LEN_MAX))) {
        private enum enumMixinStr_MB_LEN_MAX = `enum MB_LEN_MAX = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_MB_LEN_MAX); }))) {
            mixin(enumMixinStr_MB_LEN_MAX);
        }
    }






    static if(!is(typeof(NO_COMPETING_THREAD_END))) {
        private enum enumMixinStr_NO_COMPETING_THREAD_END = `enum NO_COMPETING_THREAD_END =
;`;
        static if(is(typeof({ mixin(enumMixinStr_NO_COMPETING_THREAD_END); }))) {
            mixin(enumMixinStr_NO_COMPETING_THREAD_END);
        }
    }




    static if(!is(typeof(NO_COMPETING_THREAD_BEGIN))) {
        private enum enumMixinStr_NO_COMPETING_THREAD_BEGIN = `enum NO_COMPETING_THREAD_BEGIN =
;`;
        static if(is(typeof({ mixin(enumMixinStr_NO_COMPETING_THREAD_BEGIN); }))) {
            mixin(enumMixinStr_NO_COMPETING_THREAD_BEGIN);
        }
    }




    static if(!is(typeof(BENIGN_RACE_END))) {
        private enum enumMixinStr_BENIGN_RACE_END = `enum BENIGN_RACE_END =
;`;
        static if(is(typeof({ mixin(enumMixinStr_BENIGN_RACE_END); }))) {
            mixin(enumMixinStr_BENIGN_RACE_END);
        }
    }




    static if(!is(typeof(BENIGN_RACE_BEGIN))) {
        private enum enumMixinStr_BENIGN_RACE_BEGIN = `enum BENIGN_RACE_BEGIN =
;`;
        static if(is(typeof({ mixin(enumMixinStr_BENIGN_RACE_BEGIN); }))) {
            mixin(enumMixinStr_BENIGN_RACE_BEGIN);
        }
    }
    enum _dpp_impl_CSALCAT2_mixin = ` auto CSALCAT2(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_CSALCAT2_mixin); })) {
        mixin(_dpp_impl_CSALCAT2_mixin);
    }


    enum _dpp_impl_CSALCAT1_mixin = ` auto CSALCAT1(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_CSALCAT1_mixin); })) {
        mixin(_dpp_impl_CSALCAT1_mixin);
    }
    enum _dpp_impl__Swaps_locks__mixin = ` auto _Swaps_locks_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Swaps_locks__mixin); })) {
        mixin(_dpp_impl__Swaps_locks__mixin);
    }


    enum _dpp_impl__Replaces_lock__mixin = ` auto _Replaces_lock_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Replaces_lock__mixin); })) {
        mixin(_dpp_impl__Replaces_lock__mixin);
    }


    enum _dpp_impl__Moves_lock__mixin = ` auto _Moves_lock_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Moves_lock__mixin); })) {
        mixin(_dpp_impl__Moves_lock__mixin);
    }


    enum _dpp_impl__Detaches_lock__mixin = ` auto _Detaches_lock_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Detaches_lock__mixin); })) {
        mixin(_dpp_impl__Detaches_lock__mixin);
    }




    static if(!is(typeof(PDF_MAX_OBJECT_NUMBER))) {
        private enum enumMixinStr_PDF_MAX_OBJECT_NUMBER = `enum PDF_MAX_OBJECT_NUMBER = 8388607;`;
        static if(is(typeof({ mixin(enumMixinStr_PDF_MAX_OBJECT_NUMBER); }))) {
            mixin(enumMixinStr_PDF_MAX_OBJECT_NUMBER);
        }
    }




    static if(!is(typeof(PDF_MAX_GEN_NUMBER))) {
        private enum enumMixinStr_PDF_MAX_GEN_NUMBER = `enum PDF_MAX_GEN_NUMBER = 65535;`;
        static if(is(typeof({ mixin(enumMixinStr_PDF_MAX_GEN_NUMBER); }))) {
            mixin(enumMixinStr_PDF_MAX_GEN_NUMBER);
        }
    }


    enum _dpp_impl__Has_lock_kind__mixin = ` auto _Has_lock_kind_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Has_lock_kind__mixin); })) {
        mixin(_dpp_impl__Has_lock_kind__mixin);
    }




    static if(!is(typeof(_No_competing_thread_end_))) {
        private enum enumMixinStr__No_competing_thread_end_ = `enum _No_competing_thread_end_ =
;`;
        static if(is(typeof({ mixin(enumMixinStr__No_competing_thread_end_); }))) {
            mixin(enumMixinStr__No_competing_thread_end_);
        }
    }




    static if(!is(typeof(_No_competing_thread_begin_))) {
        private enum enumMixinStr__No_competing_thread_begin_ = `enum _No_competing_thread_begin_ =
;`;
        static if(is(typeof({ mixin(enumMixinStr__No_competing_thread_begin_); }))) {
            mixin(enumMixinStr__No_competing_thread_begin_);
        }
    }




    static if(!is(typeof(_Benign_race_end_))) {
        private enum enumMixinStr__Benign_race_end_ = `enum _Benign_race_end_ =
;`;
        static if(is(typeof({ mixin(enumMixinStr__Benign_race_end_); }))) {
            mixin(enumMixinStr__Benign_race_end_);
        }
    }




    static if(!is(typeof(_Benign_race_begin_))) {
        private enum enumMixinStr__Benign_race_begin_ = `enum _Benign_race_begin_ =
;`;
        static if(is(typeof({ mixin(enumMixinStr__Benign_race_begin_); }))) {
            mixin(enumMixinStr__Benign_race_begin_);
        }
    }


    enum _dpp_impl__Analysis_suppress_lock_checking__mixin = ` auto _Analysis_suppress_lock_checking_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Analysis_suppress_lock_checking__mixin); })) {
        mixin(_dpp_impl__Analysis_suppress_lock_checking__mixin);
    }


    enum _dpp_impl__Function_ignore_lock_checking__mixin = ` auto _Function_ignore_lock_checking_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Function_ignore_lock_checking__mixin); })) {
        mixin(_dpp_impl__Function_ignore_lock_checking__mixin);
    }


    enum _dpp_impl__Analysis_assume_same_lock__mixin = ` auto _Analysis_assume_same_lock_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Analysis_assume_same_lock__mixin); })) {
        mixin(_dpp_impl__Analysis_assume_same_lock__mixin);
    }


    enum _dpp_impl__Analysis_assume_lock_not_held__mixin = ` auto _Analysis_assume_lock_not_held_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Analysis_assume_lock_not_held__mixin); })) {
        mixin(_dpp_impl__Analysis_assume_lock_not_held__mixin);
    }


    enum _dpp_impl__Analysis_assume_lock_held__mixin = ` auto _Analysis_assume_lock_held_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Analysis_assume_lock_held__mixin); })) {
        mixin(_dpp_impl__Analysis_assume_lock_held__mixin);
    }


    enum _dpp_impl__Analysis_assume_lock_released__mixin = ` auto _Analysis_assume_lock_released_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Analysis_assume_lock_released__mixin); })) {
        mixin(_dpp_impl__Analysis_assume_lock_released__mixin);
    }


    enum _dpp_impl__Analysis_assume_lock_acquired__mixin = ` auto _Analysis_assume_lock_acquired_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Analysis_assume_lock_acquired__mixin); })) {
        mixin(_dpp_impl__Analysis_assume_lock_acquired__mixin);
    }




    enum _dpp_impl__Lock_level_order__mixin = ` auto _Lock_level_order_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Lock_level_order__mixin); })) {
        mixin(_dpp_impl__Lock_level_order__mixin);
    }


    enum _dpp_impl__Csalcat2__mixin = ` auto _Csalcat2_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Csalcat2__mixin); })) {
        mixin(_dpp_impl__Csalcat2__mixin);
    }


    enum _dpp_impl__Csalcat1__mixin = ` auto _Csalcat1_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Csalcat1__mixin); })) {
        mixin(_dpp_impl__Csalcat1__mixin);
    }


    enum _dpp_impl__Internal_lock_level_order__mixin = ` auto _Internal_lock_level_order_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Internal_lock_level_order__mixin); })) {
        mixin(_dpp_impl__Internal_lock_level_order__mixin);
    }


    enum _dpp_impl__Has_lock_level__mixin = ` auto _Has_lock_level_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Has_lock_level__mixin); })) {
        mixin(_dpp_impl__Has_lock_level__mixin);
    }


    enum _dpp_impl__Create_lock_level__mixin = ` auto _Create_lock_level_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Create_lock_level__mixin); })) {
        mixin(_dpp_impl__Create_lock_level__mixin);
    }


    enum _dpp_impl__Internal_set_lock_count__mixin = ` auto _Internal_set_lock_count_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Internal_set_lock_count__mixin); })) {
        mixin(_dpp_impl__Internal_set_lock_count__mixin);
    }


    enum _dpp_impl__Post_same_lock__mixin = ` auto _Post_same_lock_(A0, A1)(A0 arg0, A1 arg1) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Post_same_lock__mixin); })) {
        mixin(_dpp_impl__Post_same_lock__mixin);
    }


    enum _dpp_impl__Releases_nonreentrant_lock__mixin = ` auto _Releases_nonreentrant_lock_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Releases_nonreentrant_lock__mixin); })) {
        mixin(_dpp_impl__Releases_nonreentrant_lock__mixin);
    }


    enum _dpp_impl__Acquires_nonreentrant_lock__mixin = ` auto _Acquires_nonreentrant_lock_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Acquires_nonreentrant_lock__mixin); })) {
        mixin(_dpp_impl__Acquires_nonreentrant_lock__mixin);
    }


    enum _dpp_impl__Releases_shared_lock__mixin = ` auto _Releases_shared_lock_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Releases_shared_lock__mixin); })) {
        mixin(_dpp_impl__Releases_shared_lock__mixin);
    }


    enum _dpp_impl__Releases_exclusive_lock__mixin = ` auto _Releases_exclusive_lock_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Releases_exclusive_lock__mixin); })) {
        mixin(_dpp_impl__Releases_exclusive_lock__mixin);
    }


    enum _dpp_impl__Releases_lock__mixin = ` auto _Releases_lock_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Releases_lock__mixin); })) {
        mixin(_dpp_impl__Releases_lock__mixin);
    }


    enum _dpp_impl__Acquires_shared_lock__mixin = ` auto _Acquires_shared_lock_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Acquires_shared_lock__mixin); })) {
        mixin(_dpp_impl__Acquires_shared_lock__mixin);
    }


    enum _dpp_impl__Acquires_exclusive_lock__mixin = ` auto _Acquires_exclusive_lock_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Acquires_exclusive_lock__mixin); })) {
        mixin(_dpp_impl__Acquires_exclusive_lock__mixin);
    }


    enum _dpp_impl__Acquires_lock__mixin = ` auto _Acquires_lock_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Acquires_lock__mixin); })) {
        mixin(_dpp_impl__Acquires_lock__mixin);
    }




    enum _dpp_impl__Requires_lock_not_held__mixin = ` auto _Requires_lock_not_held_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Requires_lock_not_held__mixin); })) {
        mixin(_dpp_impl__Requires_lock_not_held__mixin);
    }


    enum _dpp_impl__Requires_shared_lock_held__mixin = ` auto _Requires_shared_lock_held_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Requires_shared_lock_held__mixin); })) {
        mixin(_dpp_impl__Requires_shared_lock_held__mixin);
    }


    enum _dpp_impl__Requires_exclusive_lock_held__mixin = ` auto _Requires_exclusive_lock_held_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Requires_exclusive_lock_held__mixin); })) {
        mixin(_dpp_impl__Requires_exclusive_lock_held__mixin);
    }


    enum _dpp_impl__Requires_lock_held__mixin = ` auto _Requires_lock_held_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Requires_lock_held__mixin); })) {
        mixin(_dpp_impl__Requires_lock_held__mixin);
    }




    enum _dpp_impl__Write_guarded_by__mixin = ` auto _Write_guarded_by_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Write_guarded_by__mixin); })) {
        mixin(_dpp_impl__Write_guarded_by__mixin);
    }


    enum _dpp_impl__Guarded_by__mixin = ` auto _Guarded_by_(A0)(A0 arg0) {
        return ;
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl__Guarded_by__mixin); })) {
        mixin(_dpp_impl__Guarded_by__mixin);
    }






    enum _dpp_impl_PDF_NAME_mixin = ` auto PDF_NAME(A0)(A0 arg0) {
        return ( cast( pdf_obj * ) cast( intptr_t ) PDF_ENUM_NAME_arg0 );
    }`;
    static if(__traits(compiles, { mixin(_dpp_impl_PDF_NAME_mixin); })) {
        mixin(_dpp_impl_PDF_NAME_mixin);
    }




    static if(!is(typeof(PDF_MAKE_NAME))) {
        private enum enumMixinStr_PDF_MAKE_NAME = `enum PDF_MAKE_NAME = ( STRING , NAME ) PDF_ENUM_NAME_ ## NAME ,;`;
        static if(is(typeof({ mixin(enumMixinStr_PDF_MAKE_NAME); }))) {
            mixin(enumMixinStr_PDF_MAKE_NAME);
        }
    }




    static if(!is(typeof(PDF_NULL))) {
        private enum enumMixinStr_PDF_NULL = `enum PDF_NULL = ( cast( pdf_obj * ) cast( intptr_t ) PDF_ENUM_NULL );`;
        static if(is(typeof({ mixin(enumMixinStr_PDF_NULL); }))) {
            mixin(enumMixinStr_PDF_NULL);
        }
    }




    static if(!is(typeof(PDF_TRUE))) {
        private enum enumMixinStr_PDF_TRUE = `enum PDF_TRUE = ( cast( pdf_obj * ) cast( intptr_t ) PDF_ENUM_TRUE );`;
        static if(is(typeof({ mixin(enumMixinStr_PDF_TRUE); }))) {
            mixin(enumMixinStr_PDF_TRUE);
        }
    }




    static if(!is(typeof(PDF_FALSE))) {
        private enum enumMixinStr_PDF_FALSE = `enum PDF_FALSE = ( cast( pdf_obj * ) cast( intptr_t ) PDF_ENUM_FALSE );`;
        static if(is(typeof({ mixin(enumMixinStr_PDF_FALSE); }))) {
            mixin(enumMixinStr_PDF_FALSE);
        }
    }




    static if(!is(typeof(PDF_LIMIT))) {
        private enum enumMixinStr_PDF_LIMIT = `enum PDF_LIMIT = ( cast( pdf_obj * ) cast( intptr_t ) PDF_ENUM_LIMIT );`;
        static if(is(typeof({ mixin(enumMixinStr_PDF_LIMIT); }))) {
            mixin(enumMixinStr_PDF_LIMIT);
        }
    }
}


struct __crt_multibyte_data;
struct __crt_locale_data;
struct fz_display_list;
