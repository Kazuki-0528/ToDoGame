<template>
  <v-container class="user-page" v-if="currentUser">
    <Status />
    <v-row justify="center">
      <v-col class="pb-0" cols="12" xs="12" sm="12" md="12" lg="8">
        <div>
          <AddTodo @submit="addTodo" />
        </div>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="12" xs="12" sm="12" md="12" lg="8">
        <div>
          <TodoList :todos="currentUser.todos" />
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import AddTodo from "@/components/AddTodo";
import TodoList from "@/components/TodoList";
import Status from "@/components/Status";
import axios from "@/plugins/axios";

export default {
  data() {
    return {
      email: "",
      name: "",
      level: "",
      point: "",
      experience_point: "",
      show1: false,
      show2: false,
      error: "",
      showContent: false,
      unwatchCurrentUser: null
    };
  },
  watch: {
    currentUser: {
      immediate: true,
      handler(newUser) {
        if (!newUser) {
          this.$router.replace("/login");
        }
      }
    }
  },
  components: {
    AddTodo,
    TodoList,
    Status,
  },
  computed: {
    currentUser() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    async addTodo(todo) {
      try {
        const { data } = await axios.post("/v1/todos", {
          todo
        });
        console.log(this.currentUser);
        const userTodo = this.currentUser.todos ? this.currentUser.todos : [];
        this.$store.commit("setUser", {
          ...this.currentUser,
          todos: [...userTodo, data]
        });
        this.$store.commit("clearErrors");
      } catch (error) {
        console.log("UserPage: 110", error);
        const { data } = error.response;
        this.$store.commit("setError", data.error_msg);
      }
    }
  }
};
</script>

<style lang="scss">
$main-color: #03a9f5 !important;
$sub-color: rgb(11, 214, 236) !important;
$accent-color: red;

$pc: 1024px;
$tab: 680px;
$sp: 480px;

@mixin pc {
  @media (max-width: ($pc)) {
    @content;
  }
}

@mixin tab {
  @media (max-width: ($tab)) {
    @content;
  }
}
@mixin sp {
  @media (max-width: ($sp)) {
    @content;
  }
}

.user-page {
  .user-status {
    @include pc {
      width: 100%;
    }
    @include tab {
      width: 100% !important;
    }
    @include sp {
      width: 100% !important;
    }
  }
}
</style>
