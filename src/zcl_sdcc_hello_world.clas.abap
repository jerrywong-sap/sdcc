CLASS zcl_sdcc_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sdcc_hello_world IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( 'Week 1' )->write( 'Hello World from SAP Developer Code Challenge' ) ##NO_TEXT.

  ENDMETHOD.
ENDCLASS.
