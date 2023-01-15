<script setup>
import { ref, onMounted, watch  } from 'vue'
import A2SCreatorVue from './components/A2SCreator.vue';
const API_URL = "https://alley.luobotou.org:8000"

const tableData = ref([])
const drawer = ref(false)
const requestUrl = ref(API_URL + '/a2s/request/')

const refreshList = async () => {
  const item = await (await fetch(API_URL + '/a2s/list')).json()
  console.log(item)
  tableData.value = item
}

watch(drawer, refreshList)

onMounted(async () => {
  console.log(`the list component is now mounted.`)
  await refreshList()
})

const deleteById = async (id) => {
  await fetch(API_URL + '/a2s/delete/?' + 'req_id=' + id.requestID)
  console.log(id.requestID)
  await refreshList()
}

</script>


<template>
  <div class="common-layout">
    <el-container>
      <el-header>
        <el-button type="primary" style="margin-left: 16px" @click="drawer = true">
          create
        </el-button>
      </el-header>
      <el-main>
        <el-scrollbar>
          <el-table :data="tableData">
            <el-table-column prop="expire" label="Expire" width="140" />
            <!-- <el-table-column prop="callBackAddr" label="CallBack" /> -->
            <el-table-column prop="proxyAddr" label="ProxyAddr" />
            <el-table-column prop="requestID" label="Address" >
              <template #default="scope">
                {{ requestUrl + scope.row.requestID }}
              </template>
            </el-table-column>
            <el-table-column prop="requestID" label="Address">
              <template #default="scope">
                <el-button type="danger" @click="deleteById(scope.row)">delete</el-button>
              </template>
            </el-table-column>
            
          </el-table>
        </el-scrollbar>
        <el-drawer v-model="drawer" title="I am the title" :with-header="false" size="50%">
          <span>######Create New#######</span>
          <div>
            <A2SCreatorVue @isCreated="drawer = false"></A2SCreatorVue>
          </div>
        </el-drawer>
      </el-main>
    </el-container>
  </div>
</template>

<style scoped>
.layout-container-demo .el-header {
  position: relative;
  background-color: var(--el-color-primary-light-7);
  color: var(--el-text-color-primary);
}
.layout-container-demo .el-menu {
  border-right: none;
}
.layout-container-demo .el-main {
  padding: 0;
}
.layout-container-demo .toolbar {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  right: 20px;
}
</style>