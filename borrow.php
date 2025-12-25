<?php
include('include/dbcon.php');

if (isset($_POST['submit'])) {
    $roll_number = $_POST['roll_number'];

    $stmt = $con->prepare("SELECT * FROM user WHERE roll_number = ?");
    $stmt->bind_param("s", $roll_number);
    $stmt->execute();
    $result = $stmt->get_result();
    $count = $result->num_rows;

    if ($count <= 0) {
        $error_message = 'No match found for the Roll Number';
    } else {
        header('Location: borrow_book.php?roll_number=' . urlencode($roll_number));
        exit();
    }
}

include('header.php'); 
?>

<div class="page-title">
    <div class="title_left">
        <h3><small>Home /</small> Borrow</h3>
    </div>
</div>
<div class="clearfix"></div>

<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
            <div class="x_title">
                <div class="clearfix"></div>
            </div>
            <div class="x_content">

                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-3">

                            <?php
                            if (isset($error_message)) {
                                echo "<div class='alert alert-danger'>{$error_message}</div>";
                            }
                            ?>

                            <form method="post" action="">
                                <select name="roll_number" class="select2_single form-control" required="required" tabindex="-1">
                                    <option value="">Select Roll Number</option>
                                    <?php
                                    $result = mysqli_query($con, "SELECT * FROM user") or die(mysqli_error($con));
                                    while ($row = mysqli_fetch_array($result)) {
                                        echo '<option value="' . htmlspecialchars($row['roll_number']) . '">'
                                            . htmlspecialchars($row['roll_number']) . ' - ' . htmlspecialchars($row['firstname'])
                                            . '</option>';
                                    }
                                    ?>
                                </select>
                                <br /><br />
                                <button name="submit" type="submit" class="btn btn-primary" style="margin-left:110px;">
                                    <i class="glyphicon glyphicon-log-in"></i> Submit
                                </button>
                            </form>

                        </div>
                        <div class="col-md-4"></div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<?php include('footer.php'); ?>
