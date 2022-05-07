require 'colorize'

require_relative 'papa2'
require_relative 'modules'

class Otmena < Papa2
    include Modules

  def otmenaProcess
    vsyo_zapros = file_to_arr(data_in_dir + 'vsyo_zapros_vnesh_otbor.csv')
    head = vsyo_zapros[0]
    data = vsyo_zapros[1...vsyo_zapros.size]
    data.each do |line|
        insert_data = vec_to_hash(head, line)
        shablon =%Q[<?xml version="1.0" encoding="windows-1251" standalone="no"?>
<DECLAR xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="J1313602.xsd">
    <DECLARHEAD>
        <TIN>40243180</TIN>
        <C_DOC>J13</C_DOC>
        <C_DOC_SUB>136</C_DOC_SUB>
        <C_DOC_VER>2</C_DOC_VER>
        <C_DOC_TYPE>0</C_DOC_TYPE>
        <C_DOC_CNT>541</C_DOC_CNT>
        <C_REG>26</C_REG>
        <C_RAJ>50</C_RAJ>
        <PERIOD_MONTH>5</PERIOD_MONTH>
        <PERIOD_TYPE>1</PERIOD_TYPE>
        <PERIOD_YEAR>2020</PERIOD_YEAR>
        <C_STI_ORIG>2650</C_STI_ORIG>
        <C_DOC_STAN>1</C_DOC_STAN>
        <LINKED_DOCS xsi:nil="true"/>
        <D_FILL>17052020</D_FILL>
        <SOFTWARE>CABINET</SOFTWARE>
    </DECLARHEAD>
  <DECLARBODY>
<HKSTI>2650</HKSTI>
<HSTI>ГОЛОВНЕ УПРАВЛІННЯ ДФС У М.КИЄВІ, ДПІ У ГОЛОСІЇВСЬКОМУ РАЙОНІ (ГОЛОСІЇВСЬКИЙ РАЙОН М.КИЄВА)</HSTI>
<HNAME>ТОВАРИСТВО З ОБМЕЖЕНОЮ ВIДПОВIДАЛЬНIСТЮ "ЕЛЕКТРУМ ПЕЙМЕНТ СІСТЕМ"</HNAME>
<HTIN>40243180</HTIN>
<R001G1S>#{insert_data['ticket_number']}</R001G1S>
<R002G1S>#{insert_data['serial_number']}</R002G1S>
<R003G1>451</R003G1>
<R003G1S>#{insert_data['model']}</R003G1S>
<R004G1>1013</R004G1>
<R004G1S>#{insert_data['soft']}</R004G1S>
<R007G1S>#{insert_data['rne_rro']}</R007G1S>
<R008G1S>#{insert_data['address']}</R008G1S>
<R009G1>#{insert_data['koatu']}</R009G1>
<R010G1S>#{insert_data['tax_id']}</R010G1S>
<R011G1S>закриття відділення</R011G1S>
<R012G1S>#{insert_data['fiscal_number']}</R012G1S>
<M03>1</M03>
<M04>1</M04>
<HKBOS>2903722436</HKBOS>
<HBOS>ПОЖАРСЬКИЙ ВЯЧЕСЛАВ ЮХИМОВИЧ</HBOS>
<HFILL>#{now_date_kabinet()}</HFILL>
<HZ>1</HZ>
    <HZM>2</HZM>
    <HMONTH>2</HMONTH>
    <HZY>2020</HZY>
  </DECLARBODY>
</DECLAR>]

    ofname = kabinet_out_dir + 'otmena_' + insert_data['Терминалы.department'] + '_' + insert_data['serial_number'] + '.xml'
    text_to_file_kabinet(shablon, ofname)
    end
    
  end

end

x = Otmena.new
x.otmenaProcess
