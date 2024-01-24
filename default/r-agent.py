'''
[HONGZHANG LIU 20240121]
openai.api.key = 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（该key已作废）
---
prompt:
我正在玩一款叫做screeps的游戏，帮我用js生成一段代码，完成在module.exports.loop = function中完成以下内容：当开采者不足两个时，生成开采者。让开采者采集从最近能量点进行采集，并运回到基地。注意只回复代码内容module.exports.loop中代码内容，我需要直接粘贴代码，不要回复任何和代码无关的信息。
'''

import os
import re
from openai import OpenAI
client = OpenAI(
    # This is the default and can be omitted
    api_key=os.environ.get("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"), # 进gd的时候直接传参进来
)

file_path = 'requirement.txt'
with open(file_path, 'r', encoding='utf-8') as file:
  initial_requirement = file.read()

log_file_path = 'console_log.txt' #
main_js_path = 'main.js'

error_content = None
main_js_code = None

# 正则
with open(log_file_path, 'r', encoding='utf-8') as log_file:
    log_content = log_file.read()
    error_pattern = r"IT HAS ERROR: 'error'.*?(?=\n)" # 正则方式需要根据具体输出形式匹配
    error_match = re.search(error_pattern, log_content)
    if error_match:
        error_content = error_match.group(0).strip()  # 获取错误内容
        # 既然我们捕获到了错误，现在提取 main.js 的代码
        with open(main_js_path, 'r', encoding='utf-8') as code_file:
            main_js_code = code_file.read()

# 清空console_log文件的内容，避免反复使用
if error_content:
    open(log_file_path, 'w').close()

messages = [
    {
      "role": "system",
      "content": "我正在玩一款叫做'Screeps World' 的游戏，请根据我的需求写js代码。切记只回复代码内容module.exports.loop中代码内容，我需要直接粘贴代码，不要回复任何和代码无关的信息。"
    },
    {
      "role": "user",
      "content": initial_requirement
    }
]

# 只在提取到了错误的情况下，才吧错误信息和main.js的代码打入response
if error_content and main_js_code:
    error_msg = f"我现在的代码是{main_js_code}，但我收到了console的报错提醒如下，请帮我更正：{error_content}"
    messages.append({
      "role": "user",
      "content": error_msg
    })

# 创建完成请求，并将构建的消息列表传递给它
response = client.chat.completions.create(
  model="gpt-3.5-turbo-1106",
  response_format={ "type": "text" },
  messages=messages
)

# 输出响应内容
print(response.choices[0].message.content)  # 此内容应传递到GoDot端，注意正则化提出

# Testing - 检测gpt视角内容
print("将发送的消息内容：")
for msg in messages:
    print(f"{msg['role'].title()}: {msg['content']}\n")
