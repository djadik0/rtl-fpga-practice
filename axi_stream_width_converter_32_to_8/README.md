# AXI-Stream Width Converter 32-to-8

## Цель работы

Реализовать и проверить модуль `axi_stream_width_converter_32_to_8` на `SystemVerilog`.

## Краткое описание

В проекте реализован простой AXI-Stream width converter, который принимает одно 32-битное слово на входном AXI-Stream интерфейсе и выдаёт его как последовательность из четырёх 8-битных слов на выходном AXI-Stream интерфейсе.

Модуль использует стандартную handshake-логику `valid/ready`.

## Принцип работы

На вход подаётся 32-битное слово через сигналы:

- `s_axis_tdata`
- `s_axis_tvalid`
- `s_axis_tready`

После принятия входного слова модуль последовательно выдаёт 4 байта через выходной интерфейс:

- `m_axis_tdata`
- `m_axis_tvalid`
- `m_axis_tready`

Порядок выдачи байтов: от младшего байта к старшему.

Например, для слова:

```text
32'hAABBCCDD
```

на выходе формируется последовательность:

```text
DD CC BB AA
```

## Что реализовано

В модуле реализованы:

- приём 32-битного слова по AXI-Stream;
- сохранение входного слова во внутренний регистр;
- последовательная выдача четырёх 8-битных частей;
- поддержка `m_axis_tready`;
- остановка передачи, если выходной интерфейс не готов;
- возврат в состояние ожидания после передачи всех байтов.

## Что проверялось в testbench

В testbench проверялись следующие сценарии:

- передача слова `32'h11223344`;
- передача слова `32'hAABBCCDD`;
- передача слова `32'hDEADBEEF`;
- проверка работы при паузе на выходе через `m_axis_tready = 0`;
- корректное удержание данных при backpressure.

## Waveform

На waveform видно, как входное 32-битное слово принимается по `s_axis_*`, после чего на выходе `m_axis_tdata` последовательно появляются 8-битные части слова. Также показана работа backpressure через сигнал `m_axis_tready`.

![AXI-Stream Width Converter waveform](./waveform_axi_stream_width_converter_32_to_8.png)

## Результат работы

В результате был реализован и проверен AXI-Stream width converter из 32 бит в 8 бит.  
Моделирование показало корректную работу `valid/ready` handshake и последовательную выдачу байтов.

## Вывод

В ходе выполнения проекта был реализован простой потоковый модуль на `SystemVerilog`.  
Проект демонстрирует работу с AXI-Stream интерфейсом, сигналами `valid/ready`, backpressure и преобразованием ширины данных.

### Файлы

- [axi_stream_width_converter_32_to_8.sv](./rtl/axi_stream_width_converter_32_to_8.sv)
- [tb_axi_stream_width_converter_32_to_8.sv](./tb/tb_axi_stream_width_converter_32_to_8.sv)
- [waveform_axi_stream_width_converter_32_to_8.png](./waveform_axi_stream_width_converter_32_to_8.png)
