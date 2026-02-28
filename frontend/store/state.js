const state = {
  currentUser: {
    user: {
      experience_point: 0,
      status: "初心者"
    },
    todo: {
      point: "",
      title: "",
    },
    reward: {
      point: "",
      title: "",
    },
    todos: [],
    rewards: [],
  },
  loading: false,
  notification: {
    status: false,
    message: ""
  },
  errors: []
}

export default state