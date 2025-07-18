<template>
    <div id="pages_resume">
        <p>你的信息</p>
        <div class="section_1">
            <div class="left">
                <img src="/images/miku.jpg" alt="">
                <p @click="upload_file">上传简历</p>
                <input type="file" id='cs' accept=".pdf,.doc,.docx" @change="handleFileUpload" style="display: none;">
            </div>
            <div class="right">
                <p class="title">个人信息资料</p>
                <p> <em>名字/性别/年龄:</em><em>张三峰/男/32</em></p>
                <p> <em>学校/专业/学历:</em><em>广东科技大学/计算机科学与技术/硕士研究生</em></p>
                <p> <em>技能/证书/面貌:</em><em>编程/英语证书/上山下乡</em></p>
            </div>
        </div>
        <p>{{cs_text}}</p>
          <div class="section_2">
    <Transition name="show_resume" tip="show_estimate_1" mode="out-in">
            <p class="left" v-if="show_resume == 1"><em class="yumao icon-xinxi"></em><em @click="grained_info">点击授权个人简历给系统解析</em> </p>
            <div class="right" v-else-if="show_resume == 2">
                <div class="graph_list">
                    <div id="graph_1"></div>
                </div>
                <div class="other_info">
                    <p><em style="color:#5470C6">蓝色：本科</em><em style="color: #91CC75;">绿线：硕士</em></p>
                    <pre class="gpt">{{gpt_compute}}</pre>
                </div>
            </div>
    </Transition>

            
        </div>
    </div>
</template>

<script setup>
let upload_file = ()=>{
document.getElementById('cs').click();
}
import * as echarts from 'echarts';
import OpenAI from "openai";

const openai = new OpenAI({
        baseURL: 'https://api.deepseek.com',
        apiKey: 'sk-5d0fd45ab4224962a56453d10eb5e8ec',
        dangerouslyAllowBrowser: true 
});
async function streamResponse(question, updateCallback) {
    let fullResponse = '';
    try {
        const stream = await openai.chat.completions.create({
            messages: [{ role: "system", content: question }],
            model: "deepseek-chat",
            stream: true,  // 启用流式响应
        });

        for await (const chunk of stream) {
            const content = chunk.choices[0]?.delta?.content || '';
            // content = content.replace("*",'')
            fullResponse += content;
            fullResponse = fullResponse.replace('*','')
            // 更新回调函数，逐字传递内容
            updateCallback(fullResponse);
            
            // 添加微小延迟使逐字效果更明显
            await new Promise(resolve => setTimeout(resolve, 20));
        }
    } catch (error) {
        console.error('流式请求出错:', error);
        updateCallback('请求出错，请重试');
    }
    
    return fullResponse;
}
let gpt_compute = ref("等待测评结果");
let show_resume = ref(1);
let grenerte_graph = (dom)=>{
setTimeout(() => {
var chartDom = document.getElementById(dom);
console.log(chartDom);
    var myChart = echarts.init(chartDom);
var option;

option = {
//   title: {
//     text: 'Basic Radar Chart'
//   },
//   legend: {
//     data: ['Allocated Budget', 'Actual Spending']
//   },
  radar: {
    // shape: 'circle',
    indicator: [
      { name: '知识水平度', max: 10000 },
      { name: '技能匹配度', max: 10000 },
      { name: '语言表达度', max: 10000 },
      { name: '逻辑思维力', max: 10000 },
      { name: '创新创业力', max: 10000 },
      { name: '应抗压能力', max: 10000 }
    ]
  },
  series: [
    {
      type: 'radar',
      data: [
        {
          value: [3200, 3000, 4000, 4200, 3000, 3500],
          name: '本科阶段'
        },
        {
          value: [6200, 7000, 8000, 7000, 8500, 7000],
          name: '硕士阶段'
        }
      ],
      detail: {
        fontSize: 8,
      }
    }
  ]
};
option && myChart.setOption(option);
}, 1000);

}

