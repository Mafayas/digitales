
 add_fsm_encoding \
       {calculadora.state} \
       { }  \
       {{000 00} {001 01} {010 10} {011 11} }

 add_fsm_encoding \
       {PB_debouncer.button_state} \
       { }  \
       {{001 00001} {010 00010} {011 00100} {100 01000} {101 10000} }
