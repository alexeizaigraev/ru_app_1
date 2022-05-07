require 'colorize'

require_relative 'papa2'
require_relative 'modules'

class Knigi < Papa2
    include Modules

  def knigiProcess
    vsyo_zapros = file_to_arr(data_in_dir + 'vsyo_zapros_vnesh_otbor.csv')
    head = vsyo_zapros[0]
    data = vsyo_zapros[1...vsyo_zapros.size]
    data.each do |line|
        insert_data = vec_to_hash(head, line)
        shablon =%Q[<?xml version="1.0" encoding="windows-1251" standalone="no"?>
<DECLAR xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="J1311302.xsd">
    <DECLARHEAD>
        <TIN>40243180</TIN>
        <C_DOC>J13</C_DOC>
        <C_DOC_SUB>113</C_DOC_SUB>
        <C_DOC_VER>2</C_DOC_VER>
        <C_DOC_TYPE>0</C_DOC_TYPE>
        <C_DOC_CNT>242</C_DOC_CNT>
        <C_REG>26</C_REG>
        <C_RAJ>50</C_RAJ>
        <PERIOD_MONTH>8</PERIOD_MONTH>
        <PERIOD_TYPE>1</PERIOD_TYPE>
        <PERIOD_YEAR>2019</PERIOD_YEAR>
        <C_STI_ORIG>2650</C_STI_ORIG>
        <C_DOC_STAN>1</C_DOC_STAN>
        <LINKED_DOCS xsi:nil="true"/>
        <D_FILL>29082019</D_FILL>
        <SOFTWARE>CABINET</SOFTWARE>
    </DECLARHEAD>
  <DECLARBODY>
<HKORO>1</HKORO>
<HR>1</HR>
<HKSTI>2650</HKSTI>
<HSTI>ГОЛОВНЕ УПРАВЛІННЯ ДФС У М.КИЄВІ, ДПІ У ГОЛОСІЇВСЬКОМУ РАЙОНІ (ГОЛОСІЇВСЬКИЙ РАЙОН М.КИЄВА)</HSTI>
<HNAME>ТОВАРИСТВО З ОБМЕЖЕНОЮ ВIДПОВIДАЛЬНIСТЮ "ЕЛЕКТРУМ ПЕЙМЕНТ СІСТЕМ"</HNAME>
<HTIN>40243180</HTIN>
<R0301G1S>#{insert_data['fiscal_number']}</R0301G1S>
<R0302G1>420</R0302G1>
<R0302G1S>#{insert_data['model']}</R0302G1S>
<R0303G1S>#{insert_data['serial_number']}</R0303G1S>
<R0304G1>1014</R0304G1>
<R0304G1S>#{insert_data['soft']}</R0304G1S>
<R0307G1S>#{insert_data['rne_rro']}</R0307G1S>
<R0401G1S>Відділення №#{insert_data['Терминалы.department']}</R0401G1S>
<R0402G1S>#{insert_data['address']}</R0402G1S>
<R0403G1>#{insert_data['koatu']}</R0403G1>
<R0404G1S>#{insert_data['tax_id']}</R0404G1S>
<R0501G1>832</R0501G1>
<R0501G1S>ГУ ДПС У ЧЕРНІГІВСЬКІЙ ОБЛАСТІ</R0501G1S>
<R0601G1S>#{insert_data['fiscal_number']}</R0601G1S>
<R0601G2S>#{insert_data['oro_number']}</R0601G2S>
<R0602G1S>#{insert_data['oro_serial']}</R0602G1S>
<R0603G1>40</R0603G1>
<M01>1</M01>
<HKBOS>2903722436</HKBOS>
<HBOS>ПОЖАРСЬКИЙ ВЯЧЕСЛАВ ЮХИМОВИЧ</HBOS>
<HFILL>#{now_date_kabinet}</HFILL>
<HZ>1</HZ>
    <HZM>7</HZM>
    <HMONTH>7</HMONTH>
    <HZY>2019</HZY>
  </DECLARBODY>
</DECLAR>]

    ofname = kabinet_out_dir + 'knigi_' + insert_data['Терминалы.department'] + '_' + insert_data['serial_number'] + '.xml'
    text_to_file_kabinet(shablon, ofname)
    end

  end

end

x = Knigi.new
x.knigiProcess