let grained_info = async() => {
    show_resume.value = 2;
    grenerte_graph("graph_1");
    await streamResponse('假如你有一份简历，人工智能相关的，评价给出建议，以面试官的口吻，80-120字', (text) => {
            gpt_compute.value = text;
        });
    cs_text.value = "简历解析完成，点击查看图表 🙌";
}


let cs_text = ref("等待测评");


onMounted(() => {
   document.body.style.background = "#F2F2F2";
});
useHead({
  title: "简历测评-大语言模型多模态模拟面试智能体系统",
});
</script>

<style lang="less">
.show_resume-enter-active,
.show_resume-leave-active {
  transition: all 0.3s ease; /* 添加 easing 函数使过渡更平滑 */
}

.show_resume-enter-from,
.show_resume-leave-to {
  opacity: 0;
  filter: blur(1px);
}

#pages_resume{
    #graph_1{
        width: 400px;
        height: 300px;
    }
    #graph_2{
        width: 400px;
        height: 300px;
    }
    width: 100%;
    >p{
        width: 60%;
        margin: 60px auto 0 auto;
        font-size: 20px;
        color: #333;
        font-weight: bold;
    }
    .section_1{
        display: flex;
        width: 60%;
        margin: 20px auto 0 auto;
        background: white;
        height: 200px;
        box-shadow: rgba(0, 0, 0, 0.133) 0px 1.6px 3.6px 0px, rgba(0, 0, 0, 0.11) 0px 0.3px 0.9px 0px;
  .left{
    display: flex;
    flex-direction: column;
    align-items: center;
    border: 1px solid #E0E0E0;
    img{
        width: 120px;
        height: 120px;
        border-radius: 50%;
        margin: 20px;
      }
      p{
        border: 1px solid #010101;
        font-size: 14px;
        padding: 2px 10px;
        border-radius: 2px;
        cursor: pointer;
      }
    }
    .right{
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        font-size: 14px;
        p{
            width: 95%;
            margin-bottom: 10px;
            height: 20px;
            margin-bottom: 18px;
            border-bottom: 1px solid rgb(227, 220, 220);
            em{
                margin-right: 30px;
            }
        }
        
        .title{
            font-size: 16px;
            font-weight: bold;
            color: #333;
            margin-top: 10px;
            height: 25px;
            margin-bottom: 10px;
            width: 95%;
            margin-bottom: 30px;
        }
    }
    }
    .section_2{
        position: relative;
        width: 60%;
        margin: 20px auto 0 auto;
        background: white;
        height: 350px;
        box-shadow: rgba(0, 0, 0, 0.133) 0px 1.6px 3.6px 0px, rgba(0, 0, 0, 0.11) 0px 0.3px 0.9px 0px;
  .left{
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    cursor: pointer;
    }
    .right{
        flex: 1;
        display: flex;
        font-size: 14px;
        .graph_list{
            margin-top: 20px;
            display: flex;
            width: 50%;
            height: 100%;
            align-items: center;
            >div{
                width: 300px;
                height: 300px;
            }
        }
        .other_info{
            margin-top: 20px;
            width: 45%;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            p{
                margin-bottom: 10px;
                em{
                    margin-right: 30px;
                }
            }
        }
        p{
            width: 95%;
            margin-bottom: 10px;
            height: 20px;
            margin-bottom: 18px;
            border-bottom: 1px solid rgb(227, 220, 220);
            em{
                margin-right: 30px;
            }
        }
        pre{
            width: 95.5%;
            white-space: pre-wrap;
            line-height: 23px;
                        border-bottom: 1px solid rgb(255, 255, 255);

        }
        .title{
            font-size: 16px;
            font-weight: bold;
            color: #333;
            margin-top: 10px;
            height: 25px;
            margin-bottom: 10px;
            width: 95%;
            margin-bottom: 30px;
        }
    }
    }
}
</style>