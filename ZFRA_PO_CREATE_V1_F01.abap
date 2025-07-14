*&---------------------------------------------------------------------*
*& Include          ZFRA_PO_CREATE_V1_F01
*&---------------------------------------------------------------------*

*--------------------------------------------------------------------*
* Cabeçalho do Documento de Compras - EKKO
pohead-comp_code = p_bukrs. " Centro
pohead-doc_type = 'NB'.    " Tipo de Documento de Vendas
pohead-creat_date = sy-datum.

pohead-vendor = p_lifnr. "Fornecedor
pohead-purch_org = p_ekorg. " Organização de Compras
pohead-pur_group = p_ekgrp. " Grupo de Compras

pohead-langu = sy-langu.
pohead-doc_date = sy-datum.

*--------------------------------------------------------------------*
" Indicando quais campos vão ser atualizados para a função
poheadx-comp_code  = c_x.
poheadx-doc_type   = c_x.
poheadx-creat_date = c_x.
poheadx-vendor     = c_x.
poheadx-purch_org  = c_x.
poheadx-pur_group  = c_x.
poheadx-langu      = c_x.
poheadx-doc_date   = c_x.
"
*--------------------------------------------------------------------*
* Item do Documento de Compras - EKPO
wa_poitem-po_item = 1.
wa_poitem-material = p_matnr. " Material
wa_poitem-plant    = p_werks. " Centro
wa_poitem-stge_loc = p_lgort. " Depósito
wa_poitem-quantity = p_menge. " Quantidade
APPEND wa_poitem TO it_poitem. " Append pois são vários itens
CLEAR wa_poitem.
*--------------------------------------------------------------------*
"Indicando quais campos vão ser atualizados para a função
wa_poitemx-po_item    = 1.
wa_poitemx-po_itemx   = c_x.
wa_poitemx-material   = c_x.
wa_poitemx-plant      = c_x .
wa_poitemx-stge_loc   = c_x .
wa_poitemx-quantity   = c_x .
wa_poitemx-tax_code   = c_x .
wa_poitemx-item_cat   = c_x .
wa_poitemx-acctasscat = c_x .
append wa_poitemx TO it_poitemx.
CLEAR wa_poitemx.
"
*--------------------------------------------------------------------*
* Data de entrega do item do documento de compras
wa_posched-po_item = 1.                     "Item do documento de compras
wa_posched-sched_line = 1.                  "Divisão da Remessa
wa_posched-del_datcat_ext = 'D'.            "Tipo de Data de Remessa
del_date = sy-datum + 30.                   "Pra entregar amanhã por exemplo
WRITE del_date to wa_posched-delivery_date. "Escrever um tipo sy-datum para um tipo CHAR10
wa_posched-deliv_time = '103000'.           "Tempo de Entrega
wa_posched-quantity   = p_menge.            "Quantidade de tal item
APPEND wa_posched TO it_posched.            "Append poís é a entrega de CADA item.
CLEAR wa_posched.
*--------------------------------------------------------------------*
"Indicando a função quais campos vão ser atualizados
wa_poschedx-po_item        = 1. "Caso tenha outros itens passar uma tabela
wa_poschedx-sched_line     = 1.
wa_poschedx-po_itemx       = c_x.
wa_poschedx-sched_linex    = c_x.
wa_poschedx-del_datcat_ext = c_x.
wa_poschedx-delivery_date  = c_x.
wa_poschedx-quantity       = c_x.
APPEND wa_poschedx TO it_poschedx.
CLEAR wa_posched.
"
*--------------------------------------------------------------------*
CALL FUNCTION 'BAPI_PO_CREATE1'
  EXPORTING
    poheader         = pohead
    poheaderx        = poheadx
    testrun          = abap_true
  IMPORTING
    exppurchaseorder = exp_po_number
    expheader        = exp_head
  TABLES
    return           = it_return
    poitem           = it_poitem
    poitemx          = it_poitemx
    poschedule       = it_posched
    poschedulex      = it_poschedx
  .
cl_demo_output=>display( pohead ).
cl_demo_output=>display( it_return ).
cl_demo_output=>display( it_poitem ).
cl_demo_output=>display( it_posched ).

CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
 EXPORTING
   WAIT          = c_x
          .

CALL FUNCTION 'DEQUEUE_ALL'.
          .
