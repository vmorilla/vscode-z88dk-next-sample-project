SECTION PAGE_20_CODE
    ; most significative byte (0x14) identifies the page
    ; less significative two bytes (0x0000) identifies where the page will be mapped (in the 64k memory)
    ORG 0x140000
SECTION ALIAS_FOR_PAGE_20_CODE ; if useful some aliases can be added after the org instruction

SECTION PAGE_22_CODE
    ; most significative byte (0x16) identifies the page
    ; less significative two bytes (0x0000) identifies where the page will be mapped (in the 64k memory)
    ORG 0x160000

