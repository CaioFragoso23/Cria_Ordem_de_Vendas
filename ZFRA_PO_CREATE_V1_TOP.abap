*&---------------------------------------------------------------------*
*& Include          ZFRA_PO_CREATE_V1_TOP
*&---------------------------------------------------------------------*
CONSTANTS: c_x VALUE abap_true.
*--------------------------------------------------------------------*
*--------------Variáveis---------------------------------------------*
*--------------------------------------------------------------------*
DATA: pohead        TYPE bapimepoheader,
      poheadx       TYPE bapimepoheaderx,

      exp_head      TYPE bapimepoheader,

      it_return     TYPE TABLE OF bapiret2,
      it_poitem     TYPE TABLE OF bapimepoitem,
      it_poitemx    TYPE TABLE OF bapimepoitemx,
      it_posched    TYPE TABLE OF bapimeposchedule,
      it_poschedx   TYPE TABLE OF bapimeposchedulx,

      wa_return     TYPE  bapiret2,
      wa_poitem     TYPE  bapimepoitem,
      wa_poitemx    TYPE  bapimepoitemx,
      wa_posched    TYPE  bapimeposchedule,
      wa_poschedx   TYPE  bapimeposchedulx,


      exp_po_number TYPE bapimepoheader-po_number,
      del_date      TYPE sy-datum.

*--------------------------------------------------------------------*
*--------------Tela de Seleção---------------------------------------*
*--------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_matnr TYPE ekpo-matnr,
              p_werks TYPE ekpo-werks,
              p_lgort TYPE ekpo-lgort,
              p_menge TYPE ekpo-menge,
              p_lifnr TYPE ekko-lifnr,
              p_ekorg TYPE ekko-ekorg,
              p_ekgrp TYPE ekko-ekgrp,
              p_bukrs TYPE ekko-bukrs.
SELECTION-SCREEN END OF BLOCK b01.
