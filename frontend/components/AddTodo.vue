<template>
  <v-form>
    <v-container class="add-todo">
      <v-row>
        <v-col class="pr-0" cols="3" xs="6" sm="2" md="2" lg="2">
          <v-select
            label="TP"
            v-model="point"
            :items="items"
            outlined
          ></v-select>
        </v-col>
        <v-col class="pr-0" cols="9" xs="8" sm="8" md="8" lg="8">
          <v-text-field
            v-model="title"
            :rules="[v => !!v || 'まだまだいけるよ！']"
            :counter="15"
            label="やるべきこと"
            required
            outlined
          ></v-text-field>
        </v-col>
        <v-col class="pr-0" cols="12" xs="2" sm="2" md="2" lg="2">
          <v-btn class="todo-btn" @click="handleSubmit">
            登録
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>

<script>
const maxNumber = 11;
const numberRange = [...Array(maxNumber).keys()];

export default {
  props: ["todo"],
  data() {
    return {
      items: numberRange,
      title: "",
      point: ""
    };
  },
  methods: {
    handleSubmit() {
      const todo = {
        title: this.title,
        user_id: this.$store.state.currentUser.user.id,
        point: this.point
      };
      this.$emit("submit", todo);
      this.title = "";
      this.point = "";
    }
  }
};
</script>

<style lang="scss">
$main-color: #03a9f5 !important;
$sub-color: rgb(11, 214, 236) !important;

@mixin btn {
  background-color: white;
  border: 2px solid white;
  color: white;
  display: inline-block;
  font-weight: bold;
  margin: 15px;
  width: 93%;
}

.add-todo {
  .todo-btn {
    @include btn;

    &:hover {
      border: 2px solid $sub-color;
      color: $main-color;
    }
  }
}

.col-md-4 > .bt {
  color: white;
  padding: 10px 40px !important;
  border: 2px solid white;
}
</style>
