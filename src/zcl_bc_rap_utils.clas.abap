CLASS zcl_bc_rap_utils DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

    PUBLIC SECTION.

        TYPES:
            BEGIN OF ty_s_bapiret2,
              type TYPE bapi_mtype,
              id TYPE symsgid,
              number TYPE symsgno,
              message TYPE bapi_msg,
              log_no TYPE balognr,
              log_msg_no TYPE balmnr,
              message_v1 TYPE symsgv,
              message_v2 TYPE symsgv,
              message_v3 TYPE symsgv,
              message_v4 TYPE symsgv,
              parameter  TYPE bapi_param,
              row        TYPE bapi_line,
              field      TYPE bapi_fld,
              system     TYPE bapilogsys,
            END OF ty_s_bapiret2,

            ty_t_bapiret2 TYPE STANDARD TABLE OF bapiret2.

        TYPES:
            TY_T_ABAP_BEHV_MESSAGES TYPE STANDARD TABLE OF REF TO IF_ABAP_BEHV_MESSAGE WITH DEFAULT KEY.

        CLASS-METHODS:

            msgty_to_severity
                IMPORTING
                    iv_msgty TYPE sy-msgty DEFAULT sy-msgty
                RETURNING
                    VALUE(rv_result) TYPE IF_ABAP_BEHV_MESSAGE=>T_SEVERITY.

        TYPES:
            TY_R_MSGTY TYPE RANGE OF SY-MSGTY.

        CLASS-DATA:
            LR_ERROR_MSGTY TYPE TY_R_MSGTY.

        CLASS-METHODS:
            class_constructor,

            NEW_MESSAGE_FROM_BAPI_T
                IMPORTING
                    iv_abap_behv TYPE REF TO CL_ABAP_BEHV
                    IT_RETURN Type ty_t_bapiret2
                RETURNING
                    VALUE(Rt_RESULT) Type ZCL_BC_RAP_UTILS=>TY_T_ABAP_BEHV_MESSAGES,

            NEW_MESSAGE_FROM_BAPI
                IMPORTING
                    iv_abap_behv TYPE REF TO CL_ABAP_BEHV
                    IS_RETURN Type BAPIRET2
                RETURNING
                    VALUE(RV_RESULT) Type Ref To IF_ABAP_BEHV_MESSAGE,

            NEW_MESSAGE_FROM_SY
                IMPORTING
                    iv_abap_behv TYPE REF TO CL_ABAP_BEHV
                RETURNING
                    VALUE(RV_RESULT) Type Ref To IF_ABAP_BEHV_MESSAGE.

    PROTECTED SECTION.
    PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bc_rap_utils IMPLEMENTATION.

    METHOD CLASS_CONSTRUCTOR.

        LR_ERROR_MSGTY = VALUE #(
            ( SIGN = 'I' OPTION = 'EQ' low = 'E' )
            ( SIGN = 'I' OPTION = 'EQ' low = 'A' )
            ( SIGN = 'I' OPTION = 'EQ' low = 'X' )
        ).

    ENDMETHOD.

    METHOD msgty_to_severity.

        rv_result = cond #(
            when iv_msgty eq 'A' or iv_msgty eq 'X' then if_abap_behv_message=>severity-error
            else conv if_abap_behv_message=>t_severity( iv_msgty )
        ).

    ENDMETHOD.

    METHOD NEW_MESSAGE_FROM_SY.

        rv_result = lcl_rap_messages_helper=>NEW_MESSAGE_FROM_SY(
            EXPORTING
                iv_abap_behv = iv_abap_behv
        ).

    ENDMETHOD.

    METHOD NEW_MESSAGE_FROM_BAPI.

        rv_result = lcl_rap_messages_helper=>new_message_from_bapi(
            EXPORTING
                iv_abap_behv = iv_abap_behv
                is_return = is_return
        ).

    ENDMETHOD.

    METHOD new_message_from_bapi_t.

        rt_result = lcl_rap_messages_helper=>new_message_from_bapi_t(
            EXPORTING
                iv_abap_behv = iv_abap_behv
                it_return = it_return
        ).

    ENDMETHOD.

ENDCLASS.
