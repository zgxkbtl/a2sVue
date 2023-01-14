<script setup>
import { ref } from 'vue'
import { Check, Close } from '@element-plus/icons-vue'
const echoProxy = ref(true)
const randomCallBack = ref(true)
const proxyAddr = ref("")
const callBackAddr = ref("")
const API_URL_PREFIX = 'http://alley.luobotou.org:8000'

async function create(event) {
    const API_URL = API_URL_PREFIX + `/a2s/create`
    const req_body = {
        echoProxy: echoProxy.value,
        randomCallBack: randomCallBack.value,
        proxyAddr: proxyAddr.value,
        callBackAddr: callBackAddr.value,
    }
    const res = await fetch(API_URL, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(req_body)
    })
    console.log(await res.json())
}
</script>

<template>
    
    <span>EchoProxy: </span>
    <el-switch v-model="echoProxy" :active-icon="Check" :inactive-icon="Close" inline-prompt />
    <br/>

    <span>ProxyAddr: </span>
    <el-input v-model="proxyAddr" :disabled="echoProxy" placeholder="Please input" />
    <br/>
    <br/>

    <span>RandomCallBack: </span>
    <el-switch v-model="randomCallBack" :active-icon="Check" :inactive-icon="Close" inline-prompt />
    <br/>

    <span>CallBackAddr: </span>
    <el-input v-model="callBackAddr" :disabled="randomCallBack" placeholder="Please input" />
    
    <el-button type="primary" style="margin-top: 2em;" @click="create">
        create
    </el-button>
    
</template>