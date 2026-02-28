<template>
  <div>
    <v-card class="pb-5">
      <v-card-title>
        <h2 class="list-title">TODOS</h2>
        <v-spacer></v-spacer>
      </v-card-title>
      <draggable
        class="pl-0"
        v-model="todos"
        :options="{ animation: 200, delay: 50 }"
        @end="atEnd"
        element="ul"
      >
        <li class="todo-list" v-for="todo in todos" :key="todo.sort">
          <v-icon size="30px"
            >mdi-numeric-{{ todo.point }}-circle-outline</v-icon
          >
          <v-hover v-slot:default="{ hover }">
            <v-icon
              @click="openCompleteDialog(todo)"
              size="25px"
              color="yellow"
              v-text="hover ? 'mdi-crown' : 'mdi-crown-outline'"
            >
            </v-icon>
          </v-hover>

          <v-dialog v-model="completeDialog">
            <v-card>
              <v-card-title
                >『{{ selectedItem.title }}』を達成しましたか？</v-card-title
              >
              <v-btn @click="completeItem(selectedItem)">はい</v-btn>
              <v-btn @click="completeDialog = false">いいえ</v-btn>
            </v-card>
          </v-dialog>

          <span class="todo-title">{{ todo.title }}</span>
          <div class="todo-list-icon">
            <v-icon @click="editItem(todo)" color="white" big
              >mdi-pencil</v-icon
            >
            <v-icon @click="deleteDialog = true" color="white">delete</v-icon>
          </div>

          <v-dialog v-model="deleteDialog">
            <v-card>
              <v-card-title>削除しますか？</v-card-title>
              <v-btn @click="deleteItem(todo)">はい</v-btn>
              <v-btn @click="deleteDialog = false">いいえ</v-btn>
            </v-card>
          </v-dialog>
        </li>
      </draggable>
    </v-card>

    <v-dialog class="edit-dialog" v-model="dialog">
      <v-card>
        <v-card-title>
          <h2 class="list-title">ToDo編集</h2>
        </v-card-title>
        <p>やること</p>
        <v-text-field
          class="dialog-title"
          v-model="dialogText.title"
          filled
        ></v-text-field>
        <p>ポイント</p>
        <v-select
          class="dialog-point"
          single-line
          :items="items"
          v-model="dialogText.point"
          :value="dialogText.point"
          filled
        ></v-select>
        <v-btn
          class="update-btn"
          @click="updateItem(dialogText.id, dialogText.title, dialogText.point)"
          >保存</v-btn
        >
      </v-card>
    </v-dialog>

    <v-snackbar v-model="snack" :timeout="3000" :color="snackColor">
      {{ snackText }}
      <v-btn text @click="snack = false">閉じる</v-btn>
    </v-snackbar>
  </div>
</template>

<script>
const maxNumber = 11;
const numberRange = [...Array(maxNumber).keys()];

import axios from "@/plugins/axios";

export default {
  props: ["todos"],
  data() {
    return {
      singleSelect: true,
      selected: [],
      items: numberRange,
      editOn: true,
      snack: false,
      snackColor: "",
      snackText: "",
      dialogText: "",
      dialog: false,
      completeDialog: false,
      deleteDialog: false,
      selectedItem: "",
    };
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    async completeItem(item) {
      const getUser = await axios.get(`/v1/todos/${item.id}`, {
        params: {
          point: item.point
        }
      });
      console.log(getUser);
      const todos = this.user.todos.filter(todo => {
        return todo.id !== item.id;
      });
      this.user.point = getUser.data.user.point;
      this.user.experience_point = getUser.data.user.experience_point;
      this.user.status = getUser.data.user.status;
      const updateUser = {
        user: getUser.data.user,
        todos
      };
      this.$store.commit("setUser", updateUser);
      this.snack = true;
      this.snackColor = "black";
      this.snackText = item.point + "コインを手に入れた";
      this.completeDialog = false;
    },
    async deleteItem(item) {
      await axios.delete(`/v1/todos/${item.id}`); 
      const todos = this.user.todos.filter(todo => {
        return todo.id !== item.id;
      });
      const updateUser = {
        ...this.user,
        todos
      };
      this.$store.commit("setUser", updateUser);
      this.snack = true;
      this.snackColor = "black";
      this.snackText = "削除しました";
      this.deleteDialog = false;
    },
    async editItem(todo) {
      this.dialog = true;
      this.dialogText = todo;
    },
    async updateItem(id, title, point) {
      await axios.patch(`/v1/todos/${id}`, {
        todo: {
          title: title,
          point: point
        }
      });
      this.dialog = false;
    },
    async atEnd() {
      let result = await axios.patch(`v1/todos`, {
        todo: this.todos
      });
      const updateUser = {
        ...this.user,
        todos: this.todos
      };
      this.$store.commit("setUser", updateUser);
    },
    openCompleteDialog(todo) {
      this.completeDialog = true;
      this.selectedItem = todo;
    }
  }
};
</script>

<style lang="scss">
$main-color: #03a9f5 !important;
$sub-color: rgb(11, 214, 236) !important;
$accent-color: red;

@mixin btn {
  background-color: rgb(29, 29, 29) !important;
  border: 2px solid $main-color;
  color: $main-color !important;
  display: inline-block;
  margin: 0px 5% 15px;
  width: 70%;
  font-weight: bold;
}

.list-title {
  color: rgb(6, 6, 201);
}

.v-icon {
  display: flex;
  justify-content: center;
}

.todo-list {
  display: flex;
  list-style: none;
  border-left: solid 8px $sub-color !important;
  border-bottom: solid 2px gray !important;
  border-left: solid 8px yellow !important;
  color: black;
  margin: 10px;
  padding: 10px;
  border: 1px solid #7f7f7f;
  border-radius: 5px;
  background-color: rgb(43, 128, 240);
  cursor: grab;
  .todo-list-icon {
    margin-left: auto;
  }
  .todo-list-btn {
    background-color: white !important;
  }
  .todo-title {
    padding-top: 2px;
    margin-left: 10px;
    max-width: 45%;
  }
  .todo-point {
    color: rgb(236, 11, 97);
    font-weight: bold;
    display: inline-block;
    width: 25px;
    border-radius: center;
    box-shadow: inset 0 0 4px rgba(0, 0, 0, 0.08);
    border-bottom: solid 2px yellow;
  }
}

.v-dialog {
  width: 70%;
  p {
    margin-left: 5%;
  }
  .dialog-title {
    width: 90%;
    margin: 0 auto;
  }
  .dialog-point {
    width: 40%;
    margin-left: 5%;
  }
  .update-btn {
    @include btn;
  }
}

h2 {
  color: $main-color;
}
p {
  font-size: 20px;
  font-weight: bold;
}
</style>
