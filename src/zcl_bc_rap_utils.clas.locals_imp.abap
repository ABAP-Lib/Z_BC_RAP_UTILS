*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

class lcl_rap_messages_helper DEFINITION INHERITING FROM CL_ABAP_BEHV.

    PUBLIC SECTION.

        CLASS-METHODS:

            NEW_MESSAGE_FROM_BAPI_T
                IMPORTING
                    iv_abap_behv TYPE REF TO CL_ABAP_BEHV
                    IT_RETURN Type BAPIRET2_T
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

ENDCLASS.

class lcl_rap_messages_helper IMPLEMENTATION.

    METHOD NEW_MESSAGE_FROM_SY .

        rv_result = iv_abap_behv->new_message(
            id = sy-msgid
            number = sy-msgno
            severity = zcl_bc_rap_utils=>msgty_to_severity( )
            v1 = sy-msgv1
            v2 = sy-msgv2
            v3 = sy-msgv3
            v4 = sy-msgv4
        ).

    ENDMETHOD.

    METHOD NEW_MESSAGE_FROM_BAPI .

        rv_result = iv_abap_behv->new_message(
            id = IS_RETURN-id
            number = IS_RETURN-number
            severity = zcl_bc_rap_utils=>msgty_to_severity( IS_RETURN-type )
            v1 = IS_RETURN-message_v1
            v2 = IS_RETURN-message_v2
            v3 = IS_RETURN-message_v3
            v4 = IS_RETURN-message_v4
        ).

    ENDMETHOD.

    METHOD NEW_MESSAGE_FROM_BAPI_T .

        rt_result = VALUE #(
            for r in it_return
                (
                    new_message_from_bapi(
                        EXPORTING
                            iv_abap_behv = iv_abap_behv
                            is_return = r
                    )
                )
        ).

    ENDMETHOD.

ENDCLASS.
