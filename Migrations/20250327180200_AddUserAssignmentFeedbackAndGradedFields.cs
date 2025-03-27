using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace JustLearn1.Migrations
{
    /// <inheritdoc />
    public partial class AddUserAssignmentFeedbackAndGradedFields : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Feedback",
                table: "UserAssignments",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsGraded",
                table: "UserAssignments",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "UploadDate",
                table: "AssignmentFiles",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.CreateIndex(
                name: "IX_AssignmentFiles_AssignmentId",
                table: "AssignmentFiles",
                column: "AssignmentId");

            migrationBuilder.AddForeignKey(
                name: "FK_AssignmentFiles_Assignments_AssignmentId",
                table: "AssignmentFiles",
                column: "AssignmentId",
                principalTable: "Assignments",
                principalColumn: "AssignmentID",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AssignmentFiles_Assignments_AssignmentId",
                table: "AssignmentFiles");

            migrationBuilder.DropIndex(
                name: "IX_AssignmentFiles_AssignmentId",
                table: "AssignmentFiles");

            migrationBuilder.DropColumn(
                name: "Feedback",
                table: "UserAssignments");

            migrationBuilder.DropColumn(
                name: "IsGraded",
                table: "UserAssignments");

            migrationBuilder.DropColumn(
                name: "UploadDate",
                table: "AssignmentFiles");
        }
    }
}
