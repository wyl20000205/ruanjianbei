<template>
    <div id="pages_skill">
        <p class="title">你的信息</p>
        <p><em>张三峰</em><em>男</em><em>32岁</em><em>硕士</em><em>广东科技大学</em><em>计算机科学与技术专业</em><em>图像去噪优化算法方向</em></p>
        <p class="title">{{cs_text}}</p>
        <div class="section_2">
          <div>
           <p style="margin-bottom: 6px;">Python 快速入门</p>
           <iframe src="//player.bilibili.com/player.html?isOutside=true&aid=549131816&bvid=BV1mq4y137p6&cid=442820444&p=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"></iframe>
          </div>
            <div>
           <p style="margin-bottom: 6px;">前端 快速入门</p>
           <iframe src="//player.bilibili.com/player.html?isOutside=true&aid=549131816&bvid=BV1mq4y137p6&cid=442820444&p=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"></iframe>
          </div>
            <div>
           <p style="margin-bottom: 6px;">后端 快速入门</p>
           <iframe src="//player.bilibili.com/player.html?isOutside=true&aid=549131816&bvid=BV1mq4y137p6&cid=442820444&p=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"></iframe>
          </div>
          <div>
           <p style="margin-bottom: 6px;">GO 快速入门</p>
           <iframe src="//player.bilibili.com/player.html?isOutside=true&aid=549131816&bvid=BV1mq4y137p6&cid=442820444&p=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"></iframe>
          </div>
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
    await streamResponse('假如在面试，你是面试官，以面试官的口吻评价你的面试者常见微表情、肢体语言分析结果和建议，添加少量emoji,不要出现字数，130-200字', (text) => {
            gpt_compute.value = text;
        });
    cs_text.value = "简历解析完成，点击查看图表 🙌";
}


let cs_text = ref("课程技能训练 针对性爬取内容🥲");


onMounted(() => {
   document.body.style.background = "#F2F2F2";
});
useHead({
  title: "课程技能-大语言模型多模态模拟面试智能体系统",
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

#pages_skill{
    #graph_1{
        width: 400px;
        height: 300px;
    }
    #graph_2{
        width: 400px;
        height: 300px;
    }
    width: 100%;
    .title{
        width: 60%;
        margin: 60px auto 0 auto;
        font-size: 20px;
        color: #333;
        font-weight: bold;
    }
     >p:nth-of-type(2){
        width: 60%;
        margin: 30px auto 0 auto;
        font-size: 16px;
        font-weight: bold;
        em{
            margin-right: 30px;
        }
    }
   
    .section_2{
      flex-wrap: wrap;
      display: flex;
        width: 60%;
        margin: 20px auto 0 auto;
        max-height: 500px;
        overflow-y: auto;
        >div{
          margin-right: 50px;
          margin-bottom: 30px;
        }
        >p{
            display: flex;
            flex-direction: column;
            margin-bottom: 8px;
        }
        .timu{
            margin-bottom: 8px;
            font-size: 18px;
        }
        .daan{
            color: rgb(98, 91, 91);
            margin-right: 20px;
        }
  
    }
}
</style>